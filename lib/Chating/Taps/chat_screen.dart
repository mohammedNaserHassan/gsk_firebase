import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gsk_firebase/Auth/Helper/auth_helper.dart';
import 'package:gsk_firebase/Auth/Helper/fireStore_Helper.dart';
import 'package:gsk_firebase/Auth/Helper/helper.dart';
import 'package:gsk_firebase/Chating/Models/UserModel.dart';
import 'package:gsk_firebase/Providers/Auth_provider.dart';
import 'package:gsk_firebase/Chating/Taps/people.dart';
import 'package:gsk_firebase/Chating/Taps/profile.dart';
import 'package:gsk_firebase/Chating/View/constants.dart';
import 'package:gsk_firebase/Chating/components/chat_app_bar.dart';
import 'package:gsk_firebase/Services/Router.dart';
import 'package:gsk_firebase/widgets/CustomInseration.dart';
import 'package:provider/provider.dart';

import 'calls.dart';

class ChatScreen extends StatefulWidget {
  static final routeName = 'ChateName';

  ChatScreen();

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<AuthProvider>(context, listen: false).getUserFromFirestore();
  }

  final List<Widget> _children = [Body(), people(), calls(), ProfilePage()];

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
            body: _children[provider.selected],
            floatingActionButton: FloatingActionButton(
              backgroundColor: kPrimaryColor,
              onPressed: () {
                showDialog(
                    context: AppRouter.appRouter.navkey.currentContext,
                    builder: (x) {
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
                      radius: 20,
                      backgroundImage: NetworkImage(provider.user.imgurl == null
                          ? 'https://images.freeimages.com/images/small-previews/f37/cloudy'
                              '-scotland-1392088.jpg'
                          : provider.user.imgurl),
                    ),
                    label: 'Profile'),
              ],
            ),
            drawer: Drawer(
              child: Consumer<AuthProvider>(
                builder: (context, provider, c) => ListView(
                  children: [
                    Container(
                      color: kPrimaryColor,
                      height: 150,
                      child: UserAccountsDrawerHeader(
                          otherAccountsPicturesSize: Size(65, 65),
                          otherAccountsPictures: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(provider
                                          .user.imgurl ==
                                      null
                                  ? 'https://images.freeimages.com/images/small-previews/f37/cloudy'
                                      '-scotland-1392088.jpg'
                                  : provider.user.imgurl),
                            ),
                          ],
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          accountName: Row(
                            children: [
                              Text(
                                provider.user.fName,
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                provider.user.lName,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          accountEmail: Text(provider.user.email,
                              style: TextStyle(color: Colors.white))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ListTile(
                          title: Text('Get All Users'),
                          trailing: Icon(
                            Icons.supervised_user_circle_rounded,
                            color: kPrimaryColor,
                          ),
                          onTap: () {
                            fireStore_Helper.helper.getAllUsersFromFirestore();
                          }),
                    ),
                    IconButton(
                        onPressed: () {
                          Helper.x.Signout();
                          provider.logOut();
                          exit(0);
                        },
                        icon: ListTile(
                          title: Text('Log out'),
                          trailing: Icon(
                            Icons.login_outlined,
                            color: kPrimaryColor,
                          ),
                        )),
                    Center(
                      child: ListTile(
                          title: Text('Get Current User'),
                          trailing: Icon(
                            Icons.person,
                            color: kPrimaryColor,
                          ),
                          onTap: () async {
                            provider.getUserFromFirestore();
                            // fireStore_Helper.helper.getUserFromFirestore();
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
