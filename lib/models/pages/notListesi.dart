import 'package:flutter/material.dart';

class NotListesi extends StatefulWidget {
  final Widget child;

  NotListesi({Key key, this.child}) : super(key: key);

  _NotListesiState createState() => _NotListesiState();
}

class _NotListesiState extends State<NotListesi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Not Sepeti'))),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            tooltip: 'Kategori Ekle',
            onPressed: () {
              showDialog(
                barrierDismissible: false, //sadece butona basinca cikabilsin
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      title: Text(
                        'Kategori Ekle',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      children: <Widget>[
                        Form(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Kategori Adı',
                                border: OutlineInputBorder(),
                              ),
                              validator: (girilenKategoriAdi) {
                                if (girilenKategoriAdi.length < 3) {
                                  return 'En az 3 karakter giriniz';
                                }
                              },
                            ),
                          ),
                        ),
                        ButtonBar(
                          children: <Widget>[
                            RaisedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              color: Colors.orangeAccent,
                              child: Text(
                                'Vazgeç',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            RaisedButton(
                              onPressed: () {},
                              color: Colors.redAccent,
                              child: Text(
                                'Kaydet',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  });
            },
            child: Icon(Icons.category),
            mini: true,
          ),
          FloatingActionButton(
            tooltip: 'Not Ekle',
            onPressed: () {},
            child: Icon(Icons.add),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
