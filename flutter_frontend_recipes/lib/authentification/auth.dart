import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RAAuthService {
  final userStream = FirebaseAuth.instance.authStateChanges();
  final user = FirebaseAuth.instance.currentUser;

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
    FirebaseAuth.instance.currentUser!.getIdToken().then((result) {
      print(result);
    });
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    FirebaseAuth.instance.currentUser!.getIdToken().then((result) {
      print(result);
    });
  }

  Future<void> createUserWithEmailAndPassword({
    required String userName,
    required String email,
    required String password,
  }) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    print("registration done");
  }

  Future<void> signOut() async {
    FirebaseAuth.instance.signOut();
  }

  Future<void> userSetup(String userName) async {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    String userId = user!.uid.toString();
    print(userId);
    users.doc(userId).set({
      'userName': userName,
    });
    return;
  }
}
