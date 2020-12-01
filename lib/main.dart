import 'package:flutter/material.dart';

import 'splash.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    runApp(MaterialApp(
      home: Splash(),
    ));
  }
}
