import 'package:flutter/material.dart';
import 'package:gsk_firebase/Chating/Taps/chat_screen.dart';
import 'package:gsk_firebase/Providers/Auth_provider.dart';
import 'package:gsk_firebase/Chating/View/constants.dart';
import 'package:gsk_firebase/Services/Router.dart';
import 'package:provider/provider.dart';
class buildAppBarMessage extends StatelessWidget {
  buildAppBarMessage();

  @override
  Widget build(BuildContext context) {
    return  AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kPrimaryColor,
      title: Consumer<AuthProvider>(
        builder:(context,provider,x)=> Row(
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
              backgroundImage: AssetImage(provider.img),
            ),
            Column(
              children: [
                Text(
                  provider.name,
                  style: TextStyle(fontSize: 16),
                ),
                Text('Active ${provider.time} ', style: TextStyle(fontSize: 13)),
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
