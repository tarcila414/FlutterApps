import 'number2Game.dart';
import 'package:flutter/material.dart';

import 'wordGameA.dart';

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  // VARIAVEIS
  var _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text("LOGIN"),
        // centerTitle: true,
      ),
      body: _body(),
    );
  }


  _body() {
    return SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Row(
            children: <Widget>[
              _buttonWordsGame(),
              _buttonNumbersGame()
            ],

        ),
        ));
  }

  _buttonWordsGame() {
    return Container(
      margin: EdgeInsets.only(top: 150, left: 20),
      height: 120,
      width: 120,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.yellow,
        ),
        child: Image.asset("../assets/images/words.png",

        ),
        onPressed: () {
          if(_formKey.currentState.validate()){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => wordAPage()),
            );
          }
        },
      ),
    );
  }//BunttonWordsGame

  _buttonNumbersGame() {
    return Container(
      margin: EdgeInsets.only(top: 150, left: 50),
      height: 120,
      width: 120,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.yellow,
        ),
        child: Image.asset("../assets/images/numbers.png",

        ),
        onPressed: () {
          if(_formKey.currentState.validate()){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => number2Page()),
            );
          }
        },
      ),
    );
  }//BunttonNumbersGame

}
