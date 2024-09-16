import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // get current user
  User? getCurrentUser() {
    return auth.currentUser;
  }

  // sign in
  Future<UserCredential> signInWithEmailPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential =
          await auth.signInWithEmailAndPassword(email: email, password: password);

      // save user info if it doesn't already exist..
      firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });
      return userCredential;
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }

  // register
  Future<UserCredential> signUpWithEmailPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(email: email, password: password);

      // save user info in  separate doc
      firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
}
