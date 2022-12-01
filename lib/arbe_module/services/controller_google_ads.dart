// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:novel_project/arbe_module/utils/custom_log.dart';
//
// class ControllerGoogleAds {
//   static ControllerGoogleAds? _instance;
//
//   ControllerGoogleAds._internal();
//
//   static ControllerGoogleAds get instance {
//     if (_instance == null) {
//       _instance = ControllerGoogleAds._internal();
//     }
//
//     return _instance!;
//   }
//
//   late MobileAds ads;
//   final String rewardAdId = "ca-app-pub-3940256099942544/5224354917";
//   final String rewardAdIos = "ca-app-pub-4195218374628771/1605054737";
//   final String rewardAdAndroid = "ca-app-pub-4195218374628771/5999369970";
//
//   init() async {
//     final status = await MobileAds.instance.initialize();
//
//     ads = MobileAds.instance;
//
//     CustomLog.log('inited google ads');
//     CustomLog.log(await ads.getVersionString());
//   }
//
//   Future showRewardedAd({
//     required Function onSuccess,
//     required Function onFailed,
//   }) async {
//     await RewardedAd.load(
//       adUnitId: _getRewardsAdId(),
//       request: AdRequest(),
//       rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
//         ad.fullScreenContentCallback = FullScreenContentCallback(
//           onAdShowedFullScreenContent: (RewardedAd ad) =>
//               CustomLog.log('$ad onAdShowedFullScreenContent.'),
//           onAdDismissedFullScreenContent: (RewardedAd ad) {
//             CustomLog.log('$ad onAdDismissedFullScreenContent.');
//             onSuccess();
//             ad.dispose();
//           },
//           onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
//             CustomLog.log('$ad onAdFailedToShowFullScreenContent: $error');
//             ad.dispose();
//           },
//           onAdImpression: (RewardedAd ad) => print('$ad impression occurred.'),
//         );
//         ad.show(onUserEarnedReward: (_, item) {
//           onSuccess();
//           CustomLog.log("Success");
//         });
//       }, onAdFailedToLoad: (err) {
//         CustomLog.log("fail = ${err.message}");
//         onFailed();
//       }),
//     );
//   }
//
//   showInterstitial(Function callback) async {
//     await InterstitialAd.load(
//       adUnitId: _getInterstitialAdId(),
//       request: AdRequest(),
//       adLoadCallback: InterstitialAdLoadCallback(
//         onAdFailedToLoad: (LoadAdError error) {
//           callback();
//           print("Faild load ads error: " + error.message);
//         },
//         onAdLoaded: (InterstitialAd ad) {
//           ad.show();
//           callback();
//         },
//       ),
//     );
//   }
//
//   String _getRewardsAdId() {
//     return Platform.isIOS ? rewardAdIos : rewardAdAndroid;
//   }
//
//   String _getInterstitialAdId() {
//     return Platform.isIOS
//         ? "ca-app-pub-4195218374628771/8929816882"
//         : "ca-app-pub-4195218374628771/3955857658";
//   }
// }
