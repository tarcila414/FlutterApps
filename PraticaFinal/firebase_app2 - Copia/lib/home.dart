import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

final _formKey = GlobalKey<FormState>();

class HomePage extends StatefulWidget {
  @override
  String idUser;
  static String tag = '/home';

  HomePage();

  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  TextEditingController _controllerPesquisa = TextEditingController();
  List<DocumentSnapshot> r = null;
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    var snap = FirebaseFirestore.instance
        .collection("contatos")
        .where('excluido', isEqualTo: false)
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
                    fontSize: 18,
                  ),
                ),
                Text(
                  "Pesquisar",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            title: Text("Contatos"),
          ),
          body: TabBarView(children: [
            body(snap),
            pesquisa(snap),
          ]),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.red,
              elevation: 6,
              child: Icon(Icons.add),
              onPressed: () {
                print("Botão pressionado!");
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (BuildContext) => NovoCont(widget.idUser)));
              //
              }),
        ));
  }



  pesquisa(var snap) {
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
            return Container(
                padding: EdgeInsets.only(top: 12, left: 16, right: 16),
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: TextButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                              title: Text(item['nome']),
                                              content: Container(
                                                height: 250,
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Endereço: ",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        item['endereco'],
                                                        style: TextStyle(
                                                          color:
                                                          Colors.blueGrey,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Text(
                                                      "CEP: ",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      item['cep'],
                                                      style: TextStyle(
                                                        color: Colors.blueGrey,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Text(
                                                      "Telefone: ",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                      ),
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
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      item['email'],
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
                                  },
                                  child: Text(
                                    item['nome'],
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 20,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                        Spacer(),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.all(5),
                                height: 50,
                                width: 50,
                                // ignore: deprecated_member_use
                                child: ElevatedButton(
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 20.0,
                                  ),
                                  onPressed: () {
                                    print("Botão foi apertado");
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (BuildContext) => EditCont(item)));
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(5),
                                height: 50,
                                width: 50,
                                // ignore: deprecated_member_use
                                child: RaisedButton(
                                  color: Colors.deepOrange,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 20.0,
                                  ),
                                  onPressed: () async {
                                    item.reference.update({'excluido': true});
                                  },
                                ),
                              ),
                            ])
                      ]),
                  Divider(color: Colors.black),
                ]));
          },
        );
      },
    );
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
            return Container(
                padding: EdgeInsets.only(top: 12, left: 16, right: 16),
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: TextButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                              title: Text(item['nome']),
                                              content: Container(
                                                height: 250,
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Endereço: ",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        item['endereco'],
                                                        style: TextStyle(
                                                          color:
                                                          Colors.blueGrey,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Text(
                                                      "CEP: ",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      item['cep'],
                                                      style: TextStyle(
                                                        color: Colors.blueGrey,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Text(
                                                      "Telefone: ",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                      ),
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
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      item['email'],
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
                                  },
                                  child: Text(
                                    item['nome'],
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 20,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                        Spacer(),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.all(5),
                                height: 50,
                                width: 50,
                                // ignore: deprecated_member_use
                                child: ElevatedButton(
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 20.0,
                                  ),
                                  onPressed: () {
                                    print("Botão foi apertado");
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (BuildContext) => EditCont(item)));
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(5),
                                height: 50,
                                width: 50,
                                // ignore: deprecated_member_use
                                child: RaisedButton(
                                  color: Colors.deepOrange,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 20.0,
                                  ),
                                  onPressed: () async {
                                    item.reference.update({'excluido': true});
                                  },
                                ),
                              ),
                            ])
                      ]),
                  Divider(color: Colors.black),
                ]));
          },
        );
      },
    );
  }

  pesquisar() async {
    print(_controllerPesquisa.text);
    var aux = (await FirebaseFirestore.instance
        .collection("contatos")
        .where("nome", isEqualTo: _controllerPesquisa.text)
        .get())
        .docs;

    setState(() {
      r = aux;

      this._loading = false;
    });
    print(r.length);
  }
}