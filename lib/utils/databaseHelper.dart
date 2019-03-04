import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_note_sepeti/models/kategori.dart';
import 'package:flutter_note_sepeti/models/notlar.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  //db üzerinde tablolarla ilgli islemler yapar
  static Database _database;

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._internal();
      return _databaseHelper;
    } else {
      return _databaseHelper;
    }
  }

  DatabaseHelper._internal();

  Future<Database> _getDatabase() async {
    if (_database == null) {
      _database = await _initializeDatabase();
      return _database;
    } else {
      return _database;
    }
  }

  Future<Database> _initializeDatabase() async {
//assette koydugumuz dbnin bir kopyasini alarak mobile device'in ilgili pathine yerlestir.
    var lock = Lock();
    Database _db;

    if (_db == null) {
      await lock.synchronized(() async {
        if (_db == null) {
          var databasesPath = await getDatabasesPath();
          var path = join(databasesPath, "appDB.db");
          print("OLUSACAK DBNIN PATHI : $path");
          var file = new File(path);
// if(await file.exists())
// {
//   file.delete();
// }
//           // check if file exists
          if (!await file.exists()) {
            // Copy from asset
            ByteData data = await rootBundle.load(join("assets", "notlar.db"));
            List<int> bytes =
                data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
            await new File(path).writeAsBytes(bytes);
          }
          // open the database
          _db = await openDatabase(path);
        }
      });
    }

    return _db;
  }

  Future<List<Map<String, dynamic>>> katergorileriGetir() async {
    var db = await _getDatabase();
    var sonuc = await db.query('kategori');
    //print(sonuc);

    return sonuc;
  }

  Future<int> kategoriEkle(Kategori kategori) async {
    var db = await _getDatabase();
    var sonuc = await db.insert('kategori', kategori.toMap());
    return sonuc;
  }

  Future<int> kategoriGuncelle(Kategori kategori) async {
    var db = await _getDatabase();
    var sonuc = await db.update('kategori', kategori.toMap(),
        where: 'kategoriID= ?', whereArgs: [kategori.kategoriID]);
    return sonuc;
  }

  Future<int> kategoriSil(int kategoriId) async {
    var db = await _getDatabase();
    var sonuc = await db
        .delete('kategori', where: 'kategoriID= ?', whereArgs: [kategoriId]);
    return sonuc;
  }

/////////////////////////
  Future<List<Map<String, dynamic>>> notlariGetir() async {
    var db = await _getDatabase();
    var sonuc = await db.query('not', orderBy: 'notID Desc');
    return sonuc;
  }

  Future<int> notEkle(Note not) async {
    var db = await _getDatabase();
    var sonuc = await db.insert('not', not.toMap());
    return sonuc;
  }

  Future<int> notGuncelle(Note not) async {
    var db = await _getDatabase();
    var sonuc = await db
        .update('not', not.toMap(), where: 'notID= ?', whereArgs: [not.notID]);
    return sonuc;
  }

  Future<int> notSil(int notId) async {
    var db = await _getDatabase();
    var sonuc = await db.delete('not', where: 'notID= ?', whereArgs: [notId]);
    return sonuc;
  }
} //
