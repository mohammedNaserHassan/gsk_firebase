import 'package:flutter/material.dart';
import 'package:gsk_firebase/Chating/Screens/welcome_page.dart';
import 'package:gsk_firebase/Providers/Auth_provider.dart';
import 'package:gsk_firebase/Auth/ui/resetPassword.dart';
import 'package:gsk_firebase/Chating/Screens/message_screen.dart';
import 'package:gsk_firebase/Chating/Taps/chat_screen.dart';
import 'package:gsk_firebase/Services/Router.dart';
import 'package:provider/provider.dart';
import 'AppFire.dart';
import 'Auth/Helper/helper.dart';
import 'Chating/Screens/sigh_in_or_sign_up.dart';
import 'Providers/themeProvider.dart';
import 'Auth/ui/login.dart';
import 'Auth/ui/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Helper.x.initSharedPreference();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        )
      ],
      child: MaterialApp(
        routes: {
          Login.routeName: (context) => Login(),
          Register.routeName: (context) => Register(),
          ResetPassword.routeName: (context) => ResetPassword(),
          ChatScreen.routeName: (context) => ChatScreen(),
          message_screen.routeName: (context) => message_screen(),
          sigh_in_or_sign_up.routeName: (context) => sigh_in_or_sign_up(),
          welcomPage.routeName: (context) => welcomPage(),
        },
        navigatorKey: AppRouter.appRouter.navkey,
        debugShowCheckedModeBanner: false,
        home: App(),
      ),
    ),
  );
}
