import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsk_firebase/Animation/FadeAnimation.dart';
import 'package:gsk_firebase/Auth/ui/register.dart';
import 'package:gsk_firebase/Providers/Auth_provider.dart';
import 'package:gsk_firebase/Auth/ui/resetPassword.dart';
import 'package:gsk_firebase/Services/Router.dart';
import 'package:gsk_firebase/widgets/CustomButton.dart';
import 'package:gsk_firebase/widgets/Custom_text_field.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  static final routeName = 'LoginnPage';

  Login();

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Consumer<AuthProvider>(
              builder: (context, provider, c) => Column(
                children: <Widget>[
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/background.png'),
                            fit: BoxFit.fill)),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 30,
                          width: 80,
                          height: 200,
                          child: FadeAnimation(
                              1,
                              Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/light-1.png'))),
                              )),
                        ),
                        Positioned(
                          left: 140,
                          width: 80,
                          height: 150,
                          child: FadeAnimation(
                              1.3,
                              Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/light-2.png'))),
                              )),
                        ),
                        Positioned(
                          right: 40,
                          top: 40,
                          width: 80,
                          height: 150,
                          child: FadeAnimation(
                              1.5,
                              Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/clock.png'))),
                              )),
                        ),
                        Positioned(
                          child: FadeAnimation(
                              1.6,
                              Container(
                                margin: EdgeInsets.only(top: 50),
                                child: Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      children: <Widget>[
                        FadeAnimation(
                            1.8,
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color.fromRGBO(143, 148, 251, .2),
                                        blurRadius: 20.0,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Custom_textfield(
                                    label: 'Email',
                                    textEditingController:
                                        provider.emailController,
                                  ),
                                  Custom_textfield(
                                    label: 'Password',
                                    textEditingController:
                                        provider.passwordController,
                                    obscure: true,
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        FadeAnimation(
                            2,
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(colors: [
                                    Color.fromRGBO(143, 148, 251, 1),
                                    Color.fromRGBO(143, 148, 251, .6),
                                  ])),
                              child: CustomButton(
                                label: 'Login',
                                function: provider.login,
                              ),
                            )),
                        SizedBox(
                          height: 50,
                        ),
                       FadeAnimation(
                                1.5,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Don\’t have an account?"),
                                    GestureDetector(
                                      onTap: (){
                                        AppRouter.appRouter.gotoPagewithReplacment(Register.routeName);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(horizontal: 5),
                                        child: Text(
                                         'Sign up',
                                          style: TextStyle(
                                              color: Color.fromRGBO(143, 148, 251, 1)),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                        GestureDetector(
                            onTap: () {
                              AppRouter.appRouter
                                  .gotoPage(ResetPassword.routeName);
                            },
                            child: FadeAnimation(
                                1.5,
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                        color: Color.fromRGBO(143, 148, 251, 1)),
                                  ),
                                ))),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
