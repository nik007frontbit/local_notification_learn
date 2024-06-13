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
    apiKey: 'AIzaSyDGFUexr1ZghFLtgTe_hYbIttd4EpkaAqA',
    appId: '1:736071947825:web:59a6642662dcefb8832710',
    messagingSenderId: '736071947825',
    projectId: 'fir-d8de0',
    authDomain: 'fir-d8de0.firebaseapp.com',
    storageBucket: 'fir-d8de0.appspot.com',
    measurementId: 'G-NJ78GZ0M3J',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAw_GQgIzBjcMopO107JZ7SYhYoTotKW2w',
    appId: '1:736071947825:android:c1d19d8d5bc20fdc832710',
    messagingSenderId: '736071947825',
    projectId: 'fir-d8de0',
    storageBucket: 'fir-d8de0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDxPo49C9NRXLJ4AIRbhrF8XyFj_73gZ8U',
    appId: '1:736071947825:ios:5ed7b93ad0137c31832710',
    messagingSenderId: '736071947825',
    projectId: 'fir-d8de0',
    storageBucket: 'fir-d8de0.appspot.com',
    iosBundleId: 'com.example.localNotificationLearn',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDxPo49C9NRXLJ4AIRbhrF8XyFj_73gZ8U',
    appId: '1:736071947825:ios:5ed7b93ad0137c31832710',
    messagingSenderId: '736071947825',
    projectId: 'fir-d8de0',
    storageBucket: 'fir-d8de0.appspot.com',
    iosBundleId: 'com.example.localNotificationLearn',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDGFUexr1ZghFLtgTe_hYbIttd4EpkaAqA',
    appId: '1:736071947825:web:7126b3f23b79e9bf832710',
    messagingSenderId: '736071947825',
    projectId: 'fir-d8de0',
    authDomain: 'fir-d8de0.firebaseapp.com',
    storageBucket: 'fir-d8de0.appspot.com',
    measurementId: 'G-B5KTBX8B1L',
  );
}
