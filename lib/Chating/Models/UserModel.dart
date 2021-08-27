import 'package:flutter/material.dart';

class UserModel {
  String id;
  String email;
  String city;
  String country;
  String fName;
  String lName;
  String imgurl;
  UserModel({
    @required this.id,
    @required this.email,
    @required this.city,
    @required this.country,
    @required this.fName,
    @required this.lName,
    @required this.imgurl,
  });

  UserModel.fromMap(Map map) {
    this.id = map['id'];
    this.email = map['Email'];
    this.city = map['city'];
    this.country = map['country'];
    this.fName = map['fName'];
    this.lName = map['lName'];
    this.imgurl = map['imgurl'];
  }
  toMap() {
    return {
      'city': this.city,
      'Email': this.email,
      'country': this.country,
      'fName': this.fName,
      'lName': this.lName,
      'imgurl': this.imgurl
    };
  }
}