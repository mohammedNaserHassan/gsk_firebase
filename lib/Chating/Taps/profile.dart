import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsk_firebase/Chating/View/constants.dart';
import 'package:gsk_firebase/Providers/Auth_provider.dart';
import 'package:provider/provider.dart';

class profile extends StatefulWidget {
  profile();

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  void initState() {
    super.initState();
    Provider.of<AuthProvider>(context,listen: false).getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context,provider,x)=>
       Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
            children: [
              Stack(
                children: [
                  Container(
                        height: MediaQuery.of(context).size.height * 0.45,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              provider.user.imgUrl,
                            ),
                            fit: BoxFit.cover,
                          ),
                        )),
                  Positioned(
                      bottom: kDefaultPadding,
                      left: kDefaultPadding,
                      child: Row(
                        children: [
                          Text(
                            'Sozan Boshnak',
                            style: TextStyle(
                                fontSize: 25,
                                color: Theme.of(context).textTheme.headline1.color,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: kDefaultPadding / 2),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                                color: kPrimaryColor, shape: BoxShape.circle),
                          )
                        ],
                      )),
                ],
              ),
              buildPositioned(context, Icons.call, kDefaultPadding / 2),
              buildPositioned(context, Icons.videocam_sharp, 80),
              buildPositioned(context, Icons.message, 150),
              Positioned(
                left: 10,
                bottom: kDefaultPadding * 2.7,
                child: Container(
                  height: kDefaultPadding * 10,
                  color:
                      Theme.of(context).textTheme.headline1.color.withOpacity(0.1),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Common Groups',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        trailing: Icon(Icons.arrow_forward_ios),
                        title: Text('Gamers Clan'),
                        leading: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/user.png'),
                        ),
                      ),
                      ListTile(
                        trailing: Icon(Icons.arrow_forward_ios),
                        title: Text('Gamers Clan'),
                        leading: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/user_2.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  bottom: kDefaultPadding * 0.5,
                  left: kDefaultPadding * 5,
                  child: Container(
                    width: kDefaultPadding * 10,
                    height: kDefaultPadding * 2,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(40)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: kDefaultPadding * 2,
                        ),
                        Icon(Icons.add_circle_outline),
                        Text('My Status')
                      ],
                    ),
                  ))
            ],
          ),

      ),
    );
  }

  Positioned buildPositioned(
      BuildContext context, IconData iconData, double x) {
    return Positioned(
        left: x,
        bottom: MediaQuery.of(context).size.height * 0.33,
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: kDefaultPadding / 2),
              width: 50,
              height: 50,
              decoration:
                  BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle),
              child: Center(
                child: Icon(
                  iconData,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ));
  }
}
class Item extends StatelessWidget {
  String name,value;
  Item({this.name,this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(name),
          Text(value),
        ],
      ),
    );
  }
}

