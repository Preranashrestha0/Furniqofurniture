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
    apiKey: 'AIzaSyCnp_gfShW7A_okKublZ1V0whdJor3YwvA',
    appId: '1:261526798630:web:5db88d6ceb79b20e8401e7',
    messagingSenderId: '261526798630',
    projectId: 'furniqo',
    authDomain: 'furniqo.firebaseapp.com',
    storageBucket: 'furniqo.appspot.com',
    measurementId: 'G-S92Q1LZD2G',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDylv4g2xA88R2CpjbVYiintVu2O_GsueI',
    appId: '1:261526798630:android:393018e17cfa9dd48401e7',
    messagingSenderId: '261526798630',
    projectId: 'furniqo',
    storageBucket: 'furniqo.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAHf-fgK2ev1Cnv0KLNkjQEUiGZ--FDGSU',
    appId: '1:261526798630:ios:298d67932d7088f28401e7',
    messagingSenderId: '261526798630',
    projectId: 'furniqo',
    storageBucket: 'furniqo.appspot.com',
    iosBundleId: 'com.pcpsgroup.furnitureapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAHf-fgK2ev1Cnv0KLNkjQEUiGZ--FDGSU',
    appId: '1:261526798630:ios:ea71d9789634e25d8401e7',
    messagingSenderId: '261526798630',
    projectId: 'furniqo',
    storageBucket: 'furniqo.appspot.com',
    iosBundleId: 'com.pcpsgroup.furnitureapp.RunnerTests',
  );
}
