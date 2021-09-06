import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gsk_firebase/Auth/Helper/fireStore_Helper.dart';
import 'package:gsk_firebase/Providers/Auth_provider.dart';
import 'package:gsk_firebase/Chating/Screens/message_screen.dart';
import 'package:gsk_firebase/Chating/View/constants.dart';
import 'package:gsk_firebase/Providers/themeProvider.dart';
import 'package:gsk_firebase/Services/Router.dart';
import 'package:gsk_firebase/Services/Search.dart';
import 'package:gsk_firebase/Services/SearchService.dart';
import 'package:provider/provider.dart';

import 'chat_cards.dart';
import 'filled_outline_button.dart';

class Body extends StatefulWidget {
  Body();

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String searchKey;

  Future<void> _showSearch() async {
    await showSearch(
      context: context,
      delegate: TheSearch(),
      query: "aslan",
    );
  }

  @override
  void initState() {
    Provider.of<AuthProvider>(context, listen: false).getAllFreinds();
    Provider.of<AuthProvider>(context, listen: false).isActiveState();
    super.initState();
  }

  AppBar BuildAbb() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: kPrimaryColor,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Text(
            'Chats',
            style: TextStyle(fontSize: 22),
          ),
        ],
      ),
      actions: [
        IconButton(onPressed: () {
          _showSearch();
        }, icon: Icon(Icons.search, color: Colors.white,)),
        Consumer<ThemeProvider>(
            builder: (context, provider, c) =>
                Switch(
                  activeTrackColor: Colors.white,
                    inactiveTrackColor: Colors.black,
                    activeColor: Colors.black,
                    value: provider.themeData == ThemeData.light(),
                    onChanged: (value) {
                      if (value) {
                        provider.setThemeData(MyThemeMode.light);
                      }
                      else {
                        provider.setThemeData(MyThemeMode.dark);
                      }
                    })
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, c) =>
          Scaffold(
            appBar: BuildAbb(),
            body: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(
                      kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
                  color: kPrimaryColor,
                  child: Row(
                    children: [
                      FillOutlineButton(
                        text: 'Recent Message',
                        press: () {
                          provider.setFilled();
                        },
                        isFilled: provider.isFilled,
                      ),
                      SizedBox(
                        width: kDefaultPadding,
                      ),
                      FillOutlineButton(
                        isFilled: provider.isFill,
                        text: 'Active',
                        press: () {
                          provider.setFilled();
                        },
                      ),
                    ],
                  ),
                ),
                provider.friends == null
                    ? CircularProgressIndicator()
                    : Expanded(
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: fireStore_Helper.helper.getFreindStream(),
                        builder: (context, snapshots) {
                          if (!snapshots.hasData) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            QuerySnapshot<Map<String, dynamic>> query =
                                snapshots.data;
                            List<Map> freinds =
                            query.docs.map((e) => e.data()).toList();
                            provider.freindsprovider= freinds;
                            return
                              provider.isActive==true?
                              ListView.builder(
                              itemCount: provider.active.length,
                              itemBuilder: (context, index) {
                                return ChatCard(
                                  name: provider.active[index]['name'],
                                  image: provider.active[index]['image'],
                                  time: provider.active[index]['time'],
                                  isActive: provider.active[index]['isActive'],
                                  lastMessage: provider.active[index]['lastMessage'],
                                  press: () {
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                        builder: (c) =>
                                            message_screen(
                                              image: freinds[index]['name'],
                                              name: freinds[index]['image'],
                                            )));
                                  },
                                );
                              },
                            ):
                              ListView.builder(
                                itemCount: provider.inactive.length,
                                itemBuilder: (context, index) {
                                  return ChatCard(
                                    name: provider.inactive[index]['name'],
                                    image: provider.inactive[index]['image'],
                                    time: provider.inactive[index]['time'],
                                    isActive: provider.inactive[index]['isActive'],
                                    lastMessage: provider.inactive[index]['lastMessage'],
                                    press: () {
                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                          builder: (c) =>
                                              message_screen(
                                                image: freinds[index]['name'],
                                                name: freinds[index]['image'],
                                              )));
                                    },
                                  );
                                },
                              )
                            ;
                          }
                        }))
              ],
            ),
          ),
    );
  }
}
