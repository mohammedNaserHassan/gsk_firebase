import 'package:flutter/material.dart';
import 'package:gsk_firebase/Services/Router.dart';
import 'package:gsk_firebase/widgets/Custom_text_field.dart';
class CustomInseration extends StatelessWidget {
   CustomInseration();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80)
        ),
        width: 200,
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Create New Friend'),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20)
                      , color: Colors.greenAccent
                ),
                child: Custom_textfield(label: "Name",)),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)
                    , color: Colors.greenAccent
                ),
                child: Custom_textfield(label: "Mobile",type: TextInputType.phone,)),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: (){
          AppRouter.appRouter.back();
        }, child: Text('OK'))
      ],
    );
  }
}
