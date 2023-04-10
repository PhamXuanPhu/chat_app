import 'dart:async';

import 'package:chat_app/models/user.dart' as models;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/chat.dart';

class FirebaseAPI {
  static late FirebaseAuth auth;
  static late FirebaseFirestore firestore;

  static Future<void> init() async {
    auth = FirebaseAuth.instance;
    firestore = FirebaseFirestore.instance;
  }

  static Future<String> login(String email, String password) async {
    //FirebaseAuth auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return "";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'noti_khong_tim_thay_nguoi_dung_voi_email_do'.tr();
      } else if (e.code == 'wrong-password') {
        return 'noti_mat_khau_duoc_cung_cap_khong_dung'.tr();
      }
    }
    return 'noti_loi_he_thong'.tr();
  }

  static Future<bool> checkLogin() async {
    var completer = Completer<bool>();
    auth.authStateChanges().listen((User? user) {
      if (user != null) {
        completer.complete(true);
      } else {
        completer.complete(false);
      }
    });
    return completer.future;
  }

  static Future<void> signOut() async {
    await auth.signOut();
  }

  static Future<String> register(
      String name, String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        bool create = await createUser(userCredential.user!.uid, name, email);
        if (create) {
          return '';
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        'noti_mat_khau_duoc_cung_cap_qua_yeu'.tr();
      } else if (e.code == 'email-already-in-use') {
        'noti_tai_khoan_da_ton_tai_cho_email_do'.tr();
      }
    } catch (e) {}
    return 'noti_loi_he_thong'.tr();
  }

  static Future<bool> createUser(String id, String name, String email) async {
    try {
      final docRef = firestore.collection('users').doc(id);
      Map<String, dynamic> data = {
        'id': id,
        'name': name,
        'email': email,
      };
      docRef.set(data);
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  static Future<bool> forgotPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      //  Toast.show(e.message!);
    }
    return false;
  }

  static Future<List<models.User>> getUsers() async {
    try {
      QuerySnapshot<models.User> querySnapshot = await firestore
          .collection('users')
          .where('id', isNotEqualTo: auth.currentUser!.uid)
          .withConverter<models.User>(
              fromFirestore: (snapshot, _) =>
                  models.User.fromMap(snapshot.data()!),
              toFirestore: (user, _) => user.toMap())
          .get();

      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } on FirebaseAuthException catch (e) {
      //  Toast.show(e.message!);
      throw Exception();
    }
  }

  static Stream<QuerySnapshot<Chat>> getChats() {
    try {
      var querySnapshot = firestore
          .collection('chats')
          .withConverter<Chat>(
              fromFirestore: (snapshot, _) => Chat.fromMap(snapshot.data()!),
              toFirestore: (user, _) => user.toMap())
          .snapshots();
      return querySnapshot;
    } on FirebaseAuthException catch (e) {
      //  Toast.show(e.message!);
      throw Exception(e);
    }
  }
}
