import 'package:sqflite/sqflite.dart';

initDB() async {
  var db = await openDatabase('my_db.db');
}
