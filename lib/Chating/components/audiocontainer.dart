import 'package:flutter/material.dart';
import 'package:gsk_firebase/Providers/Auth_provider.dart';
import 'package:gsk_firebase/Chating/View/constants.dart';
import 'package:provider/provider.dart';

class audio_container extends StatelessWidget {
  audio_container();


  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context,provider,x)=>Container(
        margin: EdgeInsets.symmetric(horizontal: kDefaultPadding / 5),
        width: MediaQuery.of(context).size.width * 0.55,
        height: 30,
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: kPrimaryColor.withOpacity(provider.chatMessage.isSender ? 1 : 0.1)),
        child: Row(
          children: [
            Icon(
              Icons.play_arrow,
              color: !provider.chatMessage.isSender ? kPrimaryColor : Colors.white,
            ),
            Expanded(
                child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: 2,
                  color: provider.chatMessage.isSender
                      ? Colors.white
                      : kPrimaryColor.withOpacity(0.4),
                ),
                Positioned(
                  left: 0,
                  top: -2,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                        color: kPrimaryColor, shape: BoxShape.circle),
                  ),
                )
              ],
            )),
            SizedBox(
              width: kDefaultPadding / 5,
            ),
            Text(
              '0.37',
              style: TextStyle(
                  color: provider.chatMessage.isSender ? Colors.white : null,
                  fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
