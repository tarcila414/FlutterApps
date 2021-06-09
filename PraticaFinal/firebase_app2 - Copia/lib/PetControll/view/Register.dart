import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'toast.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

  TextEditingController emailInputController;
  TextEditingController pwdInputController;

  @override
  void initState() {
    // TODO: implement initState
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold ( body: Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          begin: Alignment.centerLeft,
          end: new Alignment(1.0, 0.0), // 10% of the width, so there are ten blinds.
          colors: [Color(0xFFFF9000), Color(0xFFFFFF)], // whitish to gray
          tileMode: TileMode.repeated, // repeats the gradient over the canvas
        ),
      ),
      height: MediaQuery.of(context).size.height,
      child:
      SizedBox(
        child: Column(
            children: <Widget> [
              Container(
                padding: const EdgeInsets.only(top: 150.0, bottom: 50.0),
                child: Center (
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: new Text(
                          "Registrar-se",
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // Container do email
              new Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: Colors.white,
                        width: 0.5,
                        style: BorderStyle.solid),
                  ),
                ),
                padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                child:
                new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Padding(
                      padding:
                      EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
                      child: Icon(
                        Icons.alternate_email,
                        color: Colors.white,
                      ),
                    ),
                    new SizedBox( width: 276, height: 30, child:
                    TextField(
                      textAlign: TextAlign.center,
                      controller: emailInputController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'exemplo@gmail.com',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    )
                  ],
                ),
              ),

              //Container da senha
              new Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: Colors.white,
                        width: 0.5,
                        style: BorderStyle.solid),
                  ),
                ),
                padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Padding(
                      padding:
                      EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
                      child: Icon(
                        Icons.lock_open,
                        color: Colors.white,
                      ),
                    ),
                    new Expanded(
                      child: TextField(
                        controller: pwdInputController,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '*********',
                          hintStyle: TextStyle(color:Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //Container do botão de login
              Expanded(child:
              new Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 30.0),
                alignment: Alignment.center,
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new  TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 20.0
                          ),
                          backgroundColor: Color(0xFFFF9000),
                        ),
                        onPressed: () {
                          if (_registerFormKey.currentState.validate()) {
                            FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                email: emailInputController.text,
                                password: pwdInputController.text)
                                .then((currentUser) => FirebaseFirestore.instance
                                .collection("usuarios")
                                .add({
                              "id": currentUser.user.uid,
                              "nome": "",
                              "email": emailInputController.text,
                              "img": ""

                            }).then((result) => {
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  "/home", (_) => false),

                              emailInputController.clear(),
                              pwdInputController.clear(),
                            })
                                .catchError((err) => print(err)))
                                .catchError((err) => ToastMessage.showToast("Não foi possível fazer o cadastro", 0));
                            // FirebaseAuth.instance
                            //     .signInWithEmailAndPassword(
                            //     email: emailInputController.text,
                            //     password: pwdInputController.text)
                            //     .then((currentUser) => FirebaseFirestore.instance
                            //     .collection("usuarios")
                            //     .where("id", isEqualTo: currentUser.user.uid)
                            //     .get()
                            //     .then((QuerySnapshot result) =>
                            //     Navigator.pushReplacementNamed(context, '/home')
                            //),);

                          }
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ),
            ]
        ),
      ),



    ));
  }
}
