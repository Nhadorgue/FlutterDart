import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:async';
import 'screenHub.dart';

//stful
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), (){
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context)=>MovieList()
      ));
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:
      Center(
        child:
        Text(
          'Sinefilms',
          style: TextStyle(
            color: Color(0xffe0270d),
            fontWeight: FontWeight.bold,
            fontSize: 66.0,
            fontFamily: 'OpenSansCondensed-Bold',
          ),
        ),
      ),
    );
  }
}
