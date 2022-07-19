import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
                      // print('Helloworld......');
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
                _query(username,password,context);
              },
              child: Text('Login'),
            ),
          )
        ]));
  }
}

class SignupPage extends StatelessWidget {
  gotoHomePage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => myHomePage()));
  }

  final fullnameText = TextEditingController();
  final addressText = TextEditingController();
  final phonenumberText = TextEditingController();
  final passwordText = TextEditingController();
  final c_passwordText = TextEditingController();
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
                controller: fullnameText,
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
                  controller: addressText,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.home),
                      border: OutlineInputBorder(),
                      hintText: 'Address'),
                )),
            Container(
                margin: EdgeInsets.only(left: 50.0, right: 50.0, bottom: 20.0),
                child: TextField(
                  controller: phonenumberText,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone),
                      border: OutlineInputBorder(),
                      hintText: 'Phone number'),
                  keyboardType: TextInputType.number,
                )),
            Container(
                margin: EdgeInsets.only(left: 50.0, right: 50.0, bottom: 20.0),
                child: TextField(
                  controller: passwordText,
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
                  controller: c_passwordText,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.password),
                      border: OutlineInputBorder(),
                      hintText: 'Retype your password'),
                )),
            TextButton(
                style: raisedButtonStyle,
                child: Text("Register"),
                onPressed: () {
                  gotoWelcomePage(BuildContext context) {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => welcomePage()));
                  }
                  if(passwordText.text == c_passwordText.text){
                  initDB(fullnameText.text, addressText.text, passwordText.text,
                      c_passwordText.text);
                  // gotoWelcomePage(build);
                  Navigator.pop(build);
                  Fluttertoast.showToast(msg: "Account created");
                  }else{
                    Fluttertoast.showToast(msg: "Passwords dont match");
                  }
                })
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

initDB(String fullname, String address, String number, String password) async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
    join(await getDatabasesPath(), 'doggie_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE user(fullname TEXT,address TEXT, phonenumber int,password TEXT)',
      );
    },
    version: 1,
  );

  // Define a function that inserts dogs into the database
  Future<void> insertDog(Dog dog) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'user',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Create a Dog and add it to the dogs table
  var fido = Dog(
    fullname: fullname,
    address: address,
    phonenumber: number,
    password: password,
  );

  await insertDog(fido);


}



_query(String username,String password,BuildContext context) async {
  gotoHomePage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => myHomePage()));
  }
  // get a reference to the database
  final database = openDatabase(join(await getDatabasesPath(), 'doggie_database.db'));
  Database db = await database;

  // raw query
  List<Map> result = await db.rawQuery('SELECT * FROM user WHERE fullname=? AND password =?', [username,password]);

  // print the results
  result.isNotEmpty ? result.forEach((row) =>gotoHomePage(context) ) : Fluttertoast.showToast(msg: "Invalid username and password");
  // {_id: 2, name: Mary, age: 32}
}

class Dog {
  final String fullname;
  final String address;
  final String phonenumber;
  final String password;

  const Dog({
    required this.fullname,
    required this.address,
    required this.phonenumber,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullname': fullname,
      'address': address,
      'phonenumber': phonenumber,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'Dog{id: $fullname, name: $address, age: $phonenumber,password : $password}';
  }
}
