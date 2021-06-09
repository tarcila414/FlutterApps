import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'toast.dart';


class AdocoesPage extends StatefulWidget {
  @override
  _AdocoesPageState createState() => _AdocoesPageState();
}

class _AdocoesPageState extends State<AdocoesPage > {
  List<DocumentSnapshot> listaAdocoes = null;
  final GlobalKey<FormState> _adocoesFormKey = GlobalKey<FormState>();

  TextEditingController tituloInputController;
  TextEditingController idadeInputController;
  TextEditingController phoneInputController;

  var userId = "";

  @override
  void initState() {
    // TODO: implement initState
    tituloInputController = new TextEditingController();
    idadeInputController = new TextEditingController();
    phoneInputController = new TextEditingController();

    userId = FirebaseAuth.instance.currentUser.uid;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var snap = FirebaseFirestore.instance
        .collection('adocoes')
        .where('isActive', isEqualTo: true)
        .snapshots();

    return Scaffold(
        backgroundColor: Color(0XFFd6d6d6),
        body: body(snap),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0XFFFF9000),
            elevation: 6,
            child: Icon(Icons.add, color: Colors.white,),
            onPressed: ()  {
              _addPet();
            })
    );
  }

  body( snap ) {
    return Container(
      margin: EdgeInsets.only(top: 29),
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              color: Color(0xFFFF9000),
              child: Text("Adoção Consciente", style: TextStyle( fontSize: 28, fontWeight: FontWeight.bold))
          ),
          StreamBuilder(
              stream: snap,
              builder: (BuildContext context,  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.data.docs.length == 0) {
                  return Center(child: Text('Nenhuma adoção encontrada'));
                }


                return Expanded(
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                            child: ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: ( context, index ) {
                              var item = snapshot.data.docs[index];
                              return item["userId"] != userId ?
                                Container(
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(color: Color(0XFFFFFFFF),borderRadius: BorderRadius.circular(5)),
                                  child: ListTile(
                                    title: Text(item['titulo'], style: TextStyle(fontSize: 20, color: Color(0xFFFF9000),)),
                                    subtitle: Row(
                                      children: [
                                        Text(item['idade'], style: TextStyle(fontSize: 16, color: Color(0xFFFF9000),)),
                                      ],
                                    ),
                                    trailing: Text(item['telefone'], style: TextStyle(fontSize: 15, color: Color(0xFFFF9000),)),
                                  ),
                                ) :
                                Slidable(
                                  actionPane: SlidableDrawerActionPane(),
                                  actionExtentRatio: 0.25,
                                  child: Container(
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(color: Color(0XFFFFFFFF),borderRadius: BorderRadius.circular(5)),
                                  child: ListTile(
                                    title: Text(item['titulo'], style: TextStyle(fontSize: 20, color: Color(0xFFFF9000),)),
                                    subtitle: Row(
                                      children: [
                                        Text(item['idade'], style: TextStyle(fontSize: 16, color: Color(0xFFFF9000),)),
                                      ],
                                    ),
                                    trailing: Icon(Icons.wb_incandescent, color: Color(0xFFFF9000), size: 30,),
                                  ),
                                ),
                                  actions: <Widget>[
                                    IconSlideAction(
                                      caption: 'Excluir',
                                      color: Colors.red,
                                      icon: Icons.delete,
                                      onTap: () {
                                        item.reference.update({'isActive': false});
                                      },
                                    ),
                                    IconSlideAction(
                                      caption: 'Editar',
                                      color: Colors.blue,
                                      icon: Icons.edit,
                                      onTap: () {
                                        print("Editar clicado");
                                        _editarPet(item);
                                      },
                                    ),
                                ],
                              );

                            }
                        )
                        )
                    )
                );
              })
        ],
      ),
    );

  }

  _addPet() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Adicionar uma doação ", style: TextStyle(color: Color(0XFFFF9000), fontSize: 25, fontWeight: FontWeight.bold),),
            backgroundColor: Color(0XFFFFFFFF),
            content:
            Form(
              key: _adocoesFormKey,
              child: SizedBox(
                  height: 300,
                  child:Column(
                    children: <Widget>[
                      TextFormField(
                        style: TextStyle( color: Colors.black, fontSize: 20),
                        decoration: InputDecoration(
                          labelText: 'Título',
                          labelStyle: TextStyle( color: Color(0xFFFF9000), fontWeight: FontWeight.bold, fontSize: 25),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22.0),
                            borderSide: BorderSide(
                              color: Color(0xFFFF9000),
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Color(0xFFFF9000),
                                width: 2.5,
                              )
                          ),
                        ),
                        controller: tituloInputController,
                      ),
                      SizedBox( height: 20,),
                      TextFormField(
                        style: TextStyle(color: Colors.black, fontSize: 20),
                        decoration: InputDecoration(
                          labelText: 'Idade dos animais',
                          labelStyle: TextStyle( color: Color(0xFFFF9000), fontWeight: FontWeight.bold, fontSize: 25),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22.0),
                            borderSide: BorderSide(
                              color: Color(0xFFFF9000),
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Color(0xFFFF9000),
                                width: 2.5,
                              )
                          ),
                        ),
                        controller: idadeInputController,
                      ),
                      SizedBox( height: 20,),
                      TextFormField(
                        style: TextStyle(color: Colors.black, fontSize: 20),
                        decoration: InputDecoration(
                          labelText: 'Telefone para contato',
                          labelStyle: TextStyle( color: Color(0xFFFF9000), fontWeight: FontWeight.bold, fontSize: 25),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22.0),
                            borderSide: BorderSide(
                              color: Color(0xFFFF9000),
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Color(0xFFFF9000),
                                width: 2.5,
                              )
                          ),
                        ),
                        controller: phoneInputController,
                      ),
                    ],
                  )
              ),
            ),

            actions: <Widget>[
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Color(0x9CF3B14B)),
                  onPressed: (){
                    Navigator.pop(context);
                    tituloInputController.clear();
                    idadeInputController.clear();
                    phoneInputController.clear();
                  },
                  child: Text(
                    "Cancelar",
                    style: TextStyle(color: Colors.white,fontSize: 15),
                  )
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color(0XFFFF9000)
                  ),
                  child: Text(
                    "Salvar",
                    style: TextStyle(color: Colors.white,fontSize: 15,),
                  ),
                  onPressed: () async {
                    if (_adocoesFormKey.currentState.validate()) {
                      await FirebaseFirestore.instance
                          .collection("adocoes")
                          .add({
                        "titulo": tituloInputController.text,
                        "idade": idadeInputController.text,
                        "telefone": phoneInputController.text,
                        "userId": userId,
                        "isActive": true
                      }).catchError((err) =>
                          ToastMessage.showToast("Não foi possível fazer o cadastro", 0));

                      Navigator.pop(context);

                      tituloInputController.clear();
                      idadeInputController.clear();
                      phoneInputController.clear();

                    }
                  }
              ),
            ],

          );
        });
  }


  _editarPet( var item ) {
    tituloInputController.text = item['titulo'];
    phoneInputController.text = item['telefone'];
    idadeInputController.text = item['idade'];
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Editar ", style: TextStyle(color: Color(0XFFFF9000), fontSize: 25, fontWeight: FontWeight.bold),),
            backgroundColor: Color(0XFFFFFFFF),
            content:
            Form(
              key: _adocoesFormKey,
              child: SizedBox(
                  height: 300,
                  child:Column(
                    children: <Widget>[
                      TextFormField(
                        style: TextStyle( color: Colors.black, fontSize: 20),
                        decoration: InputDecoration(
                          labelText: 'Título',
                          labelStyle: TextStyle( color: Color(0xFFFF9000), fontWeight: FontWeight.bold, fontSize: 25),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22.0),
                            borderSide: BorderSide(
                              color: Color(0xFFFF9000),
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Color(0xFFFF9000),
                                width: 2.5,
                              )
                          ),
                        ),
                        controller: tituloInputController,
                      ),
                      SizedBox( height: 20,),
                      TextFormField(
                        style: TextStyle(color: Colors.black, fontSize: 20),
                        decoration: InputDecoration(
                          labelText: 'Idade dos animais',
                          labelStyle: TextStyle( color: Color(0xFFFF9000), fontWeight: FontWeight.bold, fontSize: 25),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22.0),
                            borderSide: BorderSide(
                              color: Color(0xFFFF9000),
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Color(0xFFFF9000),
                                width: 2.5,
                              )
                          ),
                        ),
                        controller: idadeInputController,
                      ),
                      SizedBox( height: 20,),
                      TextFormField(
                        style: TextStyle(color: Colors.black, fontSize: 20),
                        decoration: InputDecoration(
                          labelText: 'Telefone para contato',
                          labelStyle: TextStyle( color: Color(0xFFFF9000), fontWeight: FontWeight.bold, fontSize: 25),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22.0),
                            borderSide: BorderSide(
                              color: Color(0xFFFF9000),
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Color(0xFFFF9000),
                                width: 2.5,
                              )
                          ),
                        ),
                        controller: phoneInputController,
                      ),
                    ],
                  )
              ),
            ),

            actions: <Widget>[
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Color(0x9CF3B14B)),
                  onPressed: (){
                    Navigator.pop(context);
                    tituloInputController.clear();
                    idadeInputController.clear();
                    phoneInputController.clear();
                  },
                  child: Text(
                    "Cancelar",
                    style: TextStyle(color: Colors.white,fontSize: 15),
                  )
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color(0XFFFF9000)
                  ),
                  child: Text(
                    "Salvar",
                    style: TextStyle(color: Colors.white,fontSize: 15,),
                  ),
                  onPressed: () async {
                    if (_adocoesFormKey.currentState.validate()) {
                      await item.reference
                          .update({
                            "titulo": tituloInputController.text,
                            "idade": idadeInputController.text,
                            "telefone": phoneInputController.text
                          }).catchError((err) =>{
                            print(err),
                            ToastMessage.showToast("Não foi possível fazer o cadastro", 0)});

                      Navigator.pop(context);

                      tituloInputController.clear();
                      idadeInputController.clear();
                      phoneInputController.clear();

                    }
                  }
              ),
            ],

          );
        });
  }
}