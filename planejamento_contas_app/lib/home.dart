

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_slidable/flutter_slidable.dart';

import 'Conta.dart';

class PaginaListaDeCompras extends StatefulWidget {
  @override
  _PaginaListaDeComprasState createState() => _PaginaListaDeComprasState();
}

class _PaginaListaDeComprasState extends State<PaginaListaDeCompras> {
  List<Conta> _listaContas = [];
  var _formKey = GlobalKey<FormState>();

  final _tTitulo = TextEditingController();
  final _tValor = TextEditingController();

  @override
  void initState() {
    super.initState();
    _listarContas().then((list) {
      setState(() {
        _listaContas = list;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contas"),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.endDocked, //usar com o BottomNavigationBar
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(

          elevation: 6,
          child: Icon(Icons.add),
          //mini:true,
          //floatingActionButton: FloatingActionButton.extended(
          //icon: Icon(Icons.shopping_cart),
          //label: Text("Adicionar"),
          /*shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(6)
          ),*/
          onPressed: (){
            _resetFields();
            showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    title: Text("Adicionar item: "),
                    content:
                       Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                              _editText("Título:", _tTitulo , "Insira o título"),
                              _editValorInput("VALOR:", _tValor , "Insira o valor da conta"),
                            ],
                        ),
                       ),

                    actions: <Widget>[
                      TextButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: Text("Cancelar")
                      ),
                      TextButton(
                          onPressed: () async {
                            print("clicou1");
                            if(_formKey.currentState.validate()) {
                                await _salvarConta();
                                Navigator.pop(context);

                            }
                          },
                          child: Text("Salvar")
                      ),
                    ],

                  );
                }
            );
          }
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: _listaContas.length,
                itemBuilder: _buildTaskItemSlidable
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskItemSlidable(BuildContext context, int index) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: _buildContaItem(context, index),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Editar',
          color: Colors.blue,
          icon: Icons.edit,
          onTap: () {
            _atualizarConta(_listaContas[index]);
          },
        ),
        IconSlideAction(
          caption: 'Excluir',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            _excluirConta(_listaContas[index]);
          },
        ),
      ],
    );
  }


  Widget _buildContaItem(BuildContext context, int index) {
    final conta = _listaContas[index];
    return CheckboxListTile(
      value: conta.isPaid,
      title: Text(conta.title),
      subtitle: Text(conta.value.toString()),
      tileColor: conta.isPaid == true ? Colors.lightGreen[100] : Colors.white,
      onChanged: (bool isChecked) {
        setState(() {
          conta.isPaid = isChecked;
        });

        _atualizarConta(conta);
      },
    );
  }


  // PROCEDIMENTO PARA LIMPAR OS CAMPOS
  void _resetFields(){
    _tTitulo.text = "";
    _tValor.text = "";
    setState(() {
      _formKey = GlobalKey<FormState>();
    });
  }


  _editText(String field, TextEditingController controller, String validacao) {
    return TextFormField(
      controller: controller,
      validator: (s) => _validate(s, validacao),
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 18,color: Colors.black,),
      decoration: InputDecoration(
        labelText: field,
        labelStyle: TextStyle(fontSize: 18,color: Colors.black,),
      ),
    );
  }

  _editValorInput(String field, TextEditingController controller, String validacao) {
    return TextFormField(
      controller: controller,
      validator: (s) => _validate(s, "Insira o valor da compra"),
      keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
      style: TextStyle(fontSize: 18,color: Colors.black,),
      decoration: InputDecoration(
        labelText: field,
        labelStyle: TextStyle(fontSize: 18,color: Colors.black,),
      ),
    );
  }

  // PROCEDIMENTO PARA VALIDAR OS CAMPOS
  String _validate(String text, String field) {
    if (text.isEmpty) {
      return "$field";
    }
    return null;
  }



  //==============================================================================
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

  _salvarConta() async {
    Database bd = await _recuperarBancoDados();
    Map<String, dynamic> dadosNovaConta = {
      "title": _tTitulo.text,
      "value": double.parse(_tValor.text),
      "isPaid": false
    };
    int id = await bd.insert("contas", dadosNovaConta);

    _listarContas().then((list) {
      setState(() {
        _listaContas = list;
      });
    });
  }

  _listarContas() async {
    Database bd = await _recuperarBancoDados();
    String sql = "SELECT * FROM contas";
    List<Conta> contas = [];
    List bdReturn = await bd.rawQuery(sql);

    for (var item in bdReturn) {
       Conta contaDados = new Conta();
       contaDados.id = item["id"];
       contaDados.title = item["title"];
       contaDados.value = item["value"];
       contaDados.isPaid = item["isPaid"] == 0 ? false : true;

       contas.add(contaDados);

    }
    return contas;
  }


  _atualizarConta(Conta conta) async {
    Database bd = await _recuperarBancoDados();
    Map<String, dynamic> dadosConta = {
      "id": conta.id,
      "title": conta.title,
      "value": conta.value,
      "isPaid": conta.isPaid == true ? 1 : 0
    };
    int retorno = await bd.update(
        "contas", dadosConta,
        where: "id = ?",
        whereArgs: [conta.id]
    );

    _listarContas().then((list) {
      setState(() {
        _listaContas = list;
      });
    });

    print("Itens atualizados: " + retorno.toString());
  }

  _excluirConta(Conta conta) async {
    Database bd = await _recuperarBancoDados();
    int retorno = await bd.delete(
        "contas",
        where: "id = ?", //caracter curinga
        whereArgs: [conta.id]
    );
    print("Itens excluidos: " + retorno.toString());

    _listarContas().then((list) {
      setState(() {
        _listaContas = list;
      });
    });
  }
}
