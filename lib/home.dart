import 'package:flutter/material.dart';

void main(List<String> args) {
  MyApp();
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MyHomePage',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: myHomePage());
  }
}

class myHomePage extends StatelessWidget {
  myHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My new Home page'),
      ),
    );
  }
}
