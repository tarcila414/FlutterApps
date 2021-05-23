import 'package:firebase_app/home2.dart';
import 'package:firebase_app/initialPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'spplash.dart';
import 'login.dart';
import 'home.dart';
import 'register.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      initialRoute:  InitialPage.tag,
      routes: {
        InitialPage.tag: (context) => InitialPage(),
        SplashPage.tag: (context) => SplashPage(),
        LoginPage.tag:(context) => LoginPage(),
        RegisterPage.tag: (context) => RegisterPage(),
        HomePage.tag: (context) => HomePage(),
        Home.tag: (context) => Home(),
      },
    );
  }
}