import 'package:firebase_auth/firebase_auth.dart';

import '../services/toast_service.dart';

class FirebaseAPI {
  static Future<bool> login(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // ToastMessage.show('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        // ToastMessage.show('Wrong password provided for that user.');
      }
    }
    return false;
  }

  static Future<bool> register(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // ToastMessage.show('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // ToastMessage.show('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  static Future<bool> forgotPassword(String email) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      //  ToastMessage.show(e.message!);
    }
    return false;
  }
}
