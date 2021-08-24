import 'package:flutter/material.dart';
import 'package:gsk_firebase/Auth/Helper/helper.dart';
import 'package:gsk_firebase/Chating/Screens/sigh_in_or_sign_up.dart';
import 'package:gsk_firebase/Chating/Taps/chat_screen.dart';
import 'package:gsk_firebase/Providers/Auth_provider.dart';
import 'package:gsk_firebase/Services/Router.dart';
import 'package:provider/provider.dart';

class welcomPage extends StatelessWidget {
  const welcomPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Image.asset('assets/images/welcome_image.png'),
            Spacer(
              flex: 2,
            ),
            Text(
              'Welcome to our freedom messaging app',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Spacer(
              flex: 1,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text('Freedom talk any person of your mother language.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.grey)),
            ),
            Spacer(
              flex: 3,
            ),
            FittedBox(
              child: Consumer<AuthProvider>(
               builder : (context,provider,c)=>TextButton(
                    onPressed: () {
                    print(provider.countries);
                      AppRouter.appRouter.gotoPagewithReplacment(
                          Helper.x.GetUsername()==null?
                          sigh_in_or_sign_up.routeName
                          :ChatScreen.routeName
                      );




                    },
                    child: Row(
                      children: [
                        Text(
                          'Skip',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .color
                                  .withOpacity(0.5),
                              fontSize: 25),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .color
                              .withOpacity(0.5),
                        )
                      ],
                    )),
              ),
            ),
            Spacer(
              flex: 1,
            )
          ],
        ),
      ),
    );
  }
}
