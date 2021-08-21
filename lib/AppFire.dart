import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Chating/Screens/welcome_page.dart';
class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(body: Container(child: Text('error'),),);
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(body: welcomPage(),);
        }
        return CircularProgressIndicator();
      },
    );
  }
}