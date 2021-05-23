import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login.dart';

class InitialPage extends StatefulWidget {
  static String tag = '/initialPage';

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
          "Contatinhos" ,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,),),
        centerTitle: true,
      ),

      body: _body(),
    );
  }


  _body() {
    return SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
                children:<Widget>[
                //   Image.asset("../assets/images/logo.png",
                //   width: 280,
                //   height: 280,
                // ),
                  _buttonLogin(),
                  _buttonCadastrar()
                ]
            )

          ],
        ),
        ));
  }



  _buttonLogin() {
    return Container(
      margin: EdgeInsets.only(top: 100),
      height: 45,
      width: 120,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.pinkAccent[600],
        ),
        child:
        Text(
          "LOGIN",
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,),
        ),
        onPressed: () async {
          await  FirebaseAuth.instance.signOut();

          if(_formKey.currentState.validate()){
            Navigator.pushNamed(
              context,
              '/login',
            );
          }
        },
      ),
    );
  }//BunttonLogin


  _buttonCadastrar() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 45,
      width: 120,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.pink[200],
        ),
        child:
        Text(
          "CADASTRAR",
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,),
        ),
        onPressed: () async {
          await  FirebaseAuth.instance.signOut();

          if(_formKey.currentState.validate()){
            Navigator.pushNamed(
              context,
              '/register');
          }
        },
      ),
    );
  }//Buntton
}

//
// class InitialPage extends StatefulWidget {
//   @override
//   _InitialPageState createState() => _InitialPageState();
// }
//
// class _logoPageState extends State<InitialPage> {
//   // VARIAVEIS
//   var _formKey = GlobalKey<FormState>();
//
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "EducaDivertido" ,
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 20,),),
//         centerTitle: true,
//       ),
//
//       body: _body(),
//     );
//   }
//
//
//   _body() {
//     return SingleChildScrollView(
//         padding: EdgeInsets.all(15.0),
//         child: Form(
//           key: _formKey,child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             Column(
//                 children:<Widget>[ Image.asset("../assets/images/logo.png",
//                   width: 280,
//                   height: 280,
//                 ),  _buttonLogin(), _buttonCadastrar()]
//             )
//
//           ],
//         ),
//         ));
//   }
//
//
//
//   _buttonLogin() {
//     return Container(
//       margin: EdgeInsets.only(top: 100),
//       height: 45,
//       width: 110,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           primary: Colors.yellow,
//         ),
//         child:
//         Text(
//           "LOGIN",
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 16,),
//         ),
//         onPressed: () {
//           if(_formKey.currentState.validate()){
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => loginPage()),
//             );
//           }
//         },
//       ),
//     );
//   }//BunttonLogin
//
//
//   _buttonCadastrar() {
//     return Container(
//       margin: EdgeInsets.only(top: 10),
//       height: 45,
//       width: 110,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           primary: Colors.yellow,
//         ),
//         child:
//         Text(
//           "CADASTRAR",
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 16,),
//         ),
//         onPressed: () {
//           if(_formKey.currentState.validate()){
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => loginPage()),
//             );
//           }
//         },
//       ),
//     );
//   }//Buntton
// }
