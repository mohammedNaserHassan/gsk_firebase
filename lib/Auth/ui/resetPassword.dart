import 'package:flutter/material.dart';
import 'package:gsk_firebase/Providers/Auth_provider.dart';
import 'package:gsk_firebase/widgets/CustomButton.dart';
import 'package:gsk_firebase/widgets/Custom_text_field.dart';
import 'package:provider/provider.dart';
class ResetPassword extends StatelessWidget {
  static final routeName ='ResetPasswordPage';
   ResetPassword();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 0,top: 0),
      child: Stack(
        children: [
          Positioned(
            child: Container(
              width: double.infinity,
              height: 350,
              color: Colors.lightBlue,
            ),
          ),
          Positioned(
            top: 200,
            left: 40,
            child: Container(
            color: Colors.blueGrey,
              width: 300,
              height: 300,
              child: Consumer<AuthProvider>(
                    builder:(context,provider,o)=> Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
children: [
  Icon(Icons.lock_outline,color: Colors.red,size: 55,),
  Text('Reset Password',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
  Container(
                color: Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: Custom_textfield(label: 'email',textEditingController: provider.emailController,)),
  Container(
              height: 45,
                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                color: Colors.blueAccent,
                child: CustomButton(label: 'Reset Password',function: provider.resetPassword,))
],
                    )),
            ),
          ),
        ],
      ),
    );
  }
}
