import 'package:flutter/material.dart';

class Custom_textfield extends StatelessWidget {
  String label;
  bool obscure;
  TextInputType type;
  TextEditingController textEditingController;

  Custom_textfield(
      {this.label,
      this.textEditingController,
      this.type = TextInputType.name,
      this.obscure = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        obscureText: obscure,
        keyboardType: type,
        controller: textEditingController,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: label,
          hintStyle: TextStyle(color: Colors.grey[400]),
        ),
      ),
    );
  }
}
