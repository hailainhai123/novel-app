import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:novel_app_client/arbe_module/api/custom_log.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../utils/utils.dart';

class AuthenticationHelper {
  static AuthenticationHelper? _instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthenticationHelper._init();

  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static AuthenticationHelper get instance {
    _instance ??= AuthenticationHelper._init();

    return _instance!;
  }

  Future handleGoogleSignIn(
    Function(User) callback,
    Function(String) errorCallback,
  ) async {
    // final GoogleSignInAccount googleUser = (await _googleSignIn
    //     .signIn()
    //     .onError((error, stackTrace) => errorCallback(error.toString())))!;

    final googleSignInfo = await _googleSignIn
        .signIn()
        .onError((error, stackTrace) => errorCallback(error.toString()));

    if (googleSignInfo == null) return errorCallback("lỗi bất thường");

    final GoogleSignInAuthentication googleAuth = await googleSignInfo
        .authentication
        .onError((error, stackTrace) => errorCallback(error.toString()));

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final User user = (await _auth.signInWithCredential(credential)).user!;

    await FirebaseAuth.instance.signInWithCredential(credential);
    return callback(user);
  }

  Future handleGoogleSignOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  Future signInWithApple(Function(UserCredential) callback) async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      // Sign in the user with Firebase. If the nonce we generated earlier does
      // not match the nonce in `appleCredential.identityToken`, sign in will fail.
      UserCredential detail =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      return callback(detail);
    } catch (e) {
      CustomLog.log(e.toString());
    }
  }

  Future signInWithFacebook(Function(UserCredential?) callback) async {
    await FacebookAuth.instance.logOut();
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login(
        permissions: ['public_profile', 'email'],
        loginBehavior: LoginBehavior.nativeWithFallback,
      );

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      UserCredential detail = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      return callback(detail);
    } on FirebaseAuthException catch (e) {
      CustomLog.log(e.code);
      Utils.showError(
          'Email đã được dùng bới phương thức đăng nhập khác, vui lòng chọn đăng nhập bằng google',
          'Lỗi');
      return callback(null);
    }
  }

  void createUserWithEmailAndPassword(String email, String password,
      void Function(bool succes, String response) callback) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return callback(true, userCredential.user!.email!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return callback(false, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return callback(false, 'The account already exists for that email.');
      }
    } catch (e) {
      return callback(false, "Vui lòng nhập đúng email");
    }
  }

  void signInWithEmailAndPassword(String email, String pass,
      void Function(bool success, String response) callback) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      return callback(
          true, "Đăng nhập thành công ${userCredential.user!.email!}");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return callback(false, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return callback(false, 'Wrong password provided for that user.');
      }
    }
  }

  void getPassword(String email, Function(String) callback) async {
    _auth.sendPasswordResetEmail(email: email).then((value) async {
      return await callback("Đã gửi thư đổi mật khẩu vào email");
    }).onError((error, stackTrace) async {
      return await callback("Lỗi bất thường");
    });
  }

//  void getLoginInDevice(Function(bool) callback) async{
//   return await callback(CachedDataManager.instance.getLanguage());
// }
}
