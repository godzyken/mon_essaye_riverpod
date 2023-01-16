// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

import 'env/env.dart';

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

  static FirebaseOptions get web => FirebaseOptions(
        apiKey: firebaseOptions.apiKey,
        appId: firebaseOptions.appId,
        messagingSenderId: '485700706196',
        projectId: 'flutterauth-demo',
        authDomain: 'flutterauth-demo.firebaseapp.com',
        databaseURL: 'https://flutterauth-demo.firebaseio.com',
        storageBucket: 'flutterauth-demo.appspot.com',
        measurementId: 'G-CPLLJQT8PR',
      );

  static FirebaseOptions get android => FirebaseOptions(
        apiKey: Env.aApiKey,
        appId: Env.aApiId,
        messagingSenderId: '485700706196',
        projectId: 'flutterauth-demo',
        databaseURL: 'https://flutterauth-demo.firebaseio.com',
        storageBucket: 'flutterauth-demo.appspot.com',
      );

  static FirebaseOptions get ios => FirebaseOptions(
        apiKey: Env.webApiKey,
        appId: Env.iosApiId,
        messagingSenderId: '485700706196',
        projectId: 'flutterauth-demo',
        databaseURL: 'https://flutterauth-demo.firebaseio.com',
        storageBucket: 'flutterauth-demo.appspot.com',
        androidClientId:
            '485700706196-281ci74urup2ctt0sol7hh1kjrp5mlrg.apps.googleusercontent.com',
        iosClientId:
            '485700706196-0s0uk1t90qtsaudt9kmihmq1ufdbgn9q.apps.googleusercontent.com',
        iosBundleId: 'com.godzy.monEssayeRiverpod',
      );

  static FirebaseOptions get macos => FirebaseOptions(
        apiKey: Env.iosApiKey,
        appId: Env.iosApiId,
        messagingSenderId: '485700706196',
        projectId: 'flutterauth-demo',
        databaseURL: 'https://flutterauth-demo.firebaseio.com',
        storageBucket: 'flutterauth-demo.appspot.com',
        androidClientId:
            '485700706196-281ci74urup2ctt0sol7hh1kjrp5mlrg.apps.googleusercontent.com',
        iosClientId:
            '485700706196-0s0uk1t90qtsaudt9kmihmq1ufdbgn9q.apps.googleusercontent.com',
        iosBundleId: 'com.godzy.monEssayeRiverpod',
      );
}

FirebaseOptions get firebaseOptions {
  return FirebaseOptions(
    apiKey: Env.webApiKey,
    appId: Env.wApiId,
    messagingSenderId: '485700706196',
    projectId: 'flutterauth-demo',
    databaseURL: 'https://flutterauth-demo.firebaseio.com',
    storageBucket: 'flutterauth-demo.appspot.com',
    androidClientId:
        '485700706196-281ci74urup2ctt0sol7hh1kjrp5mlrg.apps.googleusercontent.com',
    iosClientId:
        '485700706196-0s0uk1t90qtsaudt9kmihmq1ufdbgn9q.apps.googleusercontent.com',
    iosBundleId: 'com.godzy.monEssayeRiverpod',
    authDomain: 'flutterauth-demo.firebaseapp.com',
  );
}