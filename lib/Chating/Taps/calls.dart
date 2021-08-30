import 'package:flutter/material.dart';
import 'package:gsk_firebase/Chating/Models/chat.dart';
import 'package:gsk_firebase/Chating/View/constants.dart';

class calls extends StatelessWidget {
  calls();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Text('Calls'),
      ),
      body: Container(
        child: ListView(
            children: chatsData
                .map((e) => buildRow(e.name, e.time, e.image, context))
                .toList()),
      ),
    );
  }

  Widget buildRow(
      String name, String date, String image, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric( horizontal: kDefaultPadding / 2, vertical: kDefaultPadding / 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white
      ),
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding / 2, vertical: kDefaultPadding / 2),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(image),
              ),
              SizedBox(
                width: kDefaultPadding / 4,
              ),
              Column(
                children: [
                  Text(name),
                  Row(
                    children: [
                      Icon(
                        Icons.call_made,
                        color: kPrimaryColor,
                      ),
                      Text(date),
                    ],
                  )
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.38,
              ),
              Expanded(
                  child: Icon(
                Icons.call,
                color: kPrimaryColor,
              ))
            ],
          ),
        ],
      ),
    );
  }
}
