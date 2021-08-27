import 'package:flutter/material.dart';
import 'package:gsk_firebase/Chating/Models/chat.dart';
import 'package:gsk_firebase/Chating/View/constants.dart';

class people extends StatelessWidget {
  people();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('People'),
      ),
      body: Container(
        child: ListView(
            children: chatsData
                .map((e) => ListTile(
                      title: Text(e.name),
                      trailing: Text(e.time),
                      leading: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                            color: kPrimaryColor, shape: BoxShape.circle),
                      ),
                    ))
                .toList()),
      ),
    );
  }
}
