import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  Function function;
  String label;
   CustomButton({this.label,this.function});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        child: Center(
          child: Text(label, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}
