import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_2.dart';
import 'package:gsk_firebase/Auth/Helper/auth_helper.dart';
import 'package:gsk_firebase/Auth/Helper/fireStore_Helper.dart';
import 'package:gsk_firebase/Chating/View/constants.dart';
import 'package:gsk_firebase/Providers/Auth_provider.dart';
import 'package:gsk_firebase/Services/url_lancher.dart';
import 'package:provider/provider.dart';

class body_message extends StatelessWidget {
  body_message();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, i) => Column(
        children: [
          Expanded(
            child: Container(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: fireStore_Helper.helper.getFireStream(),
                builder: (context, snapshots) {
                  if (!snapshots.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    QuerySnapshot<Map<String, dynamic>> query = snapshots.data;
                    List<Map> messages =
                        query.docs.map((e) => e.data()).toList();
                    return ListView.builder(
                      shrinkWrap: true,
                      controller: provider.controller,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: messages[index]['userId'] ==
                                  Auth_helper.auth_helper.getUserId()
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            if (messages[index]['userId'] ==
                                Auth_helper.auth_helper.getUserId())
                              ChatBubble(
                                clipper: ChatBubbleClipper2(
                                    type: BubbleType.sendBubble),
                                backGroundColor: kPrimaryColor,
                                margin: EdgeInsets.only(top: 20),
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width * 0.7,
                                  ),
                                  child: FittedBox(
                                    child: Row(
                                      children: [
                                        messages[index]['imgesUrl'] == null &&
                                                messages[index]['files'] == null
                                            ? Text(messages[index]['message'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1
                                                    .copyWith(fontSize: 16))
                                            : messages[index]['imgesUrl'] !=
                                                        null &&
                                                    messages[index]['files'] ==
                                                        null
                                                ? Image.network(
                                                    messages[index]['imgesUrl'])
                                                : GestureDetector(
                                                    onTap: () {
                                                      Url_lancher_helper.url
                                                          .openWebpage(provider
                                                              .result
                                                              .paths[index]);
                                                    },
                                                    child: Image.asset(
                                                        'assets/images/pdf.png')),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 20),
                                          child: Text(
                                            messages[index]['timeDate']
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: messages[index]
                                                            ['imgesUrl'] ==
                                                        null
                                                    ? 10
                                                    : 25),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            else
                              ChatBubble(
                                clipper: ChatBubbleClipper1(
                                    type: BubbleType.receiverBubble),
                                backGroundColor:
                                    kPrimaryColor.withOpacity(0.08),
                                margin: EdgeInsets.only(top: 20),
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width * 0.7,
                                  ),
                                  child: FittedBox(
                                    child: Row(
                                      children: [
                                        messages[index]['imgesUrl'] == null &&
                                            messages[index]['files'] == null
                                            ? Text(
                                            messages[index]['message'],
                                            style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 16)
                                        )
                                            : messages[index]['imgesUrl'] !=
                                            null &&
                                            messages[index]['files'] ==
                                                null
                                            ? Image.network(
                                            messages[index]['imgesUrl'])
                                            : GestureDetector(
                                            onTap: () {
                                              Url_lancher_helper.url
                                                  .openWebpage(provider.result.paths[index]);
                                            },
                                            child: Image.asset(
                                                'assets/images/pdf.png')),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 20),
                                          child: Text(
                                            messages[index]['timeDate']
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: messages[index]
                                                ['imgesUrl'] ==
                                                    null
                                                    ? 10
                                                    : 25),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
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
                      onPressed: () {
                        provider.selectMultiFiles();
                      },
                      icon: Icon(
                        Icons.camera_alt,
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
                              icon: Icons.attach_file,
                              f: () {
                                provider.selectFilesToFire();
                              }),
                          buildIconButton(
                              icon: Icons.send,
                              f: () {
                                provider.sendToFire();
                                provider.clearMsg();
                              }),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class buildIconButton extends StatelessWidget {
  IconData icon;
  Function f;

  buildIconButton({this.icon, this.f});

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
