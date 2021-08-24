import 'package:flutter/material.dart';
import 'package:gsk_firebase/Animation/FadeAnimation.dart';
import 'package:gsk_firebase/Chating/Models/CountryModel.dart';
import 'package:gsk_firebase/Providers/Auth_provider.dart';
import 'package:gsk_firebase/widgets/CustomButton.dart';
import 'package:gsk_firebase/widgets/Custom_text_field.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  static final routeName = 'RegisterName';

  Register();

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Consumer<AuthProvider>(
              builder: (context, provider, c) =>
                  Column(
                    children: <Widget>[
                      Container(
                        height: 400,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/background.png'),
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
                                        "Sign Up",
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
                                      GestureDetector(
                                        onTap: () {
                                          provider.selectFile();
                                        },
                                        child: Container(
                                          height: 200,
                                          width: 200,
                                          color: Colors.grey,
                                          child: provider.file == null
                                              ? Container()
                                              : Image.file(provider.file, fit: BoxFit.cover),
                                        ),
                                      ),

                                      Custom_textfield(
                                        label: 'fName',
                                        textEditingController:
                                        provider.fNameController,
                                      ),
                                      Custom_textfield(
                                        label: 'lName',
                                        textEditingController:
                                        provider.lNameController,
                                      ),
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


                                      provider.countries == null
                                          ? Container()
                                          : Container(
                                        padding:
                                        EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey),
                                            borderRadius: BorderRadius.circular(15)),
                                        child: DropdownButton<CountryModel>(
                                          isExpanded: true,
                                          underline: Container(),
                                          value: provider.selectedCountry,
                                          onChanged: (x) {
                                            provider.selectCountry(x);
                                          },
                                          items: provider.countries.map((e) {
                                            return DropdownMenuItem<CountryModel>(
                                              child: Text(e.name),
                                              value: e,
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      provider.countries == null
                                          ? Container()
                                          : Container(
                                        padding:
                                        EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey),
                                            borderRadius: BorderRadius.circular(15)),
                                        child: DropdownButton<dynamic>(
                                          isExpanded: true,
                                          underline: Container(),
                                          value: provider.selectedCity,
                                          onChanged: (x) {
                                            provider.selectCity(x);
                                          },
                                          items: provider.cities.map((e) {
                                            return DropdownMenuItem<dynamic>(
                                              child: Text(e),
                                              value: e,
                                            );
                                          }).toList(),
                                        ),
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
                                      label: 'Sign Up',
                                      function: provider.register,
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
