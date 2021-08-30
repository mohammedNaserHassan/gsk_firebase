import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gsk_firebase/Auth/Helper/fireStore_Helper.dart';
import 'package:gsk_firebase/Providers/Auth_provider.dart';
import 'package:gsk_firebase/Chating/Models/chat.dart';
import 'package:gsk_firebase/Chating/Screens/message_screen.dart';
import 'package:gsk_firebase/Chating/View/constants.dart';
import 'package:gsk_firebase/Services/Router.dart';
import 'package:provider/provider.dart';

import 'chat_cards.dart';
import 'filled_outline_button.dart';

class Body extends StatelessWidget {
  Body();

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
    return Consumer<AuthProvider>(
      builder: (context, provider, c) => Scaffold(
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
                    child:StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: fireStore_Helper.helper.getFreindStream(),
    builder: (context, snapshots) {
    if (!snapshots.hasData) {
    return Center(child: CircularProgressIndicator());
    } else {
      QuerySnapshot<Map<String, dynamic>> query = snapshots.data;
      List<Map> freinds = query.docs.map((e) => e.data()).toList();
       return  ListView.builder(
        itemCount: freinds.length,
        itemBuilder: (context, index) {
          return ChatCard(
            name: freinds[index]['name'],
            image: freinds[index]['image'],
            time: freinds[index]['time'],
            isActive: freinds[index]['isActive'],
            lastMessage: freinds[index]['lastMessage'],
            press: () {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(
                      builder: (c) => message_screen(
                            image: freinds[index]['name'],
                            name:  freinds[index]['image'],
                          )));
            },
          );
        },
      );
    }
    }
                    )



            )
          ],
        ),
      ),
    );
  }
}
