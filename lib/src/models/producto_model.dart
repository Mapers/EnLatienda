import 'dart:convert';

List<Producto> productoFromJson(String str) => List<Producto>.from(json.decode(str).map((x) => Producto.fromJson(x)));

String productoToJson(List<Producto> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Producto {
    Producto({
        this.codProd,
        this.nomProd,
        this.cantUnidad,
        this.descUnidad,
        this.precUnidad,
        this.rucEmp,
        this.codUniPrec,
        this.codEmp,
        this.images,
    });

    int codProd;
    String nomProd;
    String cantUnidad;
    String descUnidad;
    String precUnidad;
    String rucEmp;
    String codUniPrec;
    String codEmp;
    List<Images> images;

    factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        codProd: json["codProd"],
        nomProd: json["nomProd"],
        cantUnidad: json["cantUnidad"],
        descUnidad: json["descUnidad"],
        precUnidad: json["precUnidad"],
        rucEmp: json["rucEmp"],
        codUniPrec: json["codUniPrec"]??'',
        codEmp: json["codEmp"]??'',
        images: List<Images>.from(json["images"].map((x) => Images.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "codProd": codProd,
        "nomProd": nomProd,
        "cantUnidad": cantUnidad,
        "descUnidad": descUnidad,
        "precUnidad": precUnidad,
        "rucEmp": rucEmp,
        "codUniPrec": codUniPrec,
        "codEmp": codEmp,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
    };
}

class Images {
    Images({
        this.orden,
        this.url,
    });

    String orden;
    String url;

    factory Images.fromJson(Map<String, dynamic> json) => Images(
        orden: json["orden"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "orden": orden,
        "url": url,
    };
}
