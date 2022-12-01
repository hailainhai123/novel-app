import 'package:get_storage/get_storage.dart';
import 'package:novel_app_client/models/user_infomation.dart';

final _userBox = () => GetStorage();

class UserPref {
  void call() {
    _userBox.call().initStorage;
  }

  dynamic setValueInt(String key, int value) {
    return 0.val(key, getBox: _userBox).val = value;
  }

  String setValue(String key, String value) {
    return ''.val(key, getBox: _userBox).val = value;
  }

  dynamic getValueInt(String key) {
    return (-1).val(key, getBox: _userBox).val;
  }

  dynamic getValue(String key) {
    return ''.val(key, getBox: _userBox).val;
  }

  void setUser(UserInformation user) {
    ''.val('id', getBox: _userBox).val = user.id ?? "";
    ''.val('email', getBox: _userBox).val = user.email ?? '';
    ''.val('displayName', getBox: _userBox).val = user.displayName ?? '';
    ''.val('photoURL', getBox: _userBox).val = user.photoURL ?? "";
    true.val('disabled', getBox: _userBox).val = user.disabled ?? false;
    true.val('emailVerified', getBox: _userBox).val =
        user.emailVerified ?? false;
    ''.val('firebaseToken', getBox: _userBox).val = user.firebaseToken ?? "";
  }

  UserInformation getUser() {
    final String id = ''.val('id', getBox: _userBox).val;
    final String email = ''.val('email', getBox: _userBox).val;
    final String displayName = ''.val('displayName', getBox: _userBox).val;
    final String photoURL = ''.val('photoURL', getBox: _userBox).val;
    final bool disabled = true.val('disabled', getBox: _userBox).val;
    final bool emailVerified = true.val('emailVerified', getBox: _userBox).val;
    final String firebaseToken = ''.val('firebaseToken', getBox: _userBox).val;

    return UserInformation(
        id: id,
        email: email,
        emailVerified: emailVerified,
        displayName: displayName,
        disabled: disabled,
        firebaseToken: firebaseToken,
        photoURL: photoURL);
  }
}
