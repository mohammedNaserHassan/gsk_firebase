import 'package:flutter/material.dart';
import 'package:gsk_firebase/Auth/ui/login.dart';
import 'package:gsk_firebase/Auth/ui/register.dart';
import 'package:gsk_firebase/Chating/View/constants.dart';
import 'package:gsk_firebase/Chating/components/primary_button.dart';
import 'package:gsk_firebase/Services/Router.dart';

class sigh_in_or_sign_up extends StatelessWidget {
  static final routeName = 'SignOrLogin';
  sigh_in_or_sign_up();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            children: [
              Spacer(
                flex: 2,
              ),
              Center(
                  child: Image.asset(
                'assets/images/Logo_light.png',
                height: 145,
                color: Colors.green,
              )),
              Spacer(),
              PrimaryButton(
                text: 'Sign In',
                press: () {
                  AppRouter.appRouter.gotoPagewithReplacment(Login.routeName);

                },
              ),
              SizedBox(
                height: kDefaultPadding * 1.5,
              ),
              PrimaryButton(
                text: 'Sign Up',
                press: () {
                  AppRouter.appRouter.gotoPagewithReplacment(Register.routeName);
                },
                color: Theme.of(context).colorScheme.secondary,
              ),
              Spacer(
                flex: 3,
              )
            ],
          ),
        ),
      ),
    );
  }
}
