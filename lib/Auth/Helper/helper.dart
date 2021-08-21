import 'package:shared_preferences/shared_preferences.dart';


class Helper{
  Helper._();
  static Helper x =Helper._();
SharedPreferences sharedPreferences;

initSharedPreference()async{
  sharedPreferences= await SharedPreferences.getInstance();
}
SaveUsername(String email){
sharedPreferences.setString('name', email);
}
String GetUsername(){
  return sharedPreferences.getString('name');
}

Signout(){
  sharedPreferences.remove('name');
}

}