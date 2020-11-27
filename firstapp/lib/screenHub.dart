//import 'dart:html';
import 'dart:io';
import 'dart:ui';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: movieList(),

  ));
}

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

class movieList extends StatefulWidget {
  @override
  _movieListState createState() => _movieListState();
}

Future<Map> getJson() async{
  var url = 'https://api.themoviedb.org/3/movie/550?api_key={352ad2964b88ab39889a45dfab193e02}';
  http.Response resp = await http.get(url);
  return json.decode(resp.body);
}

class _movieListState extends State<movieList> {

  var movies;

  void getDatas() async{
    var data = await getJson();

    setState(() {
      movies = data['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    getDatas();
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title:
        Text('Sinefilms',
          style: TextStyle(
            color: Color(0xffe0270d),
            fontSize: 36.0,
            fontFamily: 'OpenSansCondensed-Bold',

          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Color(0xffe0270d),
            ),
            onPressed: (){
              showExitAlertDialog(context);
            },
          )
        ],
      ),
      body: Center(
        ///////////////////////////////////PAREI AQUI
      ),
    );
  }
}






