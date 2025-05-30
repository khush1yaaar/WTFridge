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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAgmTqftWCHd-V-pMJhKP5LfSeKSIg7wJU',
    appId: '1:900449210373:web:1b2b40bf21a6900cadcc6c',
    messagingSenderId: '900449210373',
    projectId: 'wtfridge',
    authDomain: 'wtfridge.firebaseapp.com',
    storageBucket: 'wtfridge.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBIVz84jQMVpQTDNR41qvP9Nk5RnfOouQU',
    appId: '1:900449210373:android:a183d62ac8daa726adcc6c',
    messagingSenderId: '900449210373',
    projectId: 'wtfridge',
    storageBucket: 'wtfridge.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCOm2UkNCIkgpjk7Dq9C1EWnwVbqwvomjs',
    appId: '1:900449210373:ios:44bf3f3f887468bdadcc6c',
    messagingSenderId: '900449210373',
    projectId: 'wtfridge',
    storageBucket: 'wtfridge.firebasestorage.app',
    iosBundleId: 'com.example.wtfridge',
  );
}
