import 'package:education_app/wordGameB.dart';
import 'package:flutter/material.dart';
import 'home.dart';
class wordZPage extends StatefulWidget {
  @override
  _wordZPageState createState() => _wordZPageState();
}

class _wordZPageState extends State<wordZPage> {
  // VARIAVEIS
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LETRINHAS"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.home_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => homePage()),
                );
              }
          )
        ],

      ),
      body: _body(),
    );
  }

  _body() {
    return SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Image.asset("../assets/images/zebra.png",
                width: 150,
                height: 150,
              ),
              _buttonsLine()
            ],

          ),
        ));
  }

  _buttonsLine() {
    return Container(
      margin: EdgeInsets.only(top: 150),
      child: Row(
          children: <Widget> [
            _buttonA(),
            _buttonB(),
            _buttonC()
          ]
      ),
    );
  }

  _buttonA() {
    return Container(
      margin: EdgeInsets.only(left: 45),
      height: 80,
      width: 80,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.yellow,
        ),
        child: Text(
          "X",
          style: TextStyle(
            color: Colors.blueAccent,
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return _alertWrong();
                }
            );
        }
      ),
    );
  }//BunttonNumbersGame

  _buttonB() {
    return Container(
      margin: EdgeInsets.only(left: 20),
      height: 80,
      width: 80,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.yellow,
          ),
          child:   Text(
            "S",
            style: TextStyle(
              color: Colors.green,
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return _alertWrong();
                }
            );
          }
      ),
    );
  }//BunttonNumbersGame

  _buttonC() {
    return Container(
      margin: EdgeInsets.only(left: 20),
      height: 80,
      width: 80,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.yellow,
        ),
        child: Text(
          "Z",
          style: TextStyle(
            color: Colors.black,
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return _alertHit();
              }
          );
        },
      ),
    );
  }//BunttonNumbersGame

  _alertHit() {
    double left = 0.0;
    double top = 0.0;
    double right = 0.0;
    double bottom = 0.0;

    return AlertDialog(
      title: Text(
          "PARABÉNS!!!!",
          style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold)
      ),
      titlePadding: EdgeInsets.only(left: 75, top:15),
      content:
      Image.asset("../assets/images/hit.png",
        width: 150,
        height: 150,
      ),
      actions: <Widget>[
        TextButton(
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("  Cancelar  ")
        ),
        TextButton(
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.yellow,
              padding: EdgeInsets.only(left: 10),

            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => wordBPage()),
              );
            },
            child: Text("  Próximo  "))
      ],
    );
  }

  _alertWrong() {

    return AlertDialog(
      title: Text(
          "OPS....",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)
      ),
      // titlePadding: EdgeInsets.only(left: 75, top:15),
      content:
      Image.asset("../assets/images/wrong.png",
        width: 150,
        height: 150,
      ),
      actions: <Widget>[
        TextButton(
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.yellow,

            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("  CONFIRMAR  "))
      ],
    );
  }

}
