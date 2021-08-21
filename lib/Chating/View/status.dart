import 'package:flutter/material.dart';
import 'package:gsk_firebase/Chating/Models/messages_.dart';

import 'constants.dart';

class statew extends StatelessWidget {
  final MessageStatus messageStatus;

  statew(this.messageStatus);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: kDefaultPadding / 4),
      width: 15,
      height: 15,
      decoration: BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle),
      child: Icon(
        messageStatus == MessageStatus.not_sent ? Icons.close : Icons.done,
        size: 12,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
