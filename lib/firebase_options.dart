// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyC1d1SYRvCehDk5fyULnRM1Q0w8tGkTUMA',
    appId: '1:1090482525593:web:0e696efb3c95e8bdb2af08',
    messagingSenderId: '1090482525593',
    projectId: 'abela-28761',
    authDomain: 'abela-28761.firebaseapp.com',
    storageBucket: 'abela-28761.appspot.com',
    measurementId: 'G-KJKQ62JCX6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB2r_zwlUgtGIBRSHoUfIc3Jx0X0WDGlYk',
    appId: '1:1090482525593:android:7e9f6123c3021e1eb2af08',
    messagingSenderId: '1090482525593',
    projectId: 'abela-28761',
    storageBucket: 'abela-28761.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDX2NPYmdm5YTQBMk8dHPwKVsMz66_j3qU',
    appId: '1:1090482525593:ios:1b87b4c97c8cfca6b2af08',
    messagingSenderId: '1090482525593',
    projectId: 'abela-28761',
    storageBucket: 'abela-28761.appspot.com',
    iosBundleId: 'com.example.cli',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDX2NPYmdm5YTQBMk8dHPwKVsMz66_j3qU',
    appId: '1:1090482525593:ios:2bb20c863cf904cbb2af08',
    messagingSenderId: '1090482525593',
    projectId: 'abela-28761',
    storageBucket: 'abela-28761.appspot.com',
    iosBundleId: 'com.example.cli.RunnerTests',
  );
}
