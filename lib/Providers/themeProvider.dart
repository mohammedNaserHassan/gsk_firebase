import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
enum MyThemeMode{light,dark}
class ThemeProvider extends ChangeNotifier{
  ThemeData themeData=ThemeData.light();
    setThemeData(MyThemeMode  mythemeMode){
      themeData=mythemeMode==MyThemeMode.light?ThemeData.light():ThemeData.dark();
      notifyListeners();
    }
}