import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsk_firebase/Auth/Helper/auth_helper.dart';
import 'package:gsk_firebase/Auth/Helper/fireStore_Helper.dart';
import 'package:gsk_firebase/Auth/Helper/helper.dart';
import 'package:gsk_firebase/Auth/ui/login.dart';
import 'package:gsk_firebase/Chating/Models/RegisterRequest.dart';
import 'package:gsk_firebase/Chating/Models/chat.dart';
import 'package:gsk_firebase/Chating/Models/messages_.dart';
import 'package:gsk_firebase/Chating/Taps/chat_screen.dart';
import 'package:gsk_firebase/Services/Router.dart';
import 'package:gsk_firebase/Services/customDialog.dart';

class AuthProvider extends ChangeNotifier {
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

  register() async {
    try {
      UserCredential userCredential = await Auth_helper.auth_helper
          .signup(emailController.text, passwordController.text);
      RegisterRequest registerRequest =RegisterRequest(
        id: userCredential.user.uid,
          fName: fNameController.text,
          lName: lNameController.text,
          country: countryController.text,
          city: cityController.text,
          Email: emailController.text
      );
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
