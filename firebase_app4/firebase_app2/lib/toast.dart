import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class ToastMessage {
  /*
  * @message: Mensagem a ser mostrada no corpo do toast
  * @toastType: 0-fracasso  1-sucesso  2-informação
  */
  static showToast(message, toastType) {
    var color;

    switch(toastType) {
      case 0: color = Colors.red[100]; break;
      case 1: color = Colors.lightGreenAccent[100]; break;
      case 2: color = Colors.yellow[100]; break;
    }

    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIos: 2,
        backgroundColor: color,
        textColor: Colors.black87
    );
  }
}