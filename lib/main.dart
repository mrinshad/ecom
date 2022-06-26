import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Home',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: welcomePage());
  }
}

class myHomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home page')),
      body: Center(
        child: Text('Hello world !!'),
      ),
    );
  }
}

class welcomePage extends StatelessWidget {
  gotoLoginPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => loginPage()),
    );
  }

  gotoSignupPage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignupPage()));
  }

  welcomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My new Home page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
              child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: TextButton(
                    style: raisedButtonStyle,
                    onPressed: () {
                      gotoLoginPage(context);
                    },
                    child: Text('LOGIN'),
                  ))),
          Center(
            child: TextButton(
              style: raisedButtonStyle,
              child: Text('SIGNUP'),
              onPressed: () {
                gotoSignupPage(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class loginPage extends StatelessWidget {
  final usernameTextField = TextEditingController();
  final passwordTextField = TextEditingController();
  loginPage({super.key});

  gotoHomePage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => myHomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login Screen"),
        ),
        body: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: usernameTextField,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Username',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              obscureText: true,
              controller: passwordTextField,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your password..'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextButton(
              style: raisedButtonStyle,
              onPressed: () {
                String username = usernameTextField.text;
                String password = passwordTextField.text;
                if (username == 'admin' && password == '123') {
                  gotoHomePage(context);
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                              title: Text('Alert Dialog'),
                              content: Text(
                                  'Invalid username and password try again'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ]));
                }
              },
              child: Text('Login'),
            ),
          )
        ]));
  }
}

class SignupPage extends StatelessWidget {
  final fullname = TextEditingController();
  final address = TextEditingController();
  final phonenumber = TextEditingController();
  final password = TextEditingController();
  final c_password = TextEditingController();
  @override
  Widget build(BuildContext build) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
        ),
        body: Form(
          child: Column(children: [
            Container(
              margin: EdgeInsets.only(
                  left: 50.0, right: 50.0, bottom: 20.0, top: 20.0),
              child: TextField(
                controller: fullname,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(),
                  hintText: 'Fullname',
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 50.0, right: 50.0, bottom: 20.0),
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.home),
                      border: OutlineInputBorder(),
                      hintText: 'Address'),
                )),
            Container(
                margin: EdgeInsets.only(left: 50.0, right: 50.0, bottom: 20.0),
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone),
                      border: OutlineInputBorder(),
                      hintText: 'Phone number'),
                  keyboardType: TextInputType.number,
                )),
            Container(
                margin: EdgeInsets.only(left: 50.0, right: 50.0, bottom: 20.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.password),
                      border: OutlineInputBorder(),
                      hintText: 'Enter password'),
                )),
            Container(
                // padding: const EdgeInsets.all(20.0),
                margin: EdgeInsets.only(left: 50.0, right: 50.0, bottom: 20.0),
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.password),
                      border: OutlineInputBorder(),
                      hintText: 'Retype your password'),
                )),
            TextButton(
                style: raisedButtonStyle,
                child: Text("Register"),
                onPressed: () {})
          ]),
        ));
  }
}
//## STYLES ##

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Colors.white,
  primary: Colors.blue,
  minimumSize: Size(90, 50),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
);
