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
    home: MovieList(),

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

class MovieTitle extends StatelessWidget {
  
  final Color titleColor;
  
  MovieTitle(this.titleColor);
  
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      child: new Text(
        'Filmes',
        style: new TextStyle(
          fontSize: 40.0,
          color: titleColor,
          fontFamily: 'OpenSansCondensed-Bold.ttf'
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}

class MovieDetails extends StatelessWidget {
  
  final movies;
  final i;
  Color titleColor = const Color(0xffe0270d);
  var imgURL = 'https://image.tmdb.org/t/p/w500/';
  MovieDetails(this.movies, this.i);
  
  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        
        new Row(
          
          children: <Widget>[
            
            new Padding(
              padding: const EdgeInsets.all(0.0),
              
              child: new Container(
                margin: const EdgeInsets.all(16.0),
                
                child: new Container(
                  width: 70.0,
                  height: 70.0,
                ),
                
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(10.0),
                  color: Colors.grey,
                  
                  image: new DecorationImage(
                    image: new NetworkImage(imgURL+movies[i]['post_path']),
                    fit: BoxFit.cover
                  ),
                  
                  boxShadow: [
                    
                    new BoxShadow(
                      color: titleColor,
                      blurRadius: 5.0,
                      offset: new Offset(2.0, 5.0)
                    ),
                  ],
                  
                ),
              ),
            ),
            
            new Expanded(
              
              child: new Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                
                child: new Column(
                  
                  children: [
                    
                    new Text(
                      movies[i]['title'],
                      
                      style: new TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'OpenSansCondensed-Bold.ttf',
                        color: titleColor
                      ),
                    ),

                    new Padding(
                        padding: const EdgeInsets.all(2.0)
                    ),
                    
                    new Text(
                      movies[i]['overview'],
                      maxLines: 3,
                      
                      style: new TextStyle(
                        color: const Color(0xff8785A4),
                        fontFamily: 'OpenSansCondensed-Light.ttf'
                      ),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
            ),
          ],
        ),
        
        new Container(
          width: 300,
          height: 0.5,
          color: const Color(0xd2d2e1ff),
          margin: const EdgeInsets.all(16.0),
        )
      ],
    );
  }
}



class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

Future<Map> getJson() async{
  var url = 'https://api.themoviedb.org/3/discover/movie?api_key={352ad2964b88ab39889a45dfab193e02}&language=pt-BR';
  http.Response resp = await http.get(url);
  return json.decode(resp.body);
}

class _MovieListState extends State<MovieList> {

  var movies;
  Color titleColor = const Color(0xffe0270d);

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
      body: new Padding(
        padding: const EdgeInsets.all(16.0),
        
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: <Widget>[
            new MovieTitle(titleColor),
            
            new Expanded(
              child: new ListView.builder(
                itemCount: movies==null? 0:movies.lenght,
                
                  itemBuilder: (context, i){
                  
                  return new FlatButton(
                    child: new MovieDetails(movies, i),
                    padding: const EdgeInsets.all(0.0),
                    color: Colors.white,
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}






