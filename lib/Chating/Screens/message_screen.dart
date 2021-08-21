import 'package:flutter/material.dart';
import 'package:gsk_firebase/Providers/Auth_provider.dart';
import 'package:gsk_firebase/Chating/components/body_of%20message.dart';
import 'package:gsk_firebase/Chating/components/buildAppBarMessege.dart';
import 'package:provider/provider.dart';

class message_screen extends StatelessWidget {
  static final routeName = 'MessageName';

  message_screen();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, c) => Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: buildAppBarMessage()),
        body: body_message(),
      ),
    );
  }
}
