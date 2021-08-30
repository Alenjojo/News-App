import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:news_app/model/user.dart';

import 'Constant.dart';

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signinwithemailandpassword(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email');
        return 'No user found for that email';
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user');
        return 'Wrong password provided for that user';
      }
    }
  }

  Future signupwithemailandpassword(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak');
        return 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email');
        return 'The account already exists for that email';
      }
    } catch (e) {
      print(e);
    }
  }

  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}

