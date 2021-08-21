import 'package:flutter/material.dart';
import 'package:gsk_firebase/Chating/View/constants.dart';

class my_textfield extends StatefulWidget {
  String label, hint;
  bool bo;
  TextEditingController textEditingController;

  my_textfield({this.label, this.hint, this.bo, this.textEditingController});

  @override
  _my_textfieldState createState() => _my_textfieldState();
}

class _my_textfieldState extends State<my_textfield> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: kPrimaryColor.withOpacity(0.2)),
      child: Center(
        child: TextField(
          obscureText: widget.bo,
          decoration: InputDecoration(
              labelText: widget.label,
              labelStyle: TextStyle(color: kPrimaryColor),
              hintText: widget.hint,
              border: InputBorder.none),
        ),
      ),
    );
  }
}
