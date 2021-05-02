
import 'package:flutter/material.dart';
import 'package:planejamento_contas_app/toast.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

import 'home.dart';

class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  //Variaveis
  final _tEmail = TextEditingController();
  final _tPassword = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  var _isValid = false;
  var _passwordInvalid = false;
  var _emailInvalid = false;

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
        padding: EdgeInsets.only(top: 100.0,left:15.0, right: 15.0),
        child: Form(
          key: _formKey,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _editText("EMAIL:", _tEmail),
            _editTextPassword("SENHA:", _tPassword),
            _buttonEntrar(),
          ],
        ),
        ));
  }

  // Widget text
  _editText(String field, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: (s) => _validate(s, "seu email"),
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
      validator: (s) => _validate(s, "sua senha"),
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
      return "Insira $field";
    }
    return null;
  }

  _buttonEntrar() {
    return Container(
      margin: EdgeInsets.only(top: 100),
      height: 45,
      width: 10,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.yellow,
        ),
        child:
        Text(
          "ENTRAR",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,),
        ),
        onPressed: () async {
          if(_formKey.currentState.validate()) {
            await _authetication(_tEmail.text, _tPassword.text);
            if (_isValid) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PaginaListaDeCompras()),
              );
            } else if(_emailInvalid) {
                ToastMessage.showToast("Email incorreto", 0);
              } else if( _passwordInvalid) {
                ToastMessage.showToast("Senha incorreta", 0);
              }
            } //If isValid
          }
      ),
    );
  }//BunttonEntrar





  //=================================================================================
  _recuperarBancoDados() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = path.join(caminhoBancoDados, "planejamento.bd");

    var bd = await openDatabase(
        localBancoDados,
        version: 1,
        onCreate: (db, dbVersaoRecente) async {
          String sql = "CREATE TABLE usuarios (id INTEGER PRIMARY KEY AUTOINCREMENT, email VARCHAR, senha INTEGER) ";
          String sql2 = "CREATE TABLE contas (id INTEGER PRIMARY KEY AUTOINCREMENT, title VARCHAR, value DOUBLE, isPaid BOLEAN) ";
          await db.execute(sql);
          await db.execute(sql2);
        }
    );
    return bd;
  }

  //Metodo para checar se o usuário possui cadastro
  void _authetication(String email, String password) async {
    _isValid = false;
    _passwordInvalid = false;
    _emailInvalid = false;

    Database bd = await _recuperarBancoDados();
    List user = await bd.query(
        "usuarios",
        columns: ["id","senha"],
        where: "email = ?",
        whereArgs: [email]
    );

    if(user.length > 0) {
      if(user[0]["senha"].toString() == password){
        _isValid = true;
      } else {
        _passwordInvalid = true;
      }
    } else {
      _emailInvalid = true;
    }
  }

//==================================================================================
}
