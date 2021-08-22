import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gsk_firebase/Chating/Models/RegisterRequest.dart';
import 'package:gsk_firebase/Chating/Models/UserModel.dart';

class fireStore_Helper{
  fireStore_Helper._();
  static fireStore_Helper helper = fireStore_Helper._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  addUserToFireBase(RegisterRequest registerRequest)async{
    try {
     await firebaseFirestore.collection('Users').doc(registerRequest.id).set(registerRequest.toMap());
    } on Exception catch (e) {
    }
  }
  getUserFromFirestore(String userId) async {
    DocumentSnapshot documentSnapshot =
    await firebaseFirestore.collection('Users').doc(userId).get();

    print(documentSnapshot.data());
  }

  Future<List<UserModel>> getAllUsersFromFirestore() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await firebaseFirestore.collection('Users').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<UserModel> users =
    docs.map((e) => UserModel.fromMap(e.data())).toList();
    print(users.length);
    return users;
  }
}