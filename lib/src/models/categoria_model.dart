import 'dart:convert';

List<Categoria> categoriaFromJson(String str) => List<Categoria>.from(json.decode(str).map((x) => Categoria.fromJson(x)));

String categoriaToJson(List<Categoria> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categoria {
    Categoria({
        this.codCat,
        this.codEmp,
        this.imgCat,
        this.nomCat,
        this.cantArt,
        this.estCat,
        this.indAccesoDirecto,
        this.icon,
    });

    int codCat;
    int codEmp;
    dynamic imgCat;
    String nomCat;
    dynamic cantArt;
    String estCat;
    String indAccesoDirecto;
    dynamic icon;

    factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
        codCat: json["codCat"],
        codEmp: json["codEmp"],
        imgCat: json["imgCat"],
        nomCat: json["nomCat"],
        cantArt: json["cantArt"],
        estCat: json["estCat"],
        indAccesoDirecto: json["indAccesoDirecto"],
        icon: json["icon"],
    );

    Map<String, dynamic> toJson() => {
        "codCat": codCat,
        "codEmp": codEmp,
        "imgCat": imgCat,
        "nomCat": nomCat,
        "cantArt": cantArt,
        "estCat": estCat,
        "indAccesoDirecto": indAccesoDirecto,
        "icon": icon,
    };
}
