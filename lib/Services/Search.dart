import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gsk_firebase/Auth/Helper/fireStore_Helper.dart';
import 'package:gsk_firebase/Chating/Screens/message_screen.dart';
import 'package:gsk_firebase/Chating/components/chat_cards.dart';
class TheSearch extends SearchDelegate<String> {
  TheSearch({this.contextPage, this.controller});
  BuildContext contextPage;
  TextEditingController controller;
  final suggestions1 = ['aslan','Soso'];

  @override
  String get searchFieldLabel => "Enter a name of friend";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: fireStore_Helper.helper.getSearchFreindStream(controller.text),
          builder: (context, snapshots) {
            if (!snapshots.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              QuerySnapshot<Map<String, dynamic>> query =
                  snapshots.data;
              List<Map> freinds =
              query.docs.map((e) => e.data()).toList();
              return ListView.builder(
                itemCount: freinds.length,
                itemBuilder: (context, index) {
                  return ChatCard(
                    name: freinds[index]['name'],
                    image: freinds[index]['image'],
                    press: () {
                      Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(
                          builder: (c) => message_screen(
                            image: freinds[index]['name'],
                            name: freinds[index]['image'],
                          )));
                    },
                  );
                },
              );
            }
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty ? suggestions1 : [];
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (content, index) => ListTile(
          leading: Icon(Icons.arrow_left), title: Text(suggestions[index])),
    );
  }
}