import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gsk_firebase/Chating/Screens/UpdateProgile.dart';
import 'package:gsk_firebase/Chating/View/constants.dart';
import 'package:gsk_firebase/Providers/Auth_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  static final routeName = 'profile';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<AuthProvider>(context, listen: false).getUserFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kPrimaryColor,
          title: Text('Profile'),
          actions: [
            IconButton(
                onPressed: () {
                  Provider.of<AuthProvider>(context, listen: false)
                      .fillControllers();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return UpdateProgile();
                  }));
                },
                icon: Icon(Icons.edit)),
            IconButton(
                onPressed: () {
                  Provider.of<AuthProvider>(context, listen: false).logOut();
                 // exit(0);
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: Consumer<AuthProvider>(
          builder: (context, provider, x) {
            return provider.user == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        CircleAvatar(
                          radius: 85,
                          backgroundImage: NetworkImage(provider.user.imgurl ==
                                  null
                              ? 'https://images.freeimages.com/images/small-previews/f37/cloudy'
                                  '-scotland-1392088.jpg'
                              : provider.user.imgurl,),
                        ),
                        ItemWidget(
                          label: 'Email:',
                          value: provider.user.Email ?? 'null',
                          size: 14,
                        ),
                        ItemWidget(
                            label: 'first Name:', value: provider.user.fName),
                        ItemWidget(
                            label: 'last Name:', value: provider.user.lName),
                        ItemWidget(
                            label: 'country Name:',
                            value: provider.user.country),
                        ItemWidget(
                            label: 'city Name:', value: provider.user.city),
                      ],
                    ),
                  );
          },
        ));
  }
}

class ItemWidget extends StatelessWidget {
  String label;
  String value;
  double size;

  ItemWidget({this.label, this.value, this.size = 22});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          Text(
            value,
            style: TextStyle(fontSize: size),
          )
        ],
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
    );
  }
}
