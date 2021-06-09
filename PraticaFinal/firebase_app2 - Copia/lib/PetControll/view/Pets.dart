import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'toast.dart';

class PetsPage extends StatefulWidget {
  @override
  _PetsPageState createState() => _PetsPageState();
}

class _PetsPageState extends State<PetsPage> {
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final GlobalKey<FormState> _petsFormKey = GlobalKey<FormState>();

  List<DocumentSnapshot> listaPets = null;
  var userId = "";

  TextEditingController nameInputController;
  TextEditingController idadeInputController;

  var itemImg = "";

  @override
  void initState() {
    // TODO: implement initState
    nameInputController = new TextEditingController();
    idadeInputController = new TextEditingController();
    userId = FirebaseAuth.instance.currentUser.uid;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var snap = FirebaseFirestore.instance
        .collection('animais')
        .where('userId',isEqualTo: userId)
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
            child: Text("MEUS PETS", style: TextStyle( fontSize: 28, fontWeight: FontWeight.bold))
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
                  return Container(
                    margin: EdgeInsets.only(top:300),
                    child: Center(child: Text('Você não cadastrou um pet ainda :(', style: TextStyle(fontSize: 22),)),
                  );
                }


                return Expanded(
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: ( context, index ) {
                              var item = snapshot.data.docs[index];
                              return Slidable(
                                actionPane: SlidableDrawerActionPane(),
                                actionExtentRatio: 0.25,
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(color: Color(0XFFFFFFFF),borderRadius: BorderRadius.circular(5)),
                                  child: ListTile(
                                    title: Text(item['nome'], style: TextStyle(fontSize: 20, color: Color(0xFFFF9000),)),
                                    subtitle: Row(
                                      children: [
                                        Text(item['idade'], style: TextStyle(fontSize: 16, color: Color(0xFFFF9000),)),
                                      ],
                                    ),
                                    leading: ConstrainedBox(
                                        constraints: BoxConstraints.tightFor(width: 50, height: 50),
                                        child: Image.network(item["img"] != "" ? item["img"] : 'https://firebasestorage.googleapis.com/v0/b/projeto-exemplo-18a77.appspot.com/o/images%2FanimalPerfil.png?alt=media&token=f337421c-22fb-4dcb-bdcf-98f22fde1188',
                                          width: 50,
                                          height: 50,
                                        ),
                                    )
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
                                      itemImg = item["img"];
                                      _editarPetInfo(item);
                                    },
                                  ),
                                ],
                              );
                            }
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
            title: Text("Adicionar um pet ", style: TextStyle(color: Color(0XFFFF9000), fontSize: 25, fontWeight: FontWeight.bold),),
            backgroundColor: Color(0XFFFFFFFF),
            content:
            Form(
                key: _petsFormKey,
                child: SizedBox(
                    height: 200,
                    child:Column(
                      children: <Widget>[
                        TextFormField(
                          style: TextStyle( color: Colors.black, fontSize: 20),
                          decoration: InputDecoration(
                            labelText: 'Nome',
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
                          controller: nameInputController,
                        ),
                        SizedBox( height: 20,),
                        TextFormField(
                          style: TextStyle(color: Colors.black, fontSize: 20),
                          decoration: InputDecoration(
                            labelText: 'Idade',
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
                      ],
                    )
                ),
            ),

            actions: <Widget>[
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Color(0x9CF3B14B)),
                  onPressed: (){
                    Navigator.pop(context);
                    nameInputController.clear();
                    idadeInputController.clear();
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
                    if (_petsFormKey.currentState.validate()) {
                      await FirebaseFirestore.instance
                          .collection("animais")
                          .add({
                        "nome": nameInputController.text,
                        "idade": idadeInputController.text,
                        "userId": userId,
                        "img": "",
                        "isActive": true
                      }).catchError((err) =>
                          ToastMessage.showToast("Não foi possível fazer o cadastro", 0));

                      Navigator.pop(context);

                      nameInputController.clear();
                      idadeInputController.clear();

                    }
                  }
              ),
            ],

          );
        });
  }

  _editarPetInfo(var item) {
    print("ENTRAR EDITAR CONTATO ${item["nome"]}");
    nameInputController.text = item["nome"];
    idadeInputController.text = item["idade"];

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
                  title: Text("Editar ", style: TextStyle(color: Color(0XFFFF9000), fontSize: 25, fontWeight: FontWeight.bold),),
                  backgroundColor: Color(0XFFFFFFFF),
                  content:
                  Form(
                    key: _petsFormKey,
                    child: SizedBox(
                      height: 300,
                      child:Column(
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(primary: Color(0x3FFF9000), padding: EdgeInsets.all(0.0) ),
                            child: (item['img'] != "") ?
                            Image.network( item["img"], width: 50,height: 50, fit: BoxFit.fill)
                                : Icon( Icons.add_a_photo,  color: Color(0xFFFF9000), size: 30, ),

                            onPressed: () {
                              selectFileToUpload(item);
                            },
                          ),
                        ),
                        SizedBox( height: 50,),
                        TextFormField(
                        style: TextStyle( color: Colors.black, fontSize: 20),
                        decoration: InputDecoration(
                          labelText: 'Nome',
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
                        controller: nameInputController,
                      ),
                        SizedBox( height: 20,),
                        TextFormField(
                        style: TextStyle(color: Colors.black, fontSize: 20),
                        decoration: InputDecoration(
                          labelText: 'Idade',
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
                      ],
                    )
                    ),
                  ),

                  actions: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color(0x9CF3B14B)
                      ) ,
                      onPressed: (){
                        Navigator.pop(context);
                        nameInputController.clear();
                        idadeInputController.clear();
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
                    primary: Color(0XFFFF9000),
                  ),
                  child:
                  Text(
                    "Salvar",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,),
                  ),
                  onPressed: () async {
                    if (_petsFormKey.currentState.validate()) {
                      await  item.reference.update({
                        "nome": nameInputController.text,
                        "idade": idadeInputController.text,
                        "img": itemImg,
                      }).catchError((err) =>
                          ToastMessage.showToast(
                              "Não foi possível atualizar as informações",
                              0
                          )
                      );

                      itemImg = "";

                      Navigator.pop(context);

                      nameInputController.clear();
                      idadeInputController.clear();
                    }
                  }
              ),
                  ],
                );
        });
  }


  Future selectFileToUpload(var item) async {
    try {
      FilePickerResult result  = await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.image);

      if(result  != null ) {
        File file = File(result.files[0].path);

        UploadTask task  = uploadFileToStorage(file);

        saveImageUrlToFirebase(task, item);
      } else {
        print("User has canceled the selection");
      }
    } catch(e) {
      print("Erro " + e);
    }
  }

  uploadFileToStorage(File file) {
    UploadTask task = _firebaseStorage.ref().child("images/${DateTime.now().toString()}").putFile(file);
    return task;
  }

  saveImageUrlToFirebase(UploadTask task, var item) async {
    task.snapshotEvents.listen((snapShot) {
      if(snapShot.state == TaskState.success) {
        snapShot.ref.getDownloadURL()
            .then(
                (imageUrl) => {
                  itemImg = imageUrl,
            }
        );
      }
    });
  }

  writeImageUrlToFireStore(String imageUrl, var item){
    item.reference.update({"img": imageUrl});
  }
}