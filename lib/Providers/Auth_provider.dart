import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsk_firebase/Auth/Helper/auth_helper.dart';
import 'package:gsk_firebase/Auth/Helper/fireStorageHelper.dart';
import 'package:gsk_firebase/Auth/Helper/fireStore_Helper.dart';
import 'package:gsk_firebase/Auth/Helper/helper.dart';
import 'package:gsk_firebase/Auth/ui/login.dart';
import 'package:gsk_firebase/Chating/Models/ChatFirebase.dart';
import 'package:gsk_firebase/Chating/Models/CountryModel.dart';
import 'package:gsk_firebase/Chating/Models/RegisterRequest.dart';
import 'package:gsk_firebase/Chating/Models/chat.dart';
import 'package:gsk_firebase/Chating/Models/messages_.dart';
import 'package:gsk_firebase/Chating/Screens/sigh_in_or_sign_up.dart';
import 'package:gsk_firebase/Chating/Screens/welcome_page.dart';
import 'package:gsk_firebase/Chating/Taps/chat_screen.dart';
import 'package:gsk_firebase/Services/Router.dart';
import 'package:gsk_firebase/Services/customDialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AuthProvider extends ChangeNotifier {

////////////////////////Constructor////////////////////////
  AuthProvider() {
    getCountriesFromFirestore();
    getAllUsers();
    getAllFreinds();
  }
  ////////////////////////////////////////////////

  /////Controller of message chat
  TextEditingController msgController = TextEditingController();
  clearMsg(){
    msgController.clear();
  }
//////////////////////////////////////////////////


  //upload Image

  File file;
  selectFile() async {
    XFile imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    this.file = File(imageFile.path);
    notifyListeners();
  }
  ///////////

  ///SetColor of Button////
  bool isFilled = true;
  bool isFill = false;
bool recent=true;
  setFilled() {
    this.isFilled = !this.isFilled;
    this.isFill = !this.isFill;
    this.recent=!this.recent;
    notifyListeners();
  }

////////////////////

  ///select of button/////////
  int selected = 0;
  TabController tabController;
  setSelected(int selected) {
    this.selected = selected;
    tabController.animateTo(selected);
    notifyListeners();
  }

//////////////////////////////

///////////////////Send Message To Firebase

  String message;
  sendToFire()async{
    DateTime now = DateTime.now();
    String formattedDate = DateFormat().add_jm().format(now);
    fireStore_Helper.helper.addMessageToFireStore({
      'message':this.message,
      'timeDate':formattedDate
    });
  }
////////////////////////////////////////////////////////////

///////////////////Get Message from firebase
  List<ChatFire> chatFire;
getMessage()async{
 chatFire = await fireStore_Helper.helper.getMessageFromFireStore();
 print(chatFire.asMap());

}

  ////////////////////////////////////////////////////////////


  //////Controller//////
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

