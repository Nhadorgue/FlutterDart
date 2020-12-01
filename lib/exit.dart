import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

showExitAlertDialog(BuildContext context){
  Widget noButton = FlatButton(
    child: Text('Não'),
    onPressed: (){
      Navigator.of(context).pop(false);
    },
  );

  Widget yesButton = FlatButton(
    child: Text('Sim'),
    onPressed: (){
      SystemNavigator.pop();
    },
  );

  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.grey[900],
    content:
    Text('Deseja realmente sair?',
      textAlign: TextAlign.center,
      style:
      TextStyle(
        color: Color(0xffffffff),
        fontSize: 36.0,
        fontFamily: 'OpenSansCondensed-Light',
      ),
    ),
    actions: [
      yesButton,
      noButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context){
      return alert;
    },
    barrierDismissible: false,
  );
}
