
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_note_sepeti/models/notlar.dart';
import 'package:flutter_note_sepeti/pages/notDetay.dart';
import 'package:flutter_note_sepeti/utils/databaseHelper.dart';

class Notlar extends StatefulWidget {
  @override
  _NotlarState createState() => _NotlarState();
}

class _NotlarState extends State<Notlar> {
  List<Not> tumNotlar;
  DatabaseHelper databaseHelper;
  

  @override
  void initState() {
    super.initState();
    tumNotlar = List<Not>();
    databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyleBaslik = Theme.of(context).textTheme.body1.copyWith(
        fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Raleway');

    return FutureBuilder(
      future: databaseHelper.notListesiniGetir(),
      builder: (context, AsyncSnapshot<List<Not>> snapShot) {
        if (snapShot.connectionState == ConnectionState.done) {
          tumNotlar = snapShot.data;
          sleep(Duration(milliseconds: 500));
          return ListView.builder(
              itemCount: tumNotlar.length,
              itemBuilder: (context, index) {
                return ExpansionTile(
                  leading: _oncelikIconuAta(tumNotlar[index].notoncelik),
                  title: Text(
                    tumNotlar[index].notBaslik,
                    style: textStyleBaslik,
                  ),
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Kategori",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  tumNotlar[index].kategoriBaslik,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      color: Theme.of(context).accentColor),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Oluşturulma Tarihi",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  databaseHelper.dateFormat(DateTime.parse(
                                      tumNotlar[index].tarih)),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      color: Theme.of(context).accentColor),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "İçerik",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 14),
                                child: Text(
                                  tumNotlar[index].notIcerik,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      color: Colors.blueGrey),
                                ),
                              ),
                            ],
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              OutlineButton(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                  onPressed: () =>
                                      _notSil(tumNotlar[index].notID),
                                  child: Text(
                                    "SİL",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  )),
                              OutlineButton(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).accentColor),
                                  onPressed: () {
                                    _detaySayfasinaGit(
                                        context, tumNotlar[index]);
                                  },
                                  child: Text(
                                    "GÜNCELLE",
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              });
        } else {
          return Center(child: Text("Yükleniyor..."));
        }
      },
    );
  }

  _detaySayfasinaGit(BuildContext context, Not not) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NotDetay(
                  baslik: "Notu Düzenle",
                  duzenlenecekNot: not,
                )));
  }

  _oncelikIconuAta(int notOncelik) {
    switch (notOncelik) {
      case 0:
        return CircleAvatar(
            radius: 26,
            child: Text(
              "AZ",
              style: TextStyle(
                  color: Colors.deepOrange.shade200,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.blueGrey.shade200);
        break;
      case 1:
        return CircleAvatar(
            radius: 26,
            child: Text(
              "ORTA",
              style: TextStyle(
                  color: Colors.deepOrange.shade400,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.blueGrey.shade200);
      case 2:
        return CircleAvatar(
            radius: 26,
            child: Text(
              "ACIL",
              style: TextStyle(
                  color: Colors.deepOrange.shade700,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.blueGrey.shade200);
        break;
    }
  }

  _notSil(int notID) {
    databaseHelper.notSil(notID).then((silinenID) {
      if (silinenID != 0) {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text("Not Silindi")));

        setState(() {});
      }
    });
  }
}
