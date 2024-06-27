import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsHelper {
  static InterstitialAd? interstitialAd;
  static double lastDisplayingTime = 0;

  Future<void> loadGoogleAds() async {
    AdsHelper ads = AdsHelper();
    ads.loadInterstitialAd();
  }

  static showAds({required Function dismiss}) {
    double currentTime = DateTime.now().microsecondsSinceEpoch/1000000;

    if (AdsHelper.interstitialAd == null) {
      dismiss();
      AdsHelper().loadInterstitialAd();
      return;
    }
    if ((AdsHelper.interstitialAd != null) && (currentTime- 18000) > lastDisplayingTime) {
      AdsHelper.lastDisplayingTime = DateTime.now().microsecondsSinceEpoch/1000000;
      AdsHelper.interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ads) {
          AdsHelper().loadInterstitialAd();
          dismiss();
          return;
        },
      );
      AdsHelper.interstitialAd?.show();
    } else {
      dismiss();
    }
  }

  Future<void> initGoogleMobileAds() async {
    // TODO: Initialize Google Mobile Ads SDK
    MobileAds.instance
      ..initialize()
      ..updateRequestConfiguration(RequestConfiguration(
        testDeviceIds: <String>['2319471873f7024999e7933a8a89954b'],
      ));
  }

  void loadInterstitialAd() {
    AdsHelper.interstitialAd = null;

    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ads) {
          AdsHelper.interstitialAd = ads;
        },
        onAdFailedToLoad: (err) {
          AdsHelper.interstitialAd = null;
        },
      ),
    );
  }

  String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-7356825362262138/8189974769';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-7356825362262138/8189974769';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-7356825362262138/4386461123";
    } else if (Platform.isIOS) {
      return "ca-app-pub-7356825362262138/7599234678";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}