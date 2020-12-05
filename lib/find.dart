import 'dart:async';
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'individual.dart';


class FindMovie extends StatefulWidget {
  @override
  FindMovieState createState() {
    return new FindMovieState();
  }
}

class FindMovieState extends State<FindMovie> {
  Color titleColor = const Color(0xffe0270d);
  //final movies;
  //FindMovie(this.movies);
  var movies;

  String nameMovie = "";

  void getData() async {
    var data = await getJson();

    setState(() {
      movies = data['results'];
    });
  }

  @override
  Widget build(BuildContext context) {

    return new Expanded(
      child: new ListView.builder(
          itemCount: movies == null ? 0 : movies.length,
          itemBuilder: (context, i) {
            return new RaisedButton(

              //child: new MovieDetails(movies, i),
              padding: const EdgeInsets.all(0.0),

              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                      return new MovieIndividual(movies[i]);
                    }));
              },
              color: Colors.grey[900],
            );
          }),

    );

  }
}



Future<Map> getJson() async {
  var apiKey = '352ad2964b88ab39889a45dfab193e02';
  var url = 'http://api.themoviedb.org/3/discover/movie?api_key=${apiKey}&language=pt-BR&sort_by=release_date.desc';
  var response = await http.get(url);
  return json.decode(response.body);
}


showTestAlertDialog(BuildContext context, nameMovie){

  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.grey[900],
    content:
    Text(nameMovie,
      textAlign: TextAlign.center,
      style:
      TextStyle(
        color: Color(0xffffffff),
        fontSize: 36.0,
        fontFamily: 'OpenSansCondensed-Light',
      ),
    ),
  );

  showDialog(
    context: context,
    builder: (BuildContext context){
      return alert;
    },
    barrierDismissible: false,
  );
}