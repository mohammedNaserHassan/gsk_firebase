import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsk_firebase/Auth/Helper/auth_helper.dart';
import 'package:gsk_firebase/Auth/Helper/fireStore_Helper.dart';
import 'package:gsk_firebase/Chating/View/constants.dart';
import 'package:gsk_firebase/Providers/Auth_provider.dart';
import 'package:provider/provider.dart';

class body_message extends StatelessWidget {

  body_message();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Consumer<AuthProvider>(
          builder: (context, provider, i) => Container(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: fireStore_Helper.helper.getFireStream(),
              builder: (context, snapshots) {
                if (!snapshots.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  QuerySnapshot<Map<String, dynamic>> query = snapshots.data;
                  List<Map> messages = query.docs.map((e) => e.data()).toList();
                  messages.sort((a, b) {
                    var adate = a['timeDate'];
                    var bdate = b['timeDate'];
                    return adate.compareTo(bdate);
                  });
                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return Consumer<AuthProvider>(
                        builder: (context, provier, c) => Row(
                          mainAxisAlignment: messages[index]['userId'] ==
                                  Auth_helper.auth_helper.getUserId()
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.none,
                              child: Container(
                                height: 40,
                                margin: EdgeInsets.symmetric(vertical: 8),
                                padding: EdgeInsets.symmetric(
                                  horizontal: kDefaultPadding * 0.8,
                                  vertical: kDefaultPadding / 2,
                                ),
                                decoration: BoxDecoration(
                                    color: kPrimaryColor.withOpacity(
                                        Auth_helper.auth_helper.getUserId() ==
                                                messages[index]['userId']
                                            ? 1
                                            : 0.08),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  mainAxisAlignment:
                                      Auth_helper.auth_helper.getUserId() ==
                                              messages[index]['userId']
                                          ? MainAxisAlignment.start
                                          : MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      messages[index]['message'],
                                      style: TextStyle(
                                          color: messages[index]['userId'] ==
                                                  Auth_helper.auth_helper
                                                      .getUserId()
                                              ? Colors.white
                                              : Theme.of(context)
                                                  .textTheme
                                                  .bodyText1
                                                  .color),
                                    ),
                                    SizedBox(
                                      width: 13,
                                    ),
                                    Text(
                                      messages[index]['timeDate'].toString(),
                                      style: TextStyle(
                                          color: Auth_helper.auth_helper
                                                      .getUserId() ==
                                                  messages[index]['userId']
                                              ? Colors.black54
                                              : Colors.grey,
                                          fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        )),
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
                    child: Consumer<AuthProvider>(
                  builder: (context, provider, c) => Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      children: [
                        buildIconButton(
                            icon: Icons.sentiment_satisfied_alt_outlined),
                        SizedBox(
                          width: kDefaultPadding / 4,
                        ),
                        Expanded(
                            child: TextField(
                          controller: provider.msgController,
                          onChanged: (x) {
                            provider.message = x;
                          },
                          decoration: InputDecoration(
                              hintText: 'Type message',
                              border: InputBorder.none),
                        )),
                        buildIconButton(
                            icon: Icons.send,
                            f: () {
                              provider.clearMsg();
                              provider.sendToFire();
                            }),
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
        )
      ],
    );
  }

}
class buildIconButton extends StatelessWidget {
  IconData icon; Function f;
   buildIconButton({this.icon,this.f});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: f,
        icon: Builder(
          builder: (context) => Icon(
            icon,
            color:
            Theme.of(context).textTheme.bodyText1.color.withOpacity(0.64),
          ),
        ));
  }
}

