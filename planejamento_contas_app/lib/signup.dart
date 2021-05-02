import 'package:flutter/material.dart';
import 'package:planejamento_contas_app/toast.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

import "home.dart";

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  //Variaveis
  final _tEmail = TextEditingController();
  final _tPassword = TextEditingController();
  final _tPasswordConfirm = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  var  _userExist = false;
  var _success = false;

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
    _tPasswordConfirm.text = "";
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
            _editTextPassword("SENHA:", _tPassword),
            _editTextPasswordConfirm("CONFIRME SUA SENHA", _tPasswordConfirm),
            _buttonEntrar(),
          ],
        ),
        ));
  }

  // Widget text
  _editText(String field, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: (s) => _validate(s, "um email válido"),
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
      validator: (s) => _validate(s, "uma senha válida"),
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 22,color: Colors.black,),
      decoration: InputDecoration(
        labelText: field,
        labelStyle: TextStyle(fontSize: 22,color: Colors.yellow,),
      ),
    );
  }

  _editTextPasswordConfirm(String field, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      validator: (s) => _validatePassword(_tPassword.text, s, field),
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

  // PROCEDIMENTO PARA VALIDAR AS SENHAS
  String _validatePassword(String passwordA, String passwordB, String field) {
    if( passwordB.length == 0){
      return "Insira sua senha novamente";
    } else if (passwordA != passwordB ) {
      return "As senhas diferem";
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
        onPressed: () async {
          if(_formKey.currentState.validate()) {
            _userExist = false;
            await _validateUser(_tEmail.text);
            if(_userExist) {
              ToastMessage.showToast("Existe um cadastro com este email", 0);
            } else {
              await _saveUser(_tEmail.text, _tPassword.text);
              ToastMessage.showToast("Usuário cadastrado com sucesso!", 1);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PaginaListaDeCompras()),
              );
            }

          }
        },
      ),
    );
  }//BunttonComecar

  //=======================================================================================
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

  void _validateUser(String email) async {
    Database bd = await _recuperarBancoDados();
    List user = await bd.query(
        "usuarios",
        columns: ["id"],
        where: "email = ?",
        whereArgs: [email]
    );

    if(user.length == 1) {
      _userExist = true;
    }
  }

  void _saveUser(String email, String password) async {
    Database bd = await _recuperarBancoDados();
    Map<String, dynamic> userData = {
      "email": email,
      "senha": password
    };
    int id = await bd.insert("usuarios", userData);
    _success = true;

  }

}
