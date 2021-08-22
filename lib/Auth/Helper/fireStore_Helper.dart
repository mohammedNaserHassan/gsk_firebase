import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gsk_firebase/Chating/Models/RegisterRequest.dart';

class fireStore_Helper{
  fireStore_Helper._();
  static fireStore_Helper helper = fireStore_Helper._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  addUserToFireBase(RegisterRequest registerRequest)async{
    try {
      firebaseFirestore.collection('Users').add(registerRequest.toMap());
    } on Exception catch (e) {
      // TODO
    }
  }
}