import 'package:auth_test/firebase/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        throw AuthException("No such user!");
      } else if (e.code == 'wrong-password') {
        throw AuthException("Wong password!");
      } else if (e.code == "invalid-email") {
        throw AuthException("Bad format for email");
      }
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        throw AuthException("Password is too weak!");
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        throw AuthException('The account already exists for that email.');
      } else if (e.code == "invalid-email") {
        throw AuthException("Bad format for email");
      }
    } catch (e) {
      print(e);
    }
  }
}
