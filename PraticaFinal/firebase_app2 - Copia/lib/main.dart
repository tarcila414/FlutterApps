import 'package:firebase_app/PetControll/view/Adocoes.dart';
import 'package:firebase_app/PetControll/view/ClinicsPage.dart';
import 'package:firebase_app/PetControll/view/Pets.dart';
import 'package:firebase_app/PetControll/view/Register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'PetControll/view/PerfilPage.dart';
import 'PetControll/view/HomePage.dart';
import 'PetControll/view/LoginPage.dart';


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
        brightness: Brightness.dark,
      ),
      initialRoute: '/',
      routes: {
        '/':(context) => LoginPage(),
        "/home": (context) => HomePage(),
        "/perfil": (context) => Perfil(),
        "/clinicas": (context) => ClinicsPage(),
        "/pets": (context) => PetsPage(),
        "/adocoes": (context) => AdocoesPage(),
        "/register": (context) => Register()
      },
    );
  }
}