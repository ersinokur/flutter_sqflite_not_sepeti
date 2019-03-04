class Note {

int notID;
int kategoriID;
String notBaslik;
String notIcerik;
String tarih;
int notoncelik;

Note(this.kategoriID, this.notBaslik, this.notIcerik, this.tarih, this.notoncelik);

Note.withID(this.notID,this.kategoriID, this.notBaslik, this.notIcerik, this.tarih, this.notoncelik);

Map<String,dynamic> toMap(){

  var map = Map<String,dynamic>();

  map['notID'] =notID;
  map['kategoriID'] =kategoriID;
  map['notBaslik'] =notBaslik;
  map['notoncelik'] =notoncelik;
  map['notIcerik'] =notIcerik;
  map['tarih'] =tarih;

  return map;
}

Note.fromMap(Map<String,dynamic> map) {

this.notID=  map['notID'];
this.kategoriID = map['kategoriID'];
this.notBaslik   = map['notBaslik'];
this.notoncelik = map['notoncelik'];
this.notIcerik = map['notIcerik'];
this.tarih = map['tarih'];

}

@override
  String toString() {
    // TODO: implement toString
    return '{$notID, $kategoriID, $notBaslik}';
  }



}//