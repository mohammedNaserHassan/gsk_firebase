import 'package:flutter/material.dart';
import 'package:gsk_firebase/Providers/Auth_provider.dart';
import 'package:gsk_firebase/Chating/View/constants.dart';
import 'package:provider/provider.dart';
class buildContainer extends StatelessWidget {
  const buildContainer();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context,provier,c)=>Container(
        padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding * 0.8,
          vertical: kDefaultPadding / 2,
        ),
        decoration: BoxDecoration(
            color: kPrimaryColor.withOpacity(provier.chatMessage.isSender ? 1 : 0.08),
            borderRadius: BorderRadius.circular(30)),
        child: Builder(
          builder:(context)=> Text(
            provier.chatMessage.text,
            style: TextStyle(
                color: provier.chatMessage.isSender
                    ? Colors.white
                    : Theme.of(context).textTheme.bodyText1.color),
          ),
        ),
      ),
    );
  }
}
