import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:firebase_app/toast.dart';


final _formKey = GlobalKey<FormState>();

class Home extends StatefulWidget {

  @override
  static String tag = '/home2';
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  final GlobalKey<FormState> _homeFormKey = GlobalKey<FormState>();
  String idUser;

  TextEditingController nameInputController;
  TextEditingController phoneInputController;
  TextEditingController addressInputController;
  TextEditingController cepInputController;
  TextEditingController emailInputController;

  TextEditingController _controllerPesquisa = TextEditingController();
  List<DocumentSnapshot> listaContatos = null;


  @override
  initState() {
    nameInputController = new TextEditingController();
    phoneInputController = new TextEditingController();
    addressInputController = new TextEditingController();
    cepInputController = new TextEditingController();
    emailInputController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    idUser = user.uid;

    var snap = FirebaseFirestore.instance
        .collection("contatos")
        .where('excluido', isEqualTo: false)
        .where('userId', isEqualTo: idUser)
        .snapshots();



    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: <Widget>[
                Text(
                  "Contatos",
                  style: TextStyle(
                    fontSize: 20,
                    height: 3,
                  ),
                ),
                Text(
                  "Pesquisar",
                  style: TextStyle(
                    fontSize: 20,
                    height: 3,
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(children: [
            body(snap),
            pesquisa(snap),
          ]),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.pink,
              elevation: 6,
              child: Icon(Icons.add),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Adicionar contato: "),
                        content:
                        Form(
                          key: _homeFormKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Nome:'),
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

                            ],
                          ),
                        ),

                        actions: <Widget>[
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.pink[100]
                              ) ,
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: Text(
                                  "Cancelar",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15
                                  ),
                              )
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.pink,
                            ),
                            child:
                            Text(
                              "Salvar",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,),
                            ),
                            onPressed: () async {
                              if (_homeFormKey.currentState.validate()) {
                                await FirebaseFirestore.instance
                                    .collection("contatos")
                                    .add({
                                  "nome": nameInputController.text,
                                  "endereco": addressInputController.text,
                                  "cep": cepInputController.text,
                                  "email": emailInputController.text,
                                  "telefone": phoneInputController.text,
                                  "userId": idUser,
                                  "excluido": false
                                }).catchError((err) =>
                                    ToastMessage.showToast(
                                        "Não foi possível fazer o cadastro",
                                        0));

                                Navigator.pop(context);

                                nameInputController.clear();
                                emailInputController.clear();
                                addressInputController.clear();
                                cepInputController.clear();
                                phoneInputController.clear();
                              }
                            }
                          ),
                        ],

                      );
                    });
              }),
        ));
  }


  pesquisa(var snap) {
    if (listaContatos == null || listaContatos.length == 0)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(left: 40),
              width: 300,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                          labelText: "Pesquisar", hintText: "Ex: Maria"),
                      controller: _controllerPesquisa,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5, top: 20),
                    height: 30,
                    width: 50,
                    // ignore: deprecated_member_use
                    child: ElevatedButton(
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 15.0,
                      ),
                      onPressed: () {
                        pesquisar();
                      },
                    ),
                  ),
                ],
              )),
        ],
      );
    else
      return ListView.builder(
        itemCount: listaContatos.length,
        itemBuilder: (context, index) {
          var item = listaContatos[index];
          return Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: ListTile(
              leading: Image.asset('images/perfil_img.png',  width: 50,
                 height: 50,),
              title: Text(item["nome"]),
              subtitle: Text(item["telefone"]),
              tileColor: Colors.white,

                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            title: Text(
                              item['nome'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            backgroundColor: Colors.white70,

                            content: Container(
                              height: 250,

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Telefone: ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    item['telefone'],
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "E-mail: ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    item['email'],
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Endereço: ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    item['endereco'],
                                    style: TextStyle(
                                      color:
                                      Colors.blueGrey,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "CEP: ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    item['cep'],
                                    style: TextStyle(

                                      color: Colors.blueGrey,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Fechar",
                                    style: TextStyle(color: Colors.white,),
                                  ))
                            ]);
                      });
                }
            ),
            actions: <Widget>[
              IconSlideAction(
                caption: 'Editar',
                color: Colors.blue,
                icon: Icons.edit,
                onTap: () {
                  print("CLICOU EDITAR");
                },
              ),
              IconSlideAction(
                caption: 'Excluir',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () {
                  print("CLICOU EXCLUIR");
                },
              ),
            ],
          );
        },
      );
    /*return */
  }


  body(var snap) {
    return StreamBuilder(
      stream: snap,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.data.docs.length == 0) {
          return Center(child: Text('Nenhum Contato'));
        }
        return ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            var item = snapshot.data.docs[index];
            return Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              child: ListTile(
                leading: Image.asset('images/perfil_img.png',  width: 50,
                  height: 50,),
                title: Text(item["nome"]),
                subtitle: Text(item["telefone"]),
                tileColor: Colors.white,
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            title: Text(
                              item['nome'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            backgroundColor: Colors.white70,

                            content: Container(
                              height: 250,

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Telefone: ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    item['telefone'],
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "E-mail: ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    item['email'],
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Endereço: ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      item['endereco'],
                                      style: TextStyle(
                                        color:
                                        Colors.blueGrey,
                                        fontSize: 15,
                                      ),
                                    ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "CEP: ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    item['cep'],
                                    style: TextStyle(

                                      color: Colors.blueGrey,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Fechar",
                                  ))
                            ]);
                      });
                }//onTap,
              ),
              actions: <Widget>[
                IconSlideAction(
                  caption: 'Editar',
                  color: Colors.blue,
                  icon: Icons.edit,
                  onTap: () {
                    _editarContato(item);
                  },
                ),
                IconSlideAction(
                  caption: 'Excluir',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () {
                    item.reference.update({'excluido': true});

                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  _editarContato(var item) {
    nameInputController.text = item["nome"];
    emailInputController.text = item["email"];
    addressInputController.text = item["endereco"];
    cepInputController.text = item["cep"];
    phoneInputController.text = item["telefone"];


    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Editar contato: "),
            content:
            Form(
              key: _homeFormKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Nome:'),
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

                ],
              ),
            ),

            actions: <Widget>[
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.pink[100]
                  ) ,
                  onPressed: (){
                    Navigator.pop(context);
                    nameInputController.clear();
                    emailInputController.clear();
                    addressInputController.clear();
                    cepInputController.clear();
                    phoneInputController.clear();
                  },
                  child: Text(
                    "Cancelar",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                    ),
                  )
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink,
                  ),
                  child:
                  Text(
                    "Salvar",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,),
                  ),
                  onPressed: () async {
                    if (_homeFormKey.currentState.validate()) {
                      await  item.reference.update({
                        "nome": nameInputController.text,
                        "endereco": addressInputController.text,
                        "cep": cepInputController.text,
                        "email": emailInputController.text,
                        "telefone": phoneInputController.text,
                      }).catchError((err) =>
                          ToastMessage.showToast(
                              "Não foi possível atualizar o contato",
                              0));

                      Navigator.pop(context);

                      nameInputController.clear();
                      emailInputController.clear();
                      addressInputController.clear();
                      cepInputController.clear();
                      phoneInputController.clear();
                    }
                  }
              ),
            ],

          );
        });

  }

  pesquisar() async {
    print(_controllerPesquisa.text);
    var aux = (await FirebaseFirestore.instance
        .collection("contatos")
        .where("nome", isEqualTo: _controllerPesquisa.text)
        .get())
        .docs;

    setState(() {
      listaContatos = aux;
    });
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
}