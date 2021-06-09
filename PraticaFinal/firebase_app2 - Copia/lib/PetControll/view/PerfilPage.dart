import 'dart:io';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'toast.dart';

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  final GlobalKey<FormState> _perfilFormKey = GlobalKey<FormState>();

  List<DocumentSnapshot> user = null;

  TextEditingController emailInputController;
  TextEditingController nameInputController;

  @override
  initState() {
    emailInputController = new TextEditingController();
    nameInputController = new TextEditingController();
    preencherUserData();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0XFFd6d6d6),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 40, right: 40, top: 100),
        height: MediaQuery.of(context).size.height,
        child: Form(
            key: _perfilFormKey,
            child: SizedBox(
                child: Column(
                  children: <Widget>[
                    SizedBox(

                      child:
                        Container(
                          width: 80,
                          height: 80,
                          margin: EdgeInsets.only(bottom: 30),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),

                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(primary: Color(0x3FFF9000), padding: EdgeInsets.all(0.0) ),
                            child: (user != null && user[0]["img"] != "") ?
                             Image.network( user[0]["img"], width: 80,height: 80, fit: BoxFit.fill)
                            : Icon( Icons.add_a_photo,  color: Color(0xFFFF9000), size: 50, ),

                            onPressed: () {
                              selectFileToUpload();
                            },
                          ),

                          //
                        ),
                    ),

                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        style: TextStyle( fontSize: 20, ),
                        decoration: InputDecoration(
                            labelText: 'Nome',
                            labelStyle: TextStyle( color: Color(0xFFFF9000), fontWeight: FontWeight.bold, fontSize: 30),
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
                        keyboardType: TextInputType.text,
                      ),
                    ),

                    SizedBox( height: 20,),
                    SizedBox(
                      width: 400,
                        child: TextFormField(
                          style: TextStyle( fontSize: 20),
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle( color: Color(0xFFFF9000), fontWeight: FontWeight.bold, fontSize: 30),
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
                        controller: emailInputController,
                        ),
                    ),
                    SizedBox( height: 130,),
                    SizedBox(
                      width: 200,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Color(0xFFFF9000)),
                        child: Text("Salvar"),
                        onPressed: () async {
                          await  user[0].reference.update({
                            "nome": nameInputController.text,
                            "email": emailInputController.text,
                          }).then((value) => ToastMessage.showToast(
                                "Dados atualizados com sucesso!", 1)
                          );
                        },
                      )
                  )
              ],
            )
            )
        ),
      ),
    );


  }

  preencherUserData() async {
    var userId = FirebaseAuth.instance.currentUser.uid;
    var aux = (
        await FirebaseFirestore.instance
          .collection("usuarios")
          .where("id", isEqualTo: userId)
          .limit(1)
          .get())
        .docs;
    emailInputController.text = aux[0]["email"];
    nameInputController.text = aux[0]["nome"];

    setState(() {
      user = aux;
    });
  }

  Future selectFileToUpload() async {
    try {
      FilePickerResult result  = await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.image);

      if(result  != null ) {
        File file = File(result.files[0].path);

        UploadTask task  = uploadFileToStorage(file);

        saveImageUrlToFirebase(task);
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

  saveImageUrlToFirebase(UploadTask task) async {
    task.snapshotEvents.listen((snapShot) {
      if(snapShot.state == TaskState.success) {
        snapShot.ref.getDownloadURL()
            .then(
                (imageUrl) => {
              writeImageUrlToFireStore(imageUrl),
            }
        );
      }
    });
  }

  writeImageUrlToFireStore(String imageUrl){
    user[0].reference.update({"img": imageUrl});
  }

}
