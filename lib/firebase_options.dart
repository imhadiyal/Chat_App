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
    apiKey: 'AIzaSyBW7iUNvQ5zkNVYbpZm1_zQOgxk1nd2aZU',
    appId: '1:657921161469:web:855158ab1bfe29d1fa6694',
    messagingSenderId: '657921161469',
    projectId: 'fir-miner-6eb7f',
    authDomain: 'fir-miner-6eb7f.firebaseapp.com',
    storageBucket: 'fir-miner-6eb7f.appspot.com',
    measurementId: 'G-9QNQTPFYCP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBRrM3RnQzHJ50OfVUMeyGkpCzo08T7yAs',
    appId: '1:657921161469:android:e9ec0cd0817a8fe7fa6694',
    messagingSenderId: '657921161469',
    projectId: 'fir-miner-6eb7f',
    storageBucket: 'fir-miner-6eb7f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDZsJ193owb0rvMzR-rQtTVqL2B-j5WR_Q',
    appId: '1:657921161469:ios:31ee518fa0ea710cfa6694',
    messagingSenderId: '657921161469',
    projectId: 'fir-miner-6eb7f',
    storageBucket: 'fir-miner-6eb7f.appspot.com',
    iosBundleId: 'com.example.firebaseMiner',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDZsJ193owb0rvMzR-rQtTVqL2B-j5WR_Q',
    appId: '1:657921161469:ios:31ee518fa0ea710cfa6694',
    messagingSenderId: '657921161469',
    projectId: 'fir-miner-6eb7f',
    storageBucket: 'fir-miner-6eb7f.appspot.com',
    iosBundleId: 'com.example.firebaseMiner',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBW7iUNvQ5zkNVYbpZm1_zQOgxk1nd2aZU',
    appId: '1:657921161469:web:5b6e294d6ba57ed5fa6694',
    messagingSenderId: '657921161469',
    projectId: 'fir-miner-6eb7f',
    authDomain: 'fir-miner-6eb7f.firebaseapp.com',
    storageBucket: 'fir-miner-6eb7f.appspot.com',
    measurementId: 'G-Z3KNGWKR5Q',
  );
}
