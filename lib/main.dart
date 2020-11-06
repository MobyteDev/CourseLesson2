import 'package:auth_test/info.dart';
import 'package:auth_test/log_n_pas_screen.dart';
import 'package:flutter/material.dart';
import 'xylophone.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        accentColor: Colors.amber,
        primaryColor: Colors.blueAccent,
        canvasColor: Colors.blueAccent[50],
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: InfoPage(name: "User"),//LogNPass(),
    );
  }
}
