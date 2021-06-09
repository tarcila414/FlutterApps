import 'package:flutter/material.dart';

class CalendarBday extends StatelessWidget {
  CalendarBday(item);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(
          "Aniversário",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.pink,

        content: Container(
          height: 280,

          child: new SingleChildScrollView(
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
                  "3929211901909",
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
                  "010edjijicj",
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Rua: ",
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
                  "di939292i9",
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Número",
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
                  "d9i9sdcuhu3921",
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
                  "Bairro",
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
                  "dj210",
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
                  "Complemento: ",
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
                  "2145780-99",
                  style: TextStyle(

                    color: Colors.blueGrey,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Cidade: ",
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
                  "d291991990909-20",
                  style: TextStyle(

                    color: Colors.blueGrey,
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
                  "item['cep']",
                  style: TextStyle(

                    color: Colors.blueGrey,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
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
  }
}
