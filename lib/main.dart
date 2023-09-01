import 'package:all_in_one_image_converter/app_config.dart';
import 'package:all_in_one_image_converter/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

AppOpenAd? openAd;

Future<void> loadAd() async {
  await AppOpenAd.load(
      adUnitId: AppConfig.openAppAdUnit,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(onAdLoaded: (onAdLoaded) {
        print("Ad is Loadded***************** ");
        openAd = onAdLoaded;
        openAd!.show();
      }, onAdFailedToLoad: (error) {
        print("Ad Failed To Load check $error");
      }),
      orientation: AppOpenAd.orientationPortrait);
}

// void showAd() async {
//   if (openAd == null) {
//     print("Trying to show before loading ************* ");
//     await loadAd();
//     return;
//   }

//   openAd!.fullScreenContentCallback =
//       FullScreenContentCallback(onAdShowedFullScreenContent: (ad) {
//     print("Full Screen ad show");
//   }, onAdFailedToShowFullScreenContent: (ad, error) {
//     ad.dispose();
//     print("Failed to load $error");
//     openAd = null;
//     // loadAd();
//   }, onAdDismissedFullScreenContent: (ad) {
//     ad.dispose();
//     print("dismissed ad");
//     openAd = null;
//     // loadAd();
//   });
//   openAd!.show();
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  var deviceId = [
    "13A0CEA17E9A2C088CC80C687E56732A",
    "187767E7382B6CDF1E43F5A242FC4763"
  ];
  RequestConfiguration requestConfiguration = RequestConfiguration(
    testDeviceIds: deviceId,
  );
  await MobileAds.instance.updateRequestConfiguration(requestConfiguration);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Dashboardview(),
    );
  }
}
