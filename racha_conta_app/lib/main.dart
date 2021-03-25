import 'dart:html';

import 'package:flutter/material.dart';
void main() => runApp(MyApp());

//Variaveis globais
final _consumoRefeicoes = TextEditingController();
final _qntPessoas = TextEditingController();
final _consumoBebidas = TextEditingController();
final _qntPessoasBebem = TextEditingController();
var _pgtGarcom = 0.0;
var _valorPessoasSemBebidas = 0.0;
var _valorPessoasComBebidas = 0.0;
var _valorFinalDaConta = 0.0;


// Retorna um Input
_editText(String field, TextEditingController controller) {
  return TextFormField(
    controller: controller,
    validator: (s) => _validate(s, field),
    keyboardType: TextInputType.number,
    style: TextStyle(fontSize: 22,color: Colors.blue,),
    decoration: InputDecoration(
      labelText: field,
      labelStyle: TextStyle(fontSize: 22,color: Colors.grey,),
    ),
  );
}

// PROCEDIMENTO PARA VALIDAR OS CAMPOS
String _validate(String text, String field) {
  if (text.isEmpty || double.parse(text) <= 0.0) {
    return "Preencha este campo com valores válidos";
  }
  return null;
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Racha Conta',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // VARIAVEIS
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("RACHA CONTA"),
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
            Image.asset("../assets/images/telaInicio.png",
              ),

            _buttonComecar(),
          ],
        ),
        ));
  }


  _buttonComecar() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.indigo,
        ),
        child:
        Text(
          "COMEÇAR",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,),
        ),
        onPressed: () {
          if(_formKey.currentState.validate()){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ConsumoRefeicoes()),
            );
          }
        },
      ),
    );
  }
}


class ConsumoRefeicoes extends StatefulWidget {
  @override
  _ConsumoRefeicoesState createState() => _ConsumoRefeicoesState();
}
class _ConsumoRefeicoesState extends State<ConsumoRefeicoes> {
  // VARIAVEIS
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo refeições"),
        centerTitle: true,
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
    _consumoRefeicoes.text = "";
    _qntPessoas.text = "";
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
            Image.asset("../assets/images/refeicao.png",
            width: 150,
            height: 150,),
            _editText("Valor do consumo de refeições", _consumoRefeicoes),
            _editText("Quantidade total de pessoas", _qntPessoas),
            _buttonProsseguir(),
          ],
        ),
        ));
  }


  // Widget button
  _buttonProsseguir() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 20),
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.indigo,
        ),
        child:
        Text(
          "CONFIRMAR",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,),
        ),
        onPressed: () {
          if(_formKey.currentState.validate()){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => _ConsumoBebidas()),
              );
          }
        },
      ),
    );
  }

}

/////////////////////////////////////////////////////////////////////////
class _ConsumoBebidas extends StatefulWidget {
  @override
  __ConsumoBebidasState createState() => __ConsumoBebidasState();
}

class __ConsumoBebidasState extends State<_ConsumoBebidas> {
  //Definicao das variaveis
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo Bebidas"),
        centerTitle: true,
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
    _consumoBebidas.text = "";
    _qntPessoasBebem.text = "";
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
            Image.asset("../assets/images/bebida.png",
              width: 150,
              height: 150,),
            _editText("Valor do consumo de bebidas alcoólicas", _consumoBebidas),
            _editText("Quantidade de pessoas que consumiram bebidas alcoólicas", _qntPessoasBebem),
            _buttonProsseguir()
          ],
        ),
        ));
  }// body()

  // Widget button
  _buttonProsseguir() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 20),
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.indigo,
        ),
        child:
          Text(
            "CONFIRMAR",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,),
          ),
          onPressed: () {
            if(_formKey.currentState.validate() && num.parse(_qntPessoasBebem.text) <= num.parse(_qntPessoas.text)){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => _PagamentoGarcom()
                ),
              );
          }
        },
      ),
    );
  }


} // ConsumoBebidasState

//////////////////////////////////////////////////////////////////
class _PagamentoGarcom extends StatefulWidget {
  @override
  __PagamentoGarcomState createState() => __PagamentoGarcomState();
}

