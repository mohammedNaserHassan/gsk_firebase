import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsk_firebase/Chating/Models/chat.dart';
import 'package:gsk_firebase/Chating/View/constants.dart';
import 'package:gsk_firebase/Providers/Auth_provider.dart';
import 'package:provider/provider.dart';

class people extends StatelessWidget {
  people();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kPrimaryColor,
          title: Text('People'),
        ),
        body: Consumer<AuthProvider>(builder: (context, provider, c) {
          if (provider.users == null) {
            return CircularProgressIndicator();
          } else {
            return ListView.builder(
              itemCount: provider.users.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white
                  ),
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(provider
                                    .users[index].imgurl == null ?
                        'https://images.freeimages.com/images/small-previews/ffa/water-lilly-1368676.jpg'
                            : provider.users[index].imgurl),
                      ),
                      SizedBox(width: 10,),
                      Column(
                        children: [
                          Text('Name:'+''+provider.users[index].fName +
                              '' +
                              provider.users[index].lName),
                          Text('Email:'+''+provider.users[index].Email,style: TextStyle(fontSize: 10),),
                          Text('Country:'+''+provider.users[index].country),
                          Text('City:'+''+provider.users[index].city),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          }
        }));
  }
}
