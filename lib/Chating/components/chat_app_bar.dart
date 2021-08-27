import 'package:flutter/material.dart';
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
      builder: (context,provider,c)=>Scaffold(
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
            Expanded(
                child: ListView(
                    children: chatsData.map((e) {
              return Consumer<AuthProvider>(
                builder: (context,provider,c)=>ChatCard(
                  chat: e,
                  press: () {
                    provider.setVariables(
                      img: e.image,
                      time: e.time,
                      name: e.name,
                      mg: e.image,
                    );
                    AppRouter.appRouter.goWithAnimation(message_screen());
                    //AppRouter.appRouter.gotoPage(message_screen.routeName);

                  },
                ),
              );
            }).toList()))
          ],
        ),
      ),
    );
  }
}
