import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../shared/shared_prefs.dart';

/// Class, that handles the authentication-process with firebase.
/// The current user and a stream that informes the client about auth-changes (e.g. login, registration).
class RAAuthService {
  final userStream = FirebaseAuth.instance.authStateChanges();
  final user = FirebaseAuth.instance.currentUser;

  /// Logs in the client with google. Currently works only in Debugmode and on ios-devices.
  /// Uses the google-sign-in package to open an extern window for account-selection.
  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
      scopes: ['email'],
    ).signIn();

    if (googleUser == null) return;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  /// Logs in the client with email and password.
  /// Uses the firebase-auth package to send the corresponding request to firebase.
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Creates a new user in firebase with email and password.
  /// Uses the firebase-auth package to send the corresponding request to firebase.
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Logs out the current user.
  /// Uses the firebase-auth package to send the corresponding request to firebase.
  Future<void> signOut() async {
    FirebaseAuth.instance.signOut();
  }

  /// Sets the users 'currentPassword' in firebase to 'newPassword'.
  /// Uses the firebase-auth package to send the corresponding request to firebase.
  void changePassword(String currentPassword, String newPassword) async {
    final user = FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(
        email: user!.email!, password: currentPassword);

    user.reauthenticateWithCredential(cred).then((value) {
      user.updatePassword(newPassword).then((_) {
        //Success, do something
      }).catchError((error) {
        //Error, show something
      });
    }).catchError((err) {});
  }

  /// Deletes the current users account from firebase.
  /// Uses the firebase-auth package to send the corresponding request to firebase.
  deleteAccount(String password) {
    final user = FirebaseAuth.instance.currentUser;
    final cred =
        EmailAuthProvider.credential(email: user!.email!, password: password);

    user.reauthenticateWithCredential(cred).then((value) {
      user.delete().then((_) {
        SharedPrefs().clear();
        return "Erfolgreich";
      }).catchError((error) {
        return "Löschen fehlgeschlagen";
      });
    }).catchError((err) {});
    return "Passwort ungültig";
  }
}
