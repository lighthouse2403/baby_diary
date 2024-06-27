import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDrRweKvifzeavtD3yRbJnn_V5n9TWnLy8',
    appId: '1:705561206687:android:9ad25565ef2804d9fbe7aa',
    messagingSenderId: '490028130190',
    projectId: 'com.beacon.pregnancy',
    storageBucket: 'pregnancyflutter.appspot.com',
    androidClientId: '705561206687-qg12gj5top8l19cjq3mrgttlh0v59eod.apps.googleusercontent.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBX1eL7q-u2l7s3CmlFqh2KPEvRj2B3_5I',
    appId: '1:705561206687:ios:c4bd4ca65efbd229fbe7aa',
    messagingSenderId: '705561206687',
    projectId: 'pregnancyflutter',
    storageBucket: 'pregnancyflutter.appspot.com',
    iosClientId: 'com.googleusercontent.apps.705561206687-laaee3rl71n6bdvfchavbqer3eb29m4c',
    iosBundleId: 'com.beacon.pregnancy',
  );
}
