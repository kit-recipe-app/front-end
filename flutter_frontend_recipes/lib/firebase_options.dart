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
    apiKey: 'AIzaSyDGIKlEsaELJvbXGG7FrPTrNMN1HMz4teU',
    appId: '1:537722360443:web:ae8f19eb9454248fa788de',
    messagingSenderId: '537722360443',
    projectId: 'kit-recipe-app',
    authDomain: 'kit-recipe-app.firebaseapp.com',
    storageBucket: 'kit-recipe-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAJTZ-Fa_8wyMY9_v9knSIDvPitasvt7tM',
    appId: '1:537722360443:android:5472bf606d193706a788de',
    messagingSenderId: '537722360443',
    projectId: 'kit-recipe-app',
    storageBucket: 'kit-recipe-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAaudyNeSkHe6iXDYesdzAmKR_WX9N-aNA',
    appId: '1:537722360443:ios:21d3e5c3decfbda3a788de',
    messagingSenderId: '537722360443',
    projectId: 'kit-recipe-app',
    storageBucket: 'kit-recipe-app.appspot.com',
    iosClientId: '537722360443-eeg11utjhtufoluo2jbl2at4ds0c5s8f.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterFrontendRecipes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAaudyNeSkHe6iXDYesdzAmKR_WX9N-aNA',
    appId: '1:537722360443:ios:21d3e5c3decfbda3a788de',
    messagingSenderId: '537722360443',
    projectId: 'kit-recipe-app',
    storageBucket: 'kit-recipe-app.appspot.com',
    iosClientId: '537722360443-eeg11utjhtufoluo2jbl2at4ds0c5s8f.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterFrontendRecipes',
  );
}
