// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
//
// class ArbeDynamicLink {
//   static Future<Uri> getDynamicLink({
//     String path = "",
//     bool isShorUrl = true,
//     required String title,
//     required String desc,
//     required Uri imageUrl,
//   }) async {
//     final DynamicLinkParameters parameters = DynamicLinkParameters(
//       uriPrefix: 'https://lolynovel.page.link',
//       link: Uri.parse('https://lolynovel.com/$path'),
//       androidParameters: AndroidParameters(
//         packageName: 'com.lolynovel.story',
//         minimumVersion: 1,
//       ),
//       iosParameters: IosParameters(
//         bundleId: 'com.lolynovel.story',
//         minimumVersion: '1.0.1',
//         appStoreId: '123456789',
//       ),
//       socialMetaTagParameters: SocialMetaTagParameters(
//         title: title,
//         description: desc,
//         imageUrl: imageUrl,
//       ),
//     );
//
//     if (isShorUrl) {
//       final shortUrl = await parameters.buildShortLink();
//       return shortUrl.shortUrl;
//     }
//
//     return await parameters.buildUrl();
//   }
// }
