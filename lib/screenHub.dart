import 'dart:async';
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'exit.dart';
import 'find.dart';
import 'individual.dart';

class MovieList extends StatefulWidget {
  @override
  MovieListState createState() {
    return new MovieListState();
  }
}

class MovieListState extends State<MovieList> {
  var movies;
  Color titleColor = const Color(0xffe0270d);

  void getData() async {
    var data = await getJson();

    setState(() {
      movies = data['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return new Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: new AppBar(
        elevation: 0.3,
        centerTitle: true,
        backgroundColor: Colors.black,
        title: new Text(
          'Sinefilms',
          style: new TextStyle(
              color: titleColor,
              fontSize: 46,
              fontFamily: 'OpenSansCondensed-Bold.ttf',
              fontWeight: FontWeight.bold),

        ),
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
            //set the movie's name
            new FindMovie(movies),
            new Expanded(
              child: new ListView.builder(
                  itemCount: movies == null ? 0 : movies.length,
                  itemBuilder: (context, i) {
                    return new FlatButton(
                      child: new MovieDetails(movies, i),
                      padding: const EdgeInsets.all(0.0),
                      onPressed: () {
                        Navigator.push(context,
                            new MaterialPageRoute(builder: (context) {
                              return new MovieIndividual(movies[i]);
                            }));
                      },
                      color: Colors.white,
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

Future<Map> getJson() async {
  var apiKey = '352ad2964b88ab39889a45dfab193e02';
  var url = 'http://api.themoviedb.org/3/discover/movie?api_key=${apiKey}&language=pt-BR&sort_by=original_title';
  var response = await http.get(url);
  return json.decode(response.body);
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
            //IMAGE
            new Padding(
              padding: const EdgeInsets.all(0.0),
              child: new Container(
                margin: const EdgeInsets.all(16.0),
//              child: new Image.network(image_url+movies[i]['poster_path'],width: 100.0,height: 100.0),
                child: new Container(
                  width: 70.0,
                  height: 100.0,
                ),
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(10.0),
                  image: new DecorationImage(
                      image: new NetworkImage(
                          imgURL + movies[i]['poster_path']),
                      fit: BoxFit.cover),
                  boxShadow: [
                    new BoxShadow(
                        color: titleColor,
                        blurRadius: 5.0,
                        offset: new Offset(2.0, 5.0))
                  ],
                ),
              ),
            ),
            //TITLE
            new Expanded(
                child: new Container(
                  margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                  child: new Column(
                    children: [
                      new Text(
                        movies[i]['title'],
                        style: new TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'OpenSansCondensed-Bold.ttf',
                            color: titleColor),
                      ),
                      new Padding(padding: const EdgeInsets.all(2.0)),
                      //DESCRIPTION
                      new Text(
                        movies[i]['overview']+"...",
                        maxLines: 4,
                        style: new TextStyle(
                            color: Colors.grey,
                            fontFamily: 'OpenSansCondensed-Light.ttf'
                        ),
                      )
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                )),
          ],
        ),
        new Container(
          width: 1000.0,
          height: 2,
          color: Colors.grey[900],
          margin: const EdgeInsets.all(0.0),

        )
      ],
    );
  }
}