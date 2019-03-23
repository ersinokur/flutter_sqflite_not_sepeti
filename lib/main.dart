import 'package:flutter/material.dart';
import 'package:flutter_note_sepeti/pages/notListesi.dart';
import 'package:flutter_note_sepeti/utils/databaseHelper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var dbHelper = DatabaseHelper();
    //  var kategoriler = dbHelper.katergorileriGetir().then((data);

    return MaterialApp(
        title: 'Not Gir',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: NotListesi()
        );
  }
}
