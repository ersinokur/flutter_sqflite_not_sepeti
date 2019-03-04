class Kategori {
  //DB deki ile bire bir ayni olavak
  int kategoriID;
  String kategoriBaslik;

  Kategori(
      this.kategoriBaslik); // eklenrken kullan, Id db tarafindan olusturulacak

  Kategori.withID(this.kategoriID, this.kategoriBaslik); //db den okurken kullan

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['kategoriID'] = kategoriID;
    map['kategoriBaslik'] = kategoriBaslik;
    return map;
  }

Kategori.fromMap(Map<String,dynamic> map) {

  this.kategoriID =   map['kategoriID'];
  this.kategoriBaslik =    map['kategoriBaslik'] ;
}


@override
  String toString() {
    
    return 'Kategori{KategoriID:$kategoriID, kategoriBaslik: $kategoriBaslik}';
  }

}//
