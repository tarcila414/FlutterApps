import 'home.dart';
import 'package:flutter/material.dart';

class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  //Variaveis
  final _tEmail = TextEditingController();
  final _tPassword = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text("LOGIN"),
        // centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
              onPressed: _resetFields)
        ],
      ),
      body: _body(),
    );
  }


  // PROCEDIMENTO PARA LIMPAR OS CAMPOS
  void _resetFields(){
    _tEmail.text = "";
    _tPassword.text = "";
    setState(() {
      _formKey = GlobalKey<FormState>();
    });
  }

  _body() {
    return SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _editText("EMAIL: ", _tEmail),
            _editTextPassword("PASSWORD:", _tPassword),
            _buttonEntrar(),
          ],
        ),
        ));
  }

  // Widget text
  _editText(String field, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: (s) => _validate(s, field),
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 22,color: Colors.black,),
      decoration: InputDecoration(
        labelText: field,
        labelStyle: TextStyle(fontSize: 22,color: Colors.yellow,),
      ),
    );
  }

  _editTextPassword(String field, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      validator: (s) => _validate(s, field),
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 22,color: Colors.black,),
      decoration: InputDecoration(
        labelText: field,
        labelStyle: TextStyle(fontSize: 22,color: Colors.yellow,),
      ),
    );
  }

  // PROCEDIMENTO PARA VALIDAR OS CAMPOS
  String _validate(String text, String field) {
    if (text.isEmpty) {
      return "Digite $field";
    }
    return null;
  }

  _buttonEntrar() {
    return Container(
      margin: EdgeInsets.only(top: 130),
      height: 45,
      width: 10,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.yellow,
        ),
        child:
        Text(
          "COMEÇAR",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,),
        ),
        onPressed: () {
          if(_formKey.currentState.validate()){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => homePage()),
            );
          }
        },
      ),
    );
  }//BunttonComecar
}
