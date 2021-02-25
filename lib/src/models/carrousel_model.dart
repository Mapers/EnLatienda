import 'dart:convert';

List<Carrousel> carrouselFromJson(String str) => List<Carrousel>.from(json.decode(str).map((x) => Carrousel.fromJson(x)));

String carrouselToJson(List<Carrousel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Carrousel {
    Carrousel({
        this.codCarItem,
        this.codEmp,
        this.imgCarItem,
        this.titleCarItem,
        this.subtitleCarItem,
        this.descCarItem,
        this.rutaCarItem,
        this.fecIniVig,
        this.fecFinVig,
        this.ordenCarItem,
        this.estCarItem,
    });

    int codCarItem;
    int codEmp;
    String imgCarItem;
    String titleCarItem;
    String subtitleCarItem;
    String descCarItem;
    dynamic rutaCarItem;
    String fecIniVig;
    dynamic fecFinVig;
    int ordenCarItem;
    String estCarItem;

    factory Carrousel.fromJson(Map<String, dynamic> json) => Carrousel(
        codCarItem: json["codCarItem"],
        codEmp: json["codEmp"],
        imgCarItem: json["imgCarItem"],
        titleCarItem: json["titleCarItem"],
        subtitleCarItem: json["subtitleCarItem"],
        descCarItem: json["descCarItem"],
        rutaCarItem: json["rutaCarItem"],
        fecIniVig: json["fecIniVig"],
        fecFinVig: json["fecFinVig"],
        ordenCarItem: json["ordenCarItem"],
        estCarItem: json["estCarItem"],
    );

    Map<String, dynamic> toJson() => {
        "codCarItem": codCarItem,
        "codEmp": codEmp,
        "imgCarItem": imgCarItem,
        "titleCarItem": titleCarItem,
        "subtitleCarItem": subtitleCarItem,
        "descCarItem": descCarItem,
        "rutaCarItem": rutaCarItem,
        "fecIniVig": fecIniVig,
        "fecFinVig": fecFinVig,
        "ordenCarItem": ordenCarItem,
        "estCarItem": estCarItem,
    };
}