class __PagamentoGarcomState extends State<_PagamentoGarcom> {
  //Definicao de variaveis
  var _formKey = GlobalKey<FormState>();
  var label = "0%";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Porcentagem Garçom"),
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
            Image.asset("../assets/images/garcom.png",
              width: 150,
              height: 150,),
            _sliderContainer(),
            _porcentagemTextContainer(),
            _buttonCalcular()
          ],
        ),
        ));
  }// body()


  _pgtGarcomBar () {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Slider(
              value: _pgtGarcom, //definir o valor inicial
              min:0,
              max:100,
              label: label, //label dinamico
              divisions: 10, //define as divisoes entre o minimo e o maximo
              activeColor: Colors.indigo,
              inactiveColor: Colors.indigoAccent,
              onChanged: (double novoValor){
                setState(() {
                  _pgtGarcom = novoValor;
                  label =  novoValor.toString() + "%";
                });
              }
          )]
    );
  }

  //Widget Slider Container
  _sliderContainer () {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(20.0),
    child: _pgtGarcomBar(),
    );
  } //_sliderContainer

  //Container com o texto da porcentagem
  _porcentagemTextContainer () {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.all(20.0),
        child: _text()
      );
  }

  //Texto estilizado de acordo com valor selecionado
  _text () {
    var result;
    if( _pgtGarcom < 20 ) {
      result = Text(
        "                                                                           Porcentagem: " + label,
        style: TextStyle(
          color: Colors.deepOrange,
          fontSize: 20,)
      );
    } else {
      if( _pgtGarcom < 60 ) {
        result = Text(
            "                                                                        Porcentagem: " + label,
            style: TextStyle(
              color: Colors.amber,
              fontSize: 20,)
        );
      } else {
        result = Text(
            "                                                                          Porcentagem: " + label,
            style: TextStyle(
              color: Colors.green,
              fontSize: 20,)
        );
      } //else
    } //else

    return result;
  }

  // Widget button
  _buttonCalcular() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 20),
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.indigo,
        ),
        child:
        Text(
          "Calcular total a pagar",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,),
        ),
        onPressed: () {
          if(_formKey.currentState.validate()){
            _calcular();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => _Results()),
            );
          }
        },
      ),
    );
  }

  //Funcao para calcular o valor que cada cliente deve pagar
  _calcular() {
    var valorIndividualRefeicoes = double.parse(_consumoRefeicoes.text) / double.parse(_qntPessoas.text);
    var valorIndividualBebidas = valorIndividualRefeicoes + (double.parse(_consumoBebidas.text)/ double.parse(_qntPessoasBebem.text));

    _valorPessoasSemBebidas =  valorIndividualRefeicoes * (1.0 + (_pgtGarcom / 100));
    _valorPessoasComBebidas = valorIndividualBebidas * (1.0 + (_pgtGarcom / 100));

    _valorFinalDaConta = ( double.parse(_consumoRefeicoes.text) + double.parse(_consumoBebidas.text)) * (1.0 + (_pgtGarcom / 100));

  }//calcular()
}// __PagamentoGarcomState()


/////////////////////////////////////////////////////////////
class _Results extends StatefulWidget {
  @override
  __ResultsState createState() => __ResultsState();
}

class __ResultsState extends State<_Results> {
  //Definicao das variaveis
  var _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CONTA INDIVIDUAL"),
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
            _principalContainer(),
           ],
        ),
        ));
  }// body()

  _principalContainer() {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.all(20.0),
        child: _text()
    );

  }

  _text() {
    return Text("PESSOAS QUE CONSUMIRAM BEBIDAS ALCOÓLICAS: ..............RS "+ _valorPessoasComBebidas.toStringAsFixed(2)
        + "\n\nPESSOAS QUE NÃO CONSUMIRAM BEBIDAS ALCOÓLICAS: ............RS " + _valorPessoasSemBebidas.toStringAsFixed(2)
        +"\n\nVALOR TOTAL: ................RS" + _valorFinalDaConta.toStringAsFixed(2), style: TextStyle(
      color: Colors.black,
      fontSize: 18,));
  }
} // ResultsState


