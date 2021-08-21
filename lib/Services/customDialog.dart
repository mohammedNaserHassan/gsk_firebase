import 'package:flutter/material.dart';

import 'Router.dart';
class CustomDialog{
  CustomDialog._();
 static CustomDialog customDialog = CustomDialog._();
  showCustom(String text,[Function function]){
    showDialog(context: AppRouter.appRouter.navkey.currentContext, builder: (x){
      return AlertDialog(
        content: Text(text),
        actions: [
          TextButton(onPressed: (){
            if(function==null){
            AppRouter.appRouter.back();}
            else{
              function;
              AppRouter.appRouter.back();
            }
          }, child: Text('OK'))
        ],
      );
    });
  }
}