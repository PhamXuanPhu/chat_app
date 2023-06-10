// ignore_for_file: unused_import

import 'dart:async';
import 'dart:io';

import 'package:chat_app/blocs/setting/setting_bloc.dart';
import 'package:chat_app/models/user.dart' as models;
import 'package:chat_app/services/chat_id_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/user/user_bloc.dart';
import '../configs/config.dart';
import '../helper/data_helper.dart';
import '../models/chat.dart';
import '../models/message.dart';
import '../services/data_service.dart';

class FirebaseAPI {
  static late FirebaseAuth auth;
  static late FirebaseFirestore firestore;
  static late FirebaseStorage storage;

  static Future<void> init() async {
    auth = FirebaseAuth.instance;
    firestore = FirebaseFirestore.instance;
    storage = FirebaseStorage.instance;
  }

  static Future<String> login(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        Config.user = await getUser(userCredential.user!.uid);
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

  static Future<models.User> reLogin() async {
    try {
      String email = await DataService.getEmail();
      String password = await DataService.getPassword();
      UserCredential userCredential =
          await auth.currentUser!.reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: email,
          password: password,
        ),
      );
      if (userCredential.user != null) {
        return getUser(userCredential.user!.uid);
      } else {
        return models.User();
      }
    } on FirebaseAuthException catch (e) {
      throw Exception();
    }
  }

  static Future<bool> checkLogin() async {
    var completer = Completer<bool>();
    auth.authStateChanges().listen((User? user) async {
      if (user != null) {
        Config.user = await getUser(user.uid);
        completer.complete(true);
      } else {
        completer.complete(false);
      }
    });
    return completer.future;
  }

  static Future<void> signOut() async {
    await updateStateUser(false);
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
        return 'noti_mat_khau_duoc_cung_cap_qua_yeu'.tr();
      } else if (e.code == 'email-already-in-use') {
        return 'noti_tai_khoan_da_ton_tai_cho_email_do'.tr();
      }
    }
    return 'noti_loi_he_thong'.tr();
  }

  static Future<bool> createUser(String id, String name, String email) async {
    try {
      final docRef = firestore.collection(Config.users).doc(id);
      Map<String, dynamic> data = {
        'id': id,
        'name': name,
        'email': email,
        'avatar':
            'https://firebasestorage.googleapis.com/v0/b/chatapp-f3d79.appspot.com/o/avatar%2FV1PjnMelV8jxzMjU8HUY.png?alt=media&token=https://firebasestorage.googleapis.com/v0/b/chatapp-f3d79.appspot.com/o/avatar%2FV1PjnMelV8jxzMjU8HUY.png?alt=media&token=7ae3674a-53df-4662-9580-a8b441c93047',
        'contact_array': FieldValue.arrayUnion(['0']),
        'request_array': FieldValue.arrayUnion(['0']),
        'send_array': FieldValue.arrayUnion(['0']),
        'mode': false,
        'language': Config.vnCode,
        'active_status': true,
        'country_id': '',
        'country_name': '',
        'province_id': '',
        'province_name': '',
        'district_id': '',
        'district_name': '',
        'ward_id': '',
        'ward_name': '',
        'street': '',
        'address': '',
        'gender': '',
        'birthday': '',
        'phone': ''
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

  static Future<void> getUsers(UserBloc userBloc) async {
    try {
      firestore
          .collection(Config.users)
          .withConverter<models.User>(
              fromFirestore: (snapshot, _) =>
                  models.User.fromMap(snapshot.data()!),
              toFirestore: (user, _) => user.toMap())
          .snapshots()
          .listen((event) {
        var users = event.docs
            .map((doc) => doc.data())
            .where((user) =>
                !user.contact_array.contains(auth.currentUser!.uid) &&
                !user.send_array.contains(auth.currentUser!.uid) &&
                !user.id.contains(auth.currentUser!.uid))
            .toList();
        userBloc.add(LoadUsers(users: users));
      });
    } on FirebaseAuthException catch (e) {
      throw Exception();
    }
  }

  static Future<void> getContacts(UserBloc userBloc) async {
    try {
      firestore
          .collection(Config.users)
          .withConverter<models.User>(
              fromFirestore: (snapshot, _) =>
                  models.User.fromMap(snapshot.data()!),
              toFirestore: (user, _) => user.toMap())
          .snapshots()
          .listen((event) {
        var contacts = event.docs
            .map((doc) => doc.data())
            .where(
                (user) => user.contact_array.contains((auth.currentUser!.uid)))
            .toList();
        userBloc.add(LoadContacts(contacts: contacts));
      });
    } on FirebaseAuthException catch (e) {
      throw Exception();
    }
  }

  static Future<void> getRequests(UserBloc userBloc) async {
    try {
      firestore
          .collection(Config.users)
          .withConverter<models.User>(
              fromFirestore: (snapshot, _) =>
                  models.User.fromMap(snapshot.data()!),
              toFirestore: (user, _) => user.toMap())
          .snapshots()
          .listen((event) {
        var requests = event.docs
            .map((doc) => doc.data())
            .where((user) => user.send_array.contains((auth.currentUser!.uid)))
            .toList();
        userBloc.add(LoadRequests(requests: requests));
      });
    } on FirebaseAuthException catch (e) {
      throw Exception();
    }
  }

  static Future<models.User> getUser(String userID) async {
    try {
      var result = await firestore
          .collection(Config.users)
          .doc(userID)
          .withConverter<models.User>(
              fromFirestore: (snapshot, _) =>
                  models.User.fromMap(snapshot.data()!),
              toFirestore: (user, _) => user.toMap())
          .get();
      return result.data()!;
    } on FirebaseAuthException catch (e) {
      //  Toast.show(e.message!);
      throw Exception(e);
    }
  }

  static Future<bool> sendRequest(String id) async {
    try {
      final from =
          firestore.collection(Config.users).doc(auth.currentUser!.uid);
      await from.update({
        'send_array': FieldValue.arrayUnion([id])
      });
      final to = firestore.collection(Config.users).doc(id);
      await to.update({
        'request_array': FieldValue.arrayUnion([auth.currentUser!.uid])
      });
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  static Future<bool> confirmRequest(String id, bool confirm) async {
    try {
      /// từ user
      final from =
          firestore.collection(Config.users).doc(auth.currentUser!.uid);

      ///đến user
      final to = firestore.collection(Config.users).doc(id);

      /// chấp nhận
      if (confirm) {
        /// chuyển từ request lên friend
        await from.update({
          'contact_array': FieldValue.arrayUnion([id])
        });

        /// chuyển từ send lên friend
        await to.update({
          'contact_array': FieldValue.arrayUnion([auth.currentUser!.uid])
        });
      }
      // xóa lời mời
      await from.update({
        'request_array': FieldValue.arrayRemove([id])
      });
      await to.update({
        'send_array': FieldValue.arrayRemove([auth.currentUser!.uid])
      });
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  static Stream<QuerySnapshot<Chat>> getChats() {
    try {
      var querySnapshot = firestore
          .collection(Config.chatroooms)
          .where('members_array', arrayContains: auth.currentUser!.uid)
          .withConverter<Chat>(
              fromFirestore: (snapshot, _) => Chat.fromMap(snapshot.data()!),
              toFirestore: (chat, _) => chat.toMap())
          .snapshots();
      return querySnapshot;
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  static Future<Chat> getChat(models.User contact) async {
    try {
      var from = <String, dynamic>{
        'id': Config.user.id,
        'name': Config.user.name,
        'email': Config.user.email,
        'avatar': Config.user.avatar,
      };

      var to = <String, dynamic>{
        'id': contact.id,
        'name': contact.name,
        'email': contact.email,
        'avatar': contact.avatar,
      };

      var online = <String, dynamic>{
        Config.user.id: true,
        contact.id: false,
      };

      List<Map<String, dynamic>> members = [to, from];
      var members_array = [Config.user.id, contact.id];
      var chatid = chatID(Config.user.id, contact.id);
      final docRef = firestore.collection(Config.chatroooms).doc(chatid);

      var documentSnapshot = await docRef.get();
      if (!documentSnapshot.exists) {
        Map<String, dynamic> data = {
          'id': chatid,
          'members_array': FieldValue.arrayUnion(members_array),
          'update_on': Timestamp.now(),
          'members': members,
          'last_message': "Liên lạc mới.",
          'online': online,
        };
        await docRef.set(data);
      }
      return Chat(id: chatid, members: members);
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  static Stream<QuerySnapshot<Message>> getMessages(String chatID) {
    try {
      var querySnapshot = firestore
          .collection(Config.chatroooms)
          .doc(chatID)
          .collection('messages')
          .orderBy('update_on', descending: true)
          .withConverter<Message>(
              fromFirestore: (snapshot, _) => Message.fromMap(snapshot.data()!),
              toFirestore: (message, _) => message.toMap())
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
          .collection(Config.chatroooms)
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
      final docRef =
          firestore.collection(Config.chatroooms).doc(message.chat_id);
      docRef.update({
        'last_message': message.message,
        'update_on': message.update_on,
      });
    } on FirebaseAuthException catch (e) {
      //  Toast.show(e.message!);
      throw Exception(e);
    }
  }

  static Future<void> updateStateUser(bool online) async {
    try {
      // update user
      final docRef =
          firestore.collection(Config.users).doc(auth.currentUser!.uid);
      docRef.update({
        'online': online,
      });
      //update chat
      final documents = await FirebaseFirestore.instance
          .collection(Config.chatroooms)
          .where('members_array', arrayContains: auth.currentUser!.uid)
          .get();

      for (final doc in documents.docs) {
        await doc.reference.update({'online.${auth.currentUser!.uid}': online});
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> listenUser() async {
    try {
      firestore
          .collection(Config.users)
          .doc(auth.currentUser!.uid)
          .withConverter<models.User>(
              fromFirestore: (snapshot, _) =>
                  models.User.fromMap(snapshot.data()!),
              toFirestore: (user, _) => user.toMap())
          .snapshots()
          .listen((event) {
        Config.user = event.data()!;
      });
    } on FirebaseAuthException catch (e) {
      throw Exception();
    }
  }

  static Future<String> changePassword(String newPassword) async {
    try {
      UserCredential userCredential =
          await auth.currentUser!.reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: Config.user.email,
          password: Config.password,
        ),
      );
      await userCredential.user!.updatePassword(newPassword);
      return '';
    } on FirebaseAuthException catch (e) {
      return e.message!;
    } catch (e) {}
    return 'noti_loi_he_thong'.tr();
  }

  static Future<String> deleteAccount() async {
    try {
      UserCredential userCredential =
          await auth.currentUser!.reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: Config.user.email,
          password: Config.password,
        ),
      );
      // xóa user
      await userCredential.user!.delete();
      // update user
      final docRef = firestore.collection(Config.users).doc(Config.user.id);
      await docRef.update({
        'online': false,
        'deleted': true,
      });
      //update chat
      final documents = await FirebaseFirestore.instance
          .collection(Config.chatroooms)
          .where('members_array', arrayContains: Config.user.id)
          .get();

      for (final doc in documents.docs) {
        await doc.reference.update({'deleted.${Config.user.id}': true});
      }
      return '';
    } on FirebaseAuthException catch (e) {
      return e.message!;
    } catch (e) {}
    return 'noti_loi_he_thong'.tr();
  }

  static Stream<DocumentSnapshot<models.User>> streamOnline(String userID) {
    try {
      var querySnapshot = firestore
          .collection(Config.users)
          .doc(userID)
          .withConverter<models.User>(
              fromFirestore: (snapshot, _) =>
                  models.User.fromMap(snapshot.data()!),
              toFirestore: (user, _) => user.toMap())
          .snapshots();
      return querySnapshot;
    } on FirebaseAuthException catch (e) {
      //  Toast.show(e.message!);
      throw Exception(e);
    }
  }

  static Future<void> updateActiveStatus(bool activeStatus) async {
    try {
      final docRef = firestore.collection(Config.users).doc(Config.user.id);
      docRef.update({
        'active_status': activeStatus,
      });
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> updateMode(bool mode) async {
    try {
      final docRef = firestore.collection(Config.users).doc(Config.user.id);
      docRef.update({
        'mode': mode,
      });
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> updateLanguage(String language) async {
    try {
      final docRef = firestore.collection(Config.users).doc(Config.user.id);
      docRef.update({
        'language': language,
      });
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  static Future<bool> updateUserInformation(models.User user) async {
    try {
      Map<String, dynamic> data = {
        'name': user.name,
        'avatar': user.avatar,
        'country_id': user.country_id,
        'country_name': user.country_name,
        'province_id': user.province_id,
        'province_name': user.province_name,
        'district_id': user.district_id,
        'district_name': user.district_name,
        'ward_id': user.ward_id,
        'ward_name': user.ward_name,
        'street': user.street,
        'address': user.address,
        'gender': user.gender,
        'birthday': user.birthday,
        'phone': user.phone,
      };
      final docRef = firestore.collection(Config.users).doc(Config.user.id);
      docRef.update(data);
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  static Future<String> updateAvatar(File file) async {
    try {
      String path = 'avatar/${Config.user.id}.png';
      final ref = storage.ref().child(path);
      UploadTask upload = ref.putFile(file);
      var snapshot = await upload.whenComplete(() => null);
      String urlDownload = await snapshot.ref.getDownloadURL();

      return urlDownload;
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  static Future<bool> updateUserAvatar(String avatar) async {
    try {
      final docRef = firestore.collection(Config.users).doc(Config.user.id);
      docRef.update({
        'avatar': avatar,
      });
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }
}
