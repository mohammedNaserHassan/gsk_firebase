import 'package:flutter/material.dart';
import 'package:gsk_firebase/Chating/View/constants.dart';

import 'messeges.dart';

class body_message extends StatelessWidget {
  body_message();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        messeges(),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 32,
                color: Color(0xfF087949).withOpacity(0.08))
          ], color: Theme.of(context).scaffoldBackgroundColor),
          child: SafeArea(
            child: Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.mic,
                      color: kPrimaryColor,
                    )),
                SizedBox(
                  width: kDefaultPadding / 2,
                ),
                Expanded(
                    child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    children: [
                      buildIconButton(Icons.sentiment_satisfied_alt_outlined),
                      SizedBox(
                        width: kDefaultPadding / 4,
                      ),
                      Expanded(
                          child: TextField(
                        decoration: InputDecoration(
                            hintText: 'Type message', border: InputBorder.none),
                      )),
                      buildIconButton(Icons.attach_file),
                      buildIconButton(Icons.camera_alt_outlined),
                    ],
                  ),
                ))
              ],
            ),
          ),
        )
      ],
    );
  }

  IconButton buildIconButton(IconData icon) {
    return IconButton(
        onPressed: () {},
        icon: Builder(
          builder: (context) => Icon(
            icon,
            color:
                Theme.of(context).textTheme.bodyText1.color.withOpacity(0.64),
          ),
        ));
  }
}
