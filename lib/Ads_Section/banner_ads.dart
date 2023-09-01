import 'package:all_in_one_image_converter/app_config.dart';
import 'package:all_in_one_image_converter/helpers/getter_setter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsController {
  static BannerAd showBannerAd(context) {
    var bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: AppConfig.adUnit,
        listener: BannerAdListener(
            onAdLoaded: (ad) {},
            onAdFailedToLoad: (ad, error) {
              ad.dispose();
            }),
        request: const AdRequest())
      ..load();

    return bannerAd;
  }

  static showAppOpenAd(context) async {
    await AppOpenAd.load(
        adUnitId: AppConfig.adUnit,
        request: const AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(onAdLoaded: (onAdLoaded) {
          onAdLoaded.show();
          print("Ad Loaded Suces :: $onAdLoaded");
        }, onAdFailedToLoad: (ad) {
          print("Ads Failed To Load ********");
        }),
        orientation: AppOpenAd.orientationPortrait);
  }
}
