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
    apiKey: 'AIzaSyBF9MDV79dQXqXXeEq67uXjeAp-j5aver0',
    appId: '1:621949933166:web:ac035329a08deec4e1b87f',
    messagingSenderId: '621949933166',
    projectId: 'pointofsale-6e209',
    authDomain: 'pointofsale-6e209.firebaseapp.com',
    storageBucket: 'pointofsale-6e209.appspot.com',
    measurementId: 'G-GK5YZ2EX9B',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA4b1sGynAtlFhJwhRenqBqa7VRd2KLZL0',
    appId: '1:621949933166:android:b49e5c8763217035e1b87f',
    messagingSenderId: '621949933166',
    projectId: 'pointofsale-6e209',
    storageBucket: 'pointofsale-6e209.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDw-_chntRVONOCSLVMnFqYRHVlzO7lQIg',
    appId: '1:621949933166:ios:39fef96e5ccf89a4e1b87f',
    messagingSenderId: '621949933166',
    projectId: 'pointofsale-6e209',
    storageBucket: 'pointofsale-6e209.appspot.com',
    iosClientId: '621949933166-psc9aq4snfv9660qd2sdcdd9r2vh7b6l.apps.googleusercontent.com',
    iosBundleId: 'com.example.pointofsale',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDw-_chntRVONOCSLVMnFqYRHVlzO7lQIg',
    appId: '1:621949933166:ios:96265501ff1b40a6e1b87f',
    messagingSenderId: '621949933166',
    projectId: 'pointofsale-6e209',
    storageBucket: 'pointofsale-6e209.appspot.com',
    iosClientId: '621949933166-5h8g4l0jpctgt9jc54lve6ble0m4j2hd.apps.googleusercontent.com',
    iosBundleId: 'com.example.pointofsale.RunnerTests',
  );
}
