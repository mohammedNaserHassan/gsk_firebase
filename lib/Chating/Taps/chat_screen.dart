import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gsk_firebase/Auth/Helper/fireStore_Helper.dart';
import 'package:gsk_firebase/Auth/Helper/helper.dart';
import 'package:gsk_firebase/Providers/Auth_provider.dart';
import 'package:gsk_firebase/Chating/Taps/people.dart';
import 'package:gsk_firebase/Chating/Taps/profile.dart';
import 'package:gsk_firebase/Chating/View/constants.dart';
import 'package:gsk_firebase/Chating/components/chat_app_bar.dart';
import 'package:gsk_firebase/Services/Router.dart';
import 'package:gsk_firebase/widgets/CustomInseration.dart';
import 'package:provider/provider.dart';

import 'calls.dart';

class ChatScreen extends StatelessWidget {
  static final routeName = 'ChateName';

  ChatScreen();


  final List<Widget> _children = [Body(), people(), calls(), profile()];

  AppBar BuildAbb() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: kPrimaryColor,
      automaticallyImplyLeading: false,
      title: Text(
        'Chats',
        style: TextStyle(fontSize: 22),
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Colors.white,
            )),
        Center(
          child: TextButton(
              child: Text('GetAllUsers'),
              onPressed: () {
            fireStore_Helper.helper.getAllUsersFromFirestore();
          }),
        ),
        Consumer<AuthProvider>(
          builder: (context,provider,c)=>IconButton(
              onPressed: () {
                Helper.x.Signout();
                provider.logOut();
                exit(0);
              },
              icon: Icon(
                Icons.login_outlined,
                color: Colors.white,
              )),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          exit(0);
        },
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Consumer<AuthProvider>(
          builder: (context, provider, c) => Scaffold(
            appBar: BuildAbb(),
            body: _children[provider.selected],
            floatingActionButton: FloatingActionButton(
              backgroundColor: kPrimaryColor,
              onPressed: () {
      showDialog(context: AppRouter.appRouter.navkey.currentContext, builder: (x){
      return CustomInseration();
      });
              },
              child: Icon(
                Icons.person_add_alt_1,
                color: Colors.white,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: provider.selected,
              onTap: (select) {
                provider.setSelected(select);
              },
              type: BottomNavigationBarType.fixed,
              backgroundColor: kContentColorDarkTheme,
              selectedItemColor: Colors.white70,
              unselectedItemColor: kContentColorLightTheme.withOpacity(0.32),
              selectedIconTheme: IconThemeData(color: kPrimaryColor),
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.messenger), label: 'Chats'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.people), label: 'People'),
                BottomNavigationBarItem(icon: Icon(Icons.call), label: 'Calls'),
                BottomNavigationBarItem(
                    icon: CircleAvatar(
                      radius: 14,
                      backgroundImage: AssetImage('assets/images/user_2.png'),
                    ),
                    label: 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
