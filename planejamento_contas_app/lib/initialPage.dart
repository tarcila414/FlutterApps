import 'package:flutter/material.dart';

import 'signup.dart';
import 'login.dart';

class InitialPage extends StatefulWidget {
  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(
          "Planejamento de Contas" ,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,),),
        centerTitle: true,
      ),

      body: _body(),
    );
  }


  _body() {
    return SingleChildScrollView(
        padding: EdgeInsets.only(top: 40),
        child: Form(
          key: _formKey,child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
                children:<Widget>[ Image.asset("assets/images/logo.png",
                  width: 280,
                  height: 280,
                ),  _buttonLogin(), _buttonCadastrar()]
            )

          ],
        ),
        ));
  }



  _buttonLogin() {
    return Container(
      margin: EdgeInsets.only(top: 170),
      height: 55,
      width: 200,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.yellow,
        ),
        child:
        Text(
          "ENTRAR",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,),
        ),
        onPressed: () {
          if(_formKey.currentState.validate()){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => loginPage()),
            );
          }
        },
      ),
    );
  }//BunttonLogin


  _buttonCadastrar() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      height: 45,
      width: 160,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.amberAccent,
        ),
        child:
        Text(
          "CADASTRAR",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,),
        ),
        onPressed: () {
          if(_formKey.currentState.validate()){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignupPage()),
            );
          }
        },
      ),
    );
  }//Buntton
}
