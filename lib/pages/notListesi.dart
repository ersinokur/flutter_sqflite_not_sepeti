import 'package:flutter/material.dart';
import 'package:flutter_note_sepeti/models/kategori.dart';
import 'package:flutter_note_sepeti/pages/kategoiIslemleri.dart';
import 'package:flutter_note_sepeti/pages/notDetay.dart';
import 'package:flutter_note_sepeti/pages/notlar.dart';
import 'package:flutter_note_sepeti/utils/databaseHelper.dart';

class NotListesi extends StatelessWidget {
  DatabaseHelper databaseHelper = DatabaseHelper();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        title: Text("Not Sepeti",
            style:
                TextStyle(fontFamily: "Raleway", fontWeight: FontWeight.w700)),
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.import_contacts, color: Colors.orange),
                    title: (Text(
                      "Kategoriler",
                      style: TextStyle(
                          color: Colors.blueGrey, fontWeight: FontWeight.w700),
                    )),
                    onTap: () {
                      Navigator.pop(context);
                      _kategorilerSayfasinaGit(context);
                    },
                  ),
                )
              ];
            },
          )
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              kategoriEkleDialog(context);
            },
            heroTag: "Kategori Ekle",
            tooltip: "Kategori Ekle",
            child: Icon(
              Icons.import_contacts,
              color: Colors.white,
            ),
            mini: true,
          ),
          FloatingActionButton(
              tooltip: "Not Ekle",
              heroTag: "Not Ekle",
              onPressed: () => _detaySayfasinaGit(context),
              child: Icon(Icons.add, color: Colors.white))
        ],
      ),
      body: Notlar(),
    );
  }

  void _kategorilerSayfasinaGit(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Kategoriler()));
  }

  void kategoriEkleDialog(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    String yeniKategoriAdi;

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text(
              "Kategori Ekle",
              style: TextStyle(
                  fontFamily: "Raleway",
                  fontWeight: FontWeight.w700,
                  color: Colors.blueGrey),
            ),
            children: <Widget>[
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onSaved: (yeniDeger) {
                      yeniKategoriAdi = yeniDeger;
                    },
                    decoration: InputDecoration(
                      labelText: "Kategori Adı",
                      border: OutlineInputBorder(),
                    ),
                    validator: (girilenKategoriAdi) {
                      if (girilenKategoriAdi.length < 3) {
                        return "En az 3 karekter giriniz";
                      }
                    },
                  ),
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  OutlineButton(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.orangeAccent,
                    child: Text(
                      "Vazgeç",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  OutlineButton(
                    borderSide:
                        BorderSide(color: Theme.of(context).accentColor),
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();
                        databaseHelper
                            .kategoriEkle(Kategori(yeniKategoriAdi))
                            .then((kategoriId) {
                          if (kategoriId > 0) {
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text("Kategori Eklendi"),
                              duration: Duration(seconds: 2),
                            ));
                            Navigator.pop(context);
                          }
                        });
                      }
                    },
                    color: Colors.redAccent,
                    child: Text("Kaydet",
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w700)),
                  )
                ],
              )
            ],
          );
        });
  }

  _detaySayfasinaGit(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NotDetay(
                  baslik: "Yeni Not",
                )));
  }
}
