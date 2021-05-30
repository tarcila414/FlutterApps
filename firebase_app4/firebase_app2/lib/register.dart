import 'package:firebase_app/toast.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);
  static String tag = '/register';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {


  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController nameInputController;
  TextEditingController phoneInputController;
  TextEditingController addressInputController;
  TextEditingController cepInputController;
  TextEditingController emailInputController;
  TextEditingController pwdInputController;
  TextEditingController pwdConfirmInputController;

  @override
  initState() {
    nameInputController = new TextEditingController();
    phoneInputController = new TextEditingController();
    addressInputController = new TextEditingController();
    cepInputController = new TextEditingController();
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    pwdConfirmInputController = new TextEditingController();
    super.initState();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'O email informado é invalido';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'A senha deve conter no mínimo 9 caracteres';
    } else {
      return null;
    }
  }

  String pwdConfirmValidator(String value) {
    if (value.length < 8 || value != pwdInputController.text.toString()) {
      return 'As senhas não coincidem';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cadastro"),
        ),
        body: Container(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
                child: Form(
                  key: _registerFormKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Nome*'),
                        controller: nameInputController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if(value.length < 3) {
                            return "Por favor insira um nome válido";
                          }
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Email*', hintText: "john.doe@gmail.com"),
                        controller: emailInputController,
                        keyboardType: TextInputType.emailAddress,
                        validator: emailValidator,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Telefone*', hintText: "(00)00000-0000"),
                        controller: phoneInputController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                            if(value.length < 11) {
                                return "Por favor insira um telefone válido";
                            }
                          },),
                          TextFormField(
                          decoration: InputDecoration(
                          labelText: 'Endereço*', hintText: "Rua Norte 151, Centro - BH/MG"),
                          controller: addressInputController,
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                          if(value.length < 3) {
                          return "Por favor insira um endereço válido";
                          }
                          },
                          ),
                          TextFormField(
                          decoration: InputDecoration(
                          labelText: 'CEP*', hintText: "00000-00"),
                          controller: cepInputController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if(value.length != 8) {
                              return "Por favor insira um cep válido";
                            }
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Senha*', hintText: "********"),
                        controller: pwdInputController,
                        obscureText: true,
                        validator: pwdValidator,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Confirmar senha*', hintText: "********"),
                        controller: pwdConfirmInputController,
                        obscureText: true,
                        validator: pwdConfirmValidator,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.pink[200],
                        ),
                        child:
                        Text(
                          "ENTRAR",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,),
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
                             "nome": nameInputController.text,
                             "endereco": addressInputController.text,
                             "cep": cepInputController.text,
                             "email": emailInputController.text,
                             "telefone": phoneInputController.text

                           }).then((result) => {
                             Navigator.pushNamedAndRemoveUntil(
                                 context,
                                 "/initialPage", (_) => false),
                              nameInputController.clear(),
                              emailInputController.clear(),
                              addressInputController.clear(),
                              cepInputController.clear(),
                              phoneInputController.clear(),
                              pwdInputController.clear(),
                             pwdConfirmInputController.clear()
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
                      ),
                      Text("Não possui uma conta?"),
                      TextButton(

                        child: Text("Cadastre-se aqui!"),
                        onPressed: () {
                          Navigator.pushNamed(context, "/register");
                        },
                      )
                    ],
                  ),
                ))));
  }
}
