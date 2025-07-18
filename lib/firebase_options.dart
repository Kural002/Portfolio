// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDVFdduk1mHEdysi9A3emIHsSW-_uMkDrk',
    appId: '1:433148922274:web:89e2062868c867be350afb',
    messagingSenderId: '433148922274',
    projectId: 'portfolio-8960e',
    authDomain: 'portfolio-8960e.firebaseapp.com',
    storageBucket: 'portfolio-8960e.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDoAtDC3ZC2OU50m1Gf1IWKoaZ2t7OFEUs',
    appId: '1:433148922274:android:aa4d87755b216a98350afb',
    messagingSenderId: '433148922274',
    projectId: 'portfolio-8960e',
    storageBucket: 'portfolio-8960e.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBetc6yxhx7zV-RbUEkfatcSkQFfo0TOz8',
    appId: '1:433148922274:ios:0d01efa68a22944a350afb',
    messagingSenderId: '433148922274',
    projectId: 'portfolio-8960e',
    storageBucket: 'portfolio-8960e.firebasestorage.app',
    iosBundleId: 'com.example.portfolio',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBetc6yxhx7zV-RbUEkfatcSkQFfo0TOz8',
    appId: '1:433148922274:ios:0d01efa68a22944a350afb',
    messagingSenderId: '433148922274',
    projectId: 'portfolio-8960e',
    storageBucket: 'portfolio-8960e.firebasestorage.app',
    iosBundleId: 'com.example.portfolio',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDVFdduk1mHEdysi9A3emIHsSW-_uMkDrk',
    appId: '1:433148922274:web:3386b48ed8f900b4350afb',
    messagingSenderId: '433148922274',
    projectId: 'portfolio-8960e',
    authDomain: 'portfolio-8960e.firebaseapp.com',
    storageBucket: 'portfolio-8960e.firebasestorage.app',
  );
}
