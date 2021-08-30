import 'package:flutter/material.dart';
import 'package:gsk_firebase/Chating/Taps/chat_screen.dart';
import 'package:gsk_firebase/Providers/Auth_provider.dart';
import 'package:gsk_firebase/Chating/View/constants.dart';
import 'package:gsk_firebase/Services/Router.dart';
import 'package:provider/provider.dart';

class buildAppBarMessage extends StatelessWidget {
  String image, name;

  buildAppBarMessage({this.image, this.name});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kPrimaryColor,
      title: Consumer<AuthProvider>(
        builder: (context, provider, x) => Row(
          children: [
            TextButton(
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                AppRouter.appRouter.goWithAnimation(ChatScreen());
              },
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(
                  image),
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 50),
                  child: Text(
                    name,
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                  ),
                ),
                Text('Active 8m ago', style: TextStyle(fontSize: 13)),
              ],
            )
          ],
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.call,
              color: Colors.white,
              size: 25,
            )),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.videocam_sharp,
              color: Colors.white,
              size: 25,
            ))
      ],
    );
  }
}
