import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsk_firebase/Auth/Helper/auth_helper.dart';
import 'package:gsk_firebase/Auth/Helper/fireStorageHelper.dart';
import 'package:gsk_firebase/Auth/Helper/fireStore_Helper.dart';
import 'package:gsk_firebase/Auth/Helper/helper.dart';
import 'package:gsk_firebase/Auth/ui/login.dart';
import 'package:gsk_firebase/Chating/Models/CountryModel.dart';
import 'package:gsk_firebase/Chating/Models/RegisterRequest.dart';
import 'package:gsk_firebase/Chating/Models/chat.dart';
import 'package:gsk_firebase/Chating/Models/messages_.dart';
import 'package:gsk_firebase/Chating/Taps/chat_screen.dart';
import 'package:gsk_firebase/Services/Router.dart';
import 'package:gsk_firebase/Services/customDialog.dart';
import 'package:image_picker/image_picker.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider(){
    getCountriesFromFirestore();
  }

  //upload Image
  File file;
  selectFile() async {
    XFile imageFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    this.file = File(imageFile.path);
    notifyListeners();
  }
  String x = chatsData.map((e) => e.image).toString();
  bool isFilled = true;
  bool isFill = false;

  setFilled() {
    this.isFilled = !this.isFilled;
    this.isFill = !this.isFill;
    notifyListeners();
  }

  int selected = 0;

  setSelected(int selected) {
    this.selected = selected;
    notifyListeners();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  clearController() {
    emailController.clear();
    passwordController.clear();
    fNameController.clear();
    lNameController.clear();
    countryController.clear();
    cityController.clear();
  }

  String name, time, img, mg;

  setVariables({String name, String time, String img, String mg}) {
    this.name = name;
    this.time = time;
    this.img = img;
    this.mg = mg;
  }

  Chat chat;
  VoidCallback press;
  ChatMessage chatMessage;

  setChatMessage(ChatMessage chatMessage) {
    this.chatMessage = chatMessage;
  }
  List<CountryModel> countries;
  List<dynamic> cities = [];
  CountryModel selectedCountry;
  String selectedCity;
  selectCountry(CountryModel countryModel) {
    this.selectedCountry = countryModel;
    this.cities = countryModel.cities;
    selectCity(cities.first.toString());
    notifyListeners();
  }

  selectCity(dynamic city) {
    this.selectedCity = city;
    notifyListeners();
  }

  getCountriesFromFirestore() async {
    List<CountryModel> countries =
    await fireStore_Helper.helper.getAllCountreis();
    this.countries = countries;
    selectCountry(countries.first);
    notifyListeners();
  }
  register() async {
    try {
      UserCredential userCredential = await Auth_helper.auth_helper
          .signup(emailController.text, passwordController.text);
      String imageUrl =
      await fireStorageHelper.helper.uploadImage(file);
      RegisterRequest registerRequest = RegisterRequest(
          imgurl: imageUrl,
          id: userCredential.user.uid,
          city: selectedCity,
          country: selectedCountry.name,
          Email: emailController.text,
          fName: fNameController.text,
          lName: lNameController.text,
          password: passwordController.text);
      await fireStore_Helper.helper.addUserToFireBase(registerRequest);
      await Auth_helper.auth_helper.vereifyEmail();
      await Auth_helper.auth_helper.signOut();
      AppRouter.appRouter.gotoPagewithReplacment(Login.routeName);
    } on Exception catch (e) {
      print(e);
    }

    clearController();
    notifyListeners();
  }

  login() async {
   UserCredential userCredential = await Auth_helper.auth_helper.signin(emailController.text, passwordController.text);
await fireStore_Helper.helper.getUserFromFirestore('zAr98MNwxfTFP5tYtGIF848cPw93');
    bool isVerified = Auth_helper.auth_helper.checkEmailVerification();
    print(isVerified);
    if (isVerified) {
      AppRouter.appRouter.gotoPagewithReplacment(ChatScreen.routeName);
      await Helper.x.SaveUsername(emailController.text);
    } else {
      CustomDialog.customDialog.showCustom(
          'You have to verify your email,press ok to send another email',
          sendVerification);
    }

    clearController();
    notifyListeners();
  }

  sendVerification() {
    Auth_helper.auth_helper.vereifyEmail();
    Auth_helper.auth_helper.signOut();
  }

  resetPassword() async {
    Auth_helper.auth_helper.resetPassword(emailController.text);
    clearController();
  }

  getUser() {
    Auth_helper.auth_helper.getCurrentUser();
  }

  logOut() async {
    await Auth_helper.auth_helper.signOut();
  }
}
