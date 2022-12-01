// import 'dart:async';
// import 'package:get/instance_manager.dart';
// import 'package:in_app_purchase/in_app_purchase.dart';
// import 'package:novel_project/arbe_module/utils/loading_overlay.dart';
// import 'package:novel_project/models/other/author_model_compass.dart';
// import 'package:get/get.dart';
//
// class IAPController {
//   static IAPController? _instance;
//
//   IAPController._internal();
//
//   static IAPController get instance {
//     if (_instance == null) {
//       _instance = IAPController._internal();
//     }
//
//     return _instance!;
//   }
//
//   bool isLoading = false;
//
//   late StreamSubscription<List<PurchaseDetails>> _subscription;
//
//   Future<List<ProductDetails>> getProducts(Set<String> ids) async {
//     ProductDetailsResponse response =
//         await InAppPurchase.instance.queryProductDetails(ids);
//
//     return response.productDetails;
//   }
//
//   initPurchase(Function(PurchaseDetails) onComplete) {
//     final Stream purchaseUpdated = InAppPurchase.instance.purchaseStream;
//     _subscription = purchaseUpdated.listen((purchaseList) {
//       _listenToPurchaseUpdated(purchaseList, onComplete);
//     }, onDone: () {
//       _subscription.cancel();
//     }, onError: (err) {
//       print("loi");
//     }) as StreamSubscription<List<PurchaseDetails>>;
//   }
//
//   void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList,
//       Function(PurchaseDetails) onComplete) {
//     purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
//       if (purchaseDetails.status == PurchaseStatus.pending) {
//         if (!isLoading) {
//           LoadingOverlay.of(Get.overlayContext!).show();
//           isLoading = true;
//         }
//       } else {
//         if (purchaseDetails.status == PurchaseStatus.error) {
//         } else if (purchaseDetails.status == PurchaseStatus.purchased ||
//             purchaseDetails.status == PurchaseStatus.restored) {
//           if (isLoading) {
//             LoadingOverlay.of(Get.overlayContext!).hide();
//             isLoading = false;
//           }
//         }
//         if (purchaseDetails.pendingCompletePurchase) {
//           await InAppPurchase.instance.completePurchase(purchaseDetails);
//
//           if (isLoading) {
//             LoadingOverlay.of(Get.overlayContext!).hide();
//             isLoading = false;
//           }
//
//           onComplete(purchaseDetails);
//         }
//       }
//     });
//   }
// }
