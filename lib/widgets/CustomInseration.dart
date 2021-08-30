import 'package:flutter/material.dart';
import 'package:gsk_firebase/Chating/View/constants.dart';
import 'package:gsk_firebase/Providers/Auth_provider.dart';
import 'package:gsk_firebase/Services/Router.dart';
import 'package:gsk_firebase/widgets/Custom_text_field.dart';
import 'package:provider/provider.dart';
class CustomInseration extends StatelessWidget {
   CustomInseration();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kPrimaryColor,
      content: Consumer<AuthProvider>(
        builder: (context,provider,c)=>Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80)
          ),
          width: 200,
          height: 270,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Create New Friend'),
              Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                        ,
                  ),
                  child: Custom_textfield(label: "ID", textEditingController: provider.idFreind,type: TextInputType.number,)),

              Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                    ,
                  ),
                  child: Custom_textfield(label: "Name", textEditingController: provider.nFreind,)),

              GestureDetector(
                onTap: () {
                  provider.selectFileFreind();
                },
                child: Container(
                  height: 80,
                  width: 140,
                  color: kPrimaryColor,
                  child: provider.fileFreind == null
                      ? CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.add_a_photo_outlined,size: 35,),
                  )
                      : Image.file(provider.fileFreind,
                      fit: BoxFit.cover),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        Consumer<AuthProvider>(
          builder: (context,provider,v)=>Container(
            width: 80,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
                color: Colors.grey,
            ),
            child: TextButton(
                onPressed: (){
                  if( provider.nFreind.text!=null&&provider.idFreind.text!=null&&provider.fileFreind!=null)
                 {
                   provider.addNewFreind();
                   AppRouter.appRouter.back();
                 }
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Please... Add info about your friend"),
                    ));
                  }

            }, child: Text('OK',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),)),
          ),
        )
      ],
    );
  }
}
