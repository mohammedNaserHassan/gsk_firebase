import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gsk_firebase/Chating/Models/CountryModel.dart';
import 'package:gsk_firebase/Chating/Models/RegisterRequest.dart';
import 'package:gsk_firebase/Chating/Models/UserModel.dart';

import 'auth_helper.dart';

class fireStore_Helper {
  fireStore_Helper._();

  static fireStore_Helper helper = fireStore_Helper._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  addUserToFireBase(RegisterRequest registerRequest) async {
    try {
      await firebaseFirestore
          .collection('Users')
          .doc(registerRequest.id)
          .set(registerRequest.toMap());
    } on Exception catch (e) {}
  }

  Future<UserModel> getUserFromFirestore() async {
    String userId = Auth_helper.auth_helper.getUserId();
    DocumentSnapshot documentSnapshot =
        await firebaseFirestore.collection('Users').doc(userId).get();
    print(documentSnapshot.data());
    return UserModel.fromMap(documentSnapshot.data());
  }

  Future<List<UserModel>> getAllUsersFromFirestore() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firebaseFirestore.collection('Users').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<UserModel> users =
        docs.map((e) => UserModel.fromMap(e.data())).toList();
    String id = users.first.id;
    print(users.length);
    return users;
  }

  Future<List<CountryModel>> getAllCountreis() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firebaseFirestore.collection('Countries').get();
      List<CountryModel> countries = querySnapshot.docs.map((e) {
        Map map = e.data();
        map['id'] = e.id;
        return CountryModel.fromjsion(map);
      }).toList();
      return countries;
    } on Exception catch (e) {
      // TODO
    }
  }

  updateProfile(UserModel userModel) async {
    await firebaseFirestore
        .collection('Users')
        .doc(userModel.id)
        .update(userModel.toMap());
  }
}
