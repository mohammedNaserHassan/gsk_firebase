import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gsk_firebase/Chating/Models/ChatFirebase.dart';
import 'package:gsk_firebase/Chating/Models/CountryModel.dart';
import 'package:gsk_firebase/Chating/Models/RegisterRequest.dart';
import 'package:gsk_firebase/Chating/Models/chat.dart';

import 'auth_helper.dart';

class fireStore_Helper {
  fireStore_Helper._();
  static fireStore_Helper helper = fireStore_Helper._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;


////Add User and Get it
  addUserToFireBase(RegisterRequest registerRequest) async {
    try {
      await firebaseFirestore
          .collection('Users')
          .doc(registerRequest.id)
          .set(registerRequest.toMap());
    } on Exception catch (e) {}
  }

  Future<RegisterRequest> getUserFromFirestore() async {
    String userId = Auth_helper.auth_helper.getUserId();
    DocumentSnapshot documentSnapshot =
        await firebaseFirestore.collection('Users').doc(userId).get();
  //  print(documentSnapshot.data());
    return RegisterRequest.fromMap(documentSnapshot.data());
  }
////////////////////////////////////////////////////////////////////////////////

//////////////////////////add Friend and get it
  addFriendToFirestore(Chat chat) async {
    try {
      await firebaseFirestore
          .collection('Freinds')
          .doc()
          .set(chat.toMap());
    } on Exception catch (e) {}
  }
  Future<Chat> getFriendFromFirebase(String userId) async {
    DocumentSnapshot documentSnapshot =
    await firebaseFirestore.collection('Freinds').doc(userId).get();
    //  print(documentSnapshot.data());
    return Chat.fromMap(documentSnapshot.data());
  }
////////////////////////////////////////////////////////////////////////////////

  ///////////////////////////////Add Message and get it

addMessageToFireStore(Map map)async{
    firebaseFirestore.collection('Chats').add({...map,'userId':Auth_helper.auth_helper.getUserId()});
}

  Future<List<ChatFire>> getMessageFromFireStore()async{
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await firebaseFirestore.collection('Chats').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<ChatFire> chats =
    docs.map((e) => ChatFire.fromMap(e.data())).toList();
    String id = chats.first.userId;
    print(chats.length);
    return chats;
}
////////////////////////////////////////////////////////////////////////////////
  ///////////////////////Get FireStream

  Stream<QuerySnapshot<Map<String, dynamic>>> getFireStream(){
    return firebaseFirestore.collection('Chats').orderBy('timeDate', descending: false).snapshots();
}

  Stream<QuerySnapshot<Map<String, dynamic>>> getFreindStream(){
    return firebaseFirestore.collection('Freinds').snapshots();
  }
////////////////////////////////////////////////////////////////////////////////

  ////////////////////////GetAll

  Future<List<RegisterRequest>> getAllUsersFromFirestore() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firebaseFirestore.collection('Users').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<RegisterRequest> users =
        docs.map((e) => RegisterRequest.fromMap(e.data())).toList();
    String id = users.first.id;
    print(users.length);
    return users;
  }

  Future<List<CountryModel>> getAllCountreis() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firebaseFirestore.collection('Countries').get();
      List<CountryModel> countries = querySnapshot.docs.map((e) {
        return CountryModel.fromjsion(e.data());
      }).toList();
      return countries;
    } on Exception catch (e) {
      // TODO
    }
  }

  Future<List<Chat>> getAllFreindsFromFirestore() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await firebaseFirestore.collection('Freinds').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<Chat> freinds =
    docs.map((e) => Chat.fromMap(e.data())).toList();
    return freinds;
  }
////////////////////////////////////////////////////////////////////////////////

/////////////////////Update Profile

  updateProfile(RegisterRequest userModel) async {
    await firebaseFirestore
        .collection('Users')
        .doc(userModel.id)
        .update(userModel.toMap());
  }
////////////////////////////////////////////////////////////////////////////////////
}
