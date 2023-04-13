import 'dart:async';

import 'package:chat_app/models/user.dart' as models;
import 'package:chat_app/services/chat_id_service.dart';
import 'package:chat_app/services/data_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../configs/config.dart';
import '../models/chat.dart';
import '../models/message.dart';
import '../services/current_user_service.dart';

class FirebaseAPI {
  static late FirebaseAuth auth;
  static late FirebaseFirestore firestore;

  static Future<void> init() async {
    auth = FirebaseAuth.instance;
    firestore = FirebaseFirestore.instance;
  }

  static Future<String> login(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        getUserLogin();
        return "";
      } else {
        return 'noti_loi_he_thong'.tr();
      }
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
        getUserLogin();
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

  static Future<void> getUserLogin() async {
    try {
      var result = await firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .withConverter<models.User>(
              fromFirestore: (snapshot, _) =>
                  models.User.fromMap(snapshot.data()!),
              toFirestore: (user, _) => user.toMap())
          .get();
      CurrentUser.user = models.User(
          id: result.id,
          name: result.data()!.name,
          email: result.data()!.email);
    } on FirebaseAuthException catch (e) {
      //  Toast.show(e.message!);
      throw Exception();
    }
  }

  static Stream<QuerySnapshot<Chat>> getChats() {
    try {
      var querySnapshot = firestore
          .collection('chats')
          .where('members', arrayContains: auth.currentUser!.uid)
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

  static Future<Chat> getChat(models.User contact) async {
    try {
      models.User form = CurrentUser.user;
      var members = [form.id, contact.id];
      var chatid = chatID(form.id, contact.id);
      final docRef = firestore.collection('chats').doc(chatid);
      Map<String, dynamic> data = {
        'id': chatid,
        'last_message': '',
        'messages': '',
        'members': FieldValue.arrayUnion(members),
        'from_id': form.id,
        'from_avatar':
            'https://img.hoidap247.com/picture/question/20200508/large_1588936738888.jpg',
        'from_name': form.name,
        'to_id': contact.id,
        'to_avatar':
            'https://img.hoidap247.com/picture/question/20200508/large_1588936738888.jpg',
        'to_name': contact.name,
        'update_on': Timestamp.now(),
      };
      docRef.set(data);
      return Chat(chatid, form.id, form.name, form.email, contact.id,
          contact.name, contact.email, '', null, []);
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  static Stream<QuerySnapshot<Message>> getMessages(String chatID) {
    try {
      var querySnapshot = firestore
          .collection('chats')
          .doc(chatID)
          .collection('messages')
          .orderBy('update_on', descending: true)
          .withConverter<Message>(
              fromFirestore: (snapshot, _) => Message.fromMap(snapshot.data()!),
              toFirestore: (user, _) => user.toMap())
          .snapshots();
      return querySnapshot;
    } on FirebaseAuthException catch (e) {
      //  Toast.show(e.message!);
      throw Exception(e);
    }
  }

  static Future<void> sendMessage(Message message) async {
    try {
      final docRef = firestore
          .collection('chats')
          .doc(message.chat_id)
          .collection('messages');
      docRef.add(message.toMap());
      await updateLastMessage(message);
    } on FirebaseAuthException catch (e) {
      //  Toast.show(e.message!);
      throw Exception(e);
    }
  }

  static Future<void> updateLastMessage(Message message) async {
    try {
      final docRef = firestore.collection('chats').doc(message.chat_id);
      docRef.update({
        'last_message': message.message,
        'update_on': message.update_on,
      });
    } on FirebaseAuthException catch (e) {
      //  Toast.show(e.message!);
      throw Exception(e);
    }
  }
}
