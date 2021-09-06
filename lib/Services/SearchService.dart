import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gsk_firebase/Auth/Helper/fireStore_Helper.dart';

class SearchService {
  searchByName(String searchField) {
    return FirebaseFirestore.instance.collection('Freinds').where('searchKey',
        isEqualTo: searchField.substring(0, 1).toUpperCase()).get();
  }
}
