import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AppRouter{
  AppRouter._();
  static AppRouter appRouter =AppRouter._();
  GlobalKey<NavigatorState> navkey = GlobalKey<NavigatorState>();

goWithAnimation(Widget widget){
  navkey.currentState.pushReplacement(
    PageTransition(
      alignment: Alignment.bottomCenter,
      duration: Duration(milliseconds:800),
      curve: Curves.bounceOut,
      type: PageTransitionType.rightToLeftWithFade,
      child: widget,
    ),
  );
}
  gotoPagewithReplacment(String routeName){
    navkey.currentState.pushReplacementNamed(routeName);

  }
  back(){
    navkey.currentState.pop();
  }
}