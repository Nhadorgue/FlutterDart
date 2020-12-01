import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'exit.dart';

class FindMovie extends StatelessWidget {
  Color titleColor = const Color(0xffe0270d);
  final movies;
  FindMovie(this.movies);

  String nameMovie = "TESTE!!!";

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),

      child: new TextField(
        textAlign: TextAlign.center,
        //typing the name's movie
        onChanged: (text){
          nameMovie = text;
        },

        style: new TextStyle(
          color: Colors.white,
          fontSize: 26,
        ),

        decoration: new InputDecoration(
          hintText: "Digite o nome do filme...",
          hintStyle: new TextStyle(
            color: Colors.white.withOpacity(0.5),
          ),

          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: titleColor
            ),


          ),
        ),

      ),
    );
  }
}


/*Padding(
      padding: const EdgeInsets.fromLTRB(50.0, 0.0, 16.0, 16.0),
      child:
      new Text(
        'Filmes',
        style: new TextStyle(
            fontSize: 40.0,
            color: titleColor,
            fontFamily: 'OpenSansCondensed-Light'),
        textAlign: TextAlign.center,
      ),
    );*/