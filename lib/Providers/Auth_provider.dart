import 'dart:io';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsk_firebase/Auth/Helper/auth_helper.dart';
import 'package:gsk_firebase/Auth/Helper/fireStorageHelper.dart';
import 'package:gsk_firebase/Auth/Helper/fireStore_Helper.dart';
import 'package:gsk_firebase/Auth/ui/login.dart';
import 'package:gsk_firebase/Chating/Models/ChatFirebase.dart';
import 'package:gsk_firebase/Chating/Models/CountryModel.dart';
import 'package:gsk_firebase/Chating/Models/RegisterRequest.dart';
import 'package:gsk_firebase/Chating/Models/chat.dart';
import 'package:gsk_firebase/Chating/Screens/sigh_in_or_sign_up.dart';
import 'package:gsk_firebase/Chating/Screens/welcome_page.dart';
import 'package:gsk_firebase/Chating/Taps/chat_screen.dart';
import 'package:gsk_firebase/Services/Router.dart';
import 'package:gsk_firebase/Services/customDialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';


class AuthProvider extends ChangeNotifier {
////////////////////////Constructor////////////////////////
  AuthProvider(){
    getCountriesFromFirestore();

  }
  ////////////////////////////////////////////////

  ////////////////////////////////////////////////

  isActiveState(){
    for(int i=0;i<freindsprovider.length;i++){
      if(freindsprovider[i]['isActive']==true){
        active.add(freindsprovider[i]);
      }
      else
      {
        inactive.add(freindsprovider[i]);
      }
      notifyListeners();
    }}
  ////////////////////////////////////////////////

  /////Controller of message chat
  TextEditingController msgController = TextEditingController();
  clearMsg(){
    msgController.clear();
  }
//////////////////////////////////////////////////
  TextEditingController searchController = TextEditingController();

  //upload Image

  File file;
  selectFile() async {
    XFile imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    this.file = File(imageFile.path);
    notifyListeners();
  }
  ///////////
  /////Uploade Multi Image
  List<Asset> images = <Asset>[];
  Future<void>  selectMultiFiles()async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    File secondfile;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat().add_jm().format(now);
    resultList.forEach((element) async {
      var path = await FlutterAbsolutePath.getAbsolutePath(element.identifier);
      secondfile = File(path);
      String imgesUrl = await fireStorageHelper.helper.uploadImage(
          secondfile, 'categoreis');
      fireStore_Helper.helper.addMessageToFireStore({
        'userId': this.myId,
        'timeDate': formattedDate,
        'message': 'No Image Selected',
        'imgesUrl': imgesUrl,
      });
    });
        }



  /////////////////////////////////////////////////////////////////////////////

  ///SetColor of Button////
  bool isFilled = true;
  bool isFill = false;
  bool isActive= false;
  List<dynamic> active=[] , inactive=[];
List<Map> freindsprovider=[];
bool recent=true;
  setFilled() {
    this.isActive=!this.isActive;
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

  //////Select File from Phone//////
  List<String> paths=[];
  FilePickerResult result;
  selectFilesToFire()async{
    result = await FilePicker.platform.pickFiles(allowMultiple: true,type:  FileType.custom,
      allowedExtensions: ['pdf'],);
      List<File> files = result.files.map((path) => File(path.path)).toList();
    File otherfile;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat().add_jm().format(now);
    files.forEach((element) async {
      paths.add(element.path);
      otherfile = File(element.path);
      String files = await fireStorageHelper.helper.uploadImage(
          otherfile, 'Files');
      fireStore_Helper.helper.addMessageToFireStore({
        'userId': this.myId,
        'timeDate': formattedDate,
        'message': 'No Image Selected',
        'imgesUrl':'no images selected',
        'files':files,
      });
    });

notifyListeners();
  }

  /////////////////////////////////////////

///////////////////Send Message To Firebase
  ScrollController controller = ScrollController();
  String message;
  sendToFire()async{
    DateTime now = DateTime.now();
    String formattedDate = DateFormat().add_jm().format(now);
    if(msgController.text!='')
    fireStore_Helper.helper.addMessageToFireStore({
      'message':msgController.text,
      'timeDate':formattedDate
    });
    Future.delayed(Duration(milliseconds: 10)).then((value) {
      controller.animateTo(controller.position.maxScrollExtent,
          duration: Duration(milliseconds: 100),
          curve: Curves.easeOutCubic);
    });
  }
////////////////////////////////////////////////////////////

///////////////////Send Image To Fire
  sendImageToFire()async{
 XFile file;
 file = await ImagePicker().pickImage(source: ImageSource.gallery);
 File file2= File(file.path);
 DateTime now = DateTime.now();
 String formattedDate = DateFormat().add_jm().format(now);
   String imgUrl = await fireStorageHelper.helper.uploadImage(file2,'chats');
   fireStore_Helper.helper.addMessageToFireStore({
       'userId':this.myId,
       'timeDate':formattedDate,
       'message':'No Image',
       'imgUrl':imgUrl,
     }
   );

  }


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
  List<CountryModel> countries=[];
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
     // myId =Auth_helper.auth_helper.getUserId();
      this.countries=
          await fireStore_Helper.helper.getAllCountreis();
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
    AppRouter.appRouter.gotoPagewithReplacment(Login.routeName);
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
    notifyListeners();
  }
  /////////////////////

  //////Get All Freinds////////
  List<Chat> friends;
  getAllFreinds()async{
    friends = await fireStore_Helper.helper.getAllFreindsFromFirestore();
    notifyListeners();
  }
  /////////////////////

//////Check User Found///////
  checkLogin() {
    bool isLoggin = Auth_helper.auth_helper.checkUser();
    if (isLoggin) {
      this.myId = Auth_helper.auth_helper.getUserId();
      getMessage();
      getUserFromFirestore();
      getAllUsers();
      getAllFreinds();
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
