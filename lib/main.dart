import 'package:flutter/material.dart';
import 'package:flutter_note_sepeti/utils/databaseHelper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

var dbHelper = DatabaseHelper();
    dbHelper.katergorileriGetir();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: Text("haloo")
    );
  }
}