////////////////////////////////////


  //////Country and City  Firebase////////////
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
    try {
      myId =Auth_helper.auth_helper.getUserId();
      List<CountryModel> countries =
          await fireStore_Helper.helper.getAllCountreis();
      this.countries = countries;
      selectCountry(countries.first);
      notifyListeners();
    } on Exception catch (e) {
      // TODO
    }
  }

  /////////////////////////////////

  /////Sign up//////////////////////////////

  register() async {
    try {
      UserCredential userCredential = await Auth_helper.auth_helper
          .signup(emailController.text, passwordController.text);

      String imageUrl = await fireStorageHelper.helper.uploadImage(file);
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

////////////////////////////////////////////////

  //////Login////////////////////////////////////
  login() async {
    UserCredential userCredential = await Auth_helper.auth_helper
        .signin(emailController.text, passwordController.text);
    String userId = Auth_helper.auth_helper.getUserId();
    await fireStore_Helper.helper.getUserFromFirestore();
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

//////////////////////////////////////////////////////

  //////Verification//////////////////////
  sendVerification() {
    Auth_helper.auth_helper.vereifyEmail();
    Auth_helper.auth_helper.signOut();
  }

//////////////////////////////////////////////////////

  //////////////////Reset Password////////////////////////
  resetPassword() async {
    Auth_helper.auth_helper.resetPassword(emailController.text);
    clearController();
  }
/////////////

  //////Get Friend//////////////////////////////

  Chat chatFreind;

  getFriendFromFire() async {
    chatFreind = await fireStore_Helper.helper.getFriendFromFirebase('rdfyghhjkkk');
    // print(user.toMap());
    notifyListeners();
  }
  ///////////////
  //////////////////////////////Controller of Freind
  TextEditingController nFreind = TextEditingController();
  TextEditingController idFreind = TextEditingController();
  //////////////////////////////////////////////////////////////////////////////////////////

//////////Add new Freind////

  File fileFreind;
  selectFileFreind() async {
    XFile imageFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    this.fileFreind = File(imageFile.path);
    notifyListeners();
  }



  addNewFreind()async{
    String imageUrl = await fireStorageHelper.helper.uploadImage(fileFreind);
    Chat freinds = Chat(
      id: idFreind.text,
    image: imageUrl,
    name: nFreind.text,
    isActive: false,
    lastMessage: 'are you ready',
    time: '20m ago'
    );
    await fireStore_Helper.helper.addFriendToFirestore(freinds);
    idFreind.clear();
    nFreind.clear();
    fileFreind=null;
    notifyListeners();

  }

  ////////////////////////////////////////

//////GetCurrent User//////////////////////////////

  RegisterRequest user;

  getUserFromFirestore() async {
    user = await fireStore_Helper.helper.getUserFromFirestore();
   // print(user.toMap());
    notifyListeners();
  }
  ///////////////

   //////Get All Users////////
  List<RegisterRequest> users;
  String myId;

  getAllUsers()async{
    users = await fireStore_Helper.helper.getAllUsersFromFirestore();
    users.removeWhere((element) => element.id==myId);
  }
  /////////////////////

  //////Get All Freinds////////
  List<Chat> friends;
  getAllFreinds()async{
    friends = await fireStore_Helper.helper.getAllFreindsFromFirestore();
  }
  /////////////////////

//////Check User Found///////
  checkLogin() {
    bool isLoggin = Auth_helper.auth_helper.checkUser();
    if (isLoggin) {
      AppRouter.appRouter.gotoPagewithReplacment(ChatScreen.routeName);
    } else {
      AppRouter.appRouter.gotoPagewithReplacment(sigh_in_or_sign_up.routeName);
    }
  }

  ///////////////////////
  fillControllers() {
    emailController.text = user.Email;
    fNameController.text = user.fName;
    lNameController.text = user.lName;
    countryController.text = user.country;
    cityController.text = user.city;
  }

  File updatedFile;

  captureUpdateProfileImage() async {
    XFile file = await ImagePicker().pickImage(source: ImageSource.gallery);
    this.updatedFile = File(file.path);
    notifyListeners();
  }

  updateProfile() async {
    String imageUrl;
    if (updatedFile != null) {
      imageUrl = await fireStorageHelper.helper.uploadImage(updatedFile);
    }
    RegisterRequest userModel = RegisterRequest(
      Email: emailController.text,
            city: cityController.text,
            country: countryController.text,
            fName: fNameController.text,
            lName: lNameController.text,
            id: user.id,
        imgurl: imageUrl??user.imgurl);

    await fireStore_Helper.helper.updateProfile(userModel);
    getUserFromFirestore();
    Navigator.of(AppRouter.appRouter.navkey.currentContext).pop();
  }

//////////////////Sign out////////////////////////////////////
  logOut() async {
    await Auth_helper.auth_helper.signOut();
    AppRouter.appRouter.gotoPagewithReplacment(welcomPage.routeName);
  }
/////////////////////
}
