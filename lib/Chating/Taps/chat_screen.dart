import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gsk_firebase/Providers/Auth_provider.dart';
import 'package:gsk_firebase/Chating/Taps/people.dart';
import 'package:gsk_firebase/Chating/Taps/profile.dart';
import 'package:gsk_firebase/Chating/View/constants.dart';
import 'package:gsk_firebase/Chating/components/chat_app_bar.dart';
import 'package:gsk_firebase/Services/Router.dart';
import 'package:gsk_firebase/widgets/CustomInseration.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  static final routeName = 'ChateName';

  ChatScreen();

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Provider.of<AuthProvider>(context, listen: false).tabController =
        TabController(length: 3, vsync: this);
    Provider.of<AuthProvider>(context, listen: false).getUserFromFirestore();
  }



  final List<Widget> _children = [Body(), people(), ProfilePage()];


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        exit(0);
      },
      child: Consumer<AuthProvider>(
        builder: (context, provider, v) => DefaultTabController(
          length: 4,
          child: provider.user == null
              ? Container(
                  color: Theme.of(context).backgroundColor,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  ))
              : Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Consumer<AuthProvider>(
                    builder: (context, provider, c) => Scaffold(
                      body: TabBarView(
                          controller: provider.tabController,
                          children: _children),
                      floatingActionButton: FloatingActionButton(
                        backgroundColor: kPrimaryColor,
                        onPressed: () {
                          showDialog(
                              context:
                                  AppRouter.appRouter.navkey.currentContext,
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
                        backgroundColor: Theme.of(context).hoverColor,
                        type: BottomNavigationBarType.fixed,
                        items: [
                          BottomNavigationBarItem(
                              icon: Icon(
                                Icons.messenger,
                                color: kPrimaryColor,
                              ),
                              title: Text(
                                'Chat',
                                style: TextStyle(color: kPrimaryColor),
                              )),
                          BottomNavigationBarItem(
                              icon: Icon(
                                Icons.people,
                                color: kPrimaryColor,
                              ),
                              title: Text(
                                'People',
                                style: TextStyle(color: kPrimaryColor),
                              )),
                          BottomNavigationBarItem(
                              icon: CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                    NetworkImage(provider.user.imgurl),
                              ),
                              title: Text(
                                'Profile',
                                style: TextStyle(color: kPrimaryColor),
                              )),
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
