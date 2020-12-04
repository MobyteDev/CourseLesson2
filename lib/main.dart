import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/auth_bloc.dart';
import 'login.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  void init() async => await Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    init();
    return MaterialApp(
      title: 'Lesson 2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) => AuthBloc(),
        child: AuthPage(),
      ),
    );
  }
}
