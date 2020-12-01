import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

class MovieIndividual extends StatelessWidget {
  final movie;
  var imgURL = 'https://image.tmdb.org/t/p/w500/';
  MovieIndividual(this.movie);
  Color titleColor = const Color(0xffe0270d);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(fit: StackFit.expand, children: [
        //IMAGE
        new Image.network(
          imgURL+ movie['poster_path'],
          fit: BoxFit.cover,
        ),
        new BackdropFilter(
          filter: new ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: new Container(
            color: Colors.black.withOpacity(0.7),
          ),
        ),
        new SingleChildScrollView(
          child: new Container(
            margin: const EdgeInsets.all(30.0),
            child: new Column(
              children: <Widget>[
                new Container(
                  alignment: Alignment.center,
                  child: new Container(
                    width: 400.0,
                    height: 400.0,
                  ),
                  decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(10.0),
                      image: new DecorationImage(
                          image: new NetworkImage(
                              imgURL + movie['poster_path']),
                          fit: BoxFit.cover),
                      boxShadow: [
                        new BoxShadow(
                            color: titleColor,
                            blurRadius: 20.0,
                            offset: new Offset(2.0, 10.0))
                      ]),
                ),
                //TITLE
                new Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 0.0),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                          child: new Text(
                            movie['title'],
                            style: new TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                                fontFamily: 'OpenSansCondensed-Bold.ttf'),
                          )),
                      //RATE
                      new Text(
                        '${movie['vote_average']}/10',
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontFamily: 'OpenSansCondensed-Light.ttf'),
                      )
                    ],
                  ),
                ),
                //DESCRIPTION
                new Text(movie['overview'],style: new TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSansCondensed-Light.ttf')
                ),
                new Padding(padding: const EdgeInsets.all(10.0)),
                new Row(
                  children: <Widget>[

                    new RaisedButton(
                      padding: EdgeInsets.all(10.0),
                      child:new Text(
                        "Voltar",
                        style: new TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSansCondensed-Light.ttf',
                          fontSize: 20.0,
                        ),
                      ),
                      color: Colors.red[700],
                      elevation: 4,
                      onPressed: (){
                        Navigator.of(context).pop(false);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}