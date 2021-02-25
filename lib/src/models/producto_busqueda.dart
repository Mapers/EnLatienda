import 'dart:convert';

List<ProductoBusqueda> productoBusquedaFromJson(String str) => List<ProductoBusqueda>.from(json.decode(str).map((x) => ProductoBusqueda.fromJson(x)));

String productoBusquedaToJson(List<ProductoBusqueda> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductoBusqueda {
    ProductoBusqueda({
        this.codProd,
        this.nomProd,
        this.cantUnidad,
        this.descUnidad,
        this.precUnidad,
        this.rucEmp,
        this.images,
    });

    int codProd;
    String nomProd;
    String cantUnidad;
    String descUnidad;
    String precUnidad;
    String rucEmp;
    List<Image> images;

    factory ProductoBusqueda.fromJson(Map<String, dynamic> json) => ProductoBusqueda(
        codProd: json["codProd"],
        nomProd: json["nomProd"],
        cantUnidad: json["cantUnidad"],
        descUnidad: json["descUnidad"],
        precUnidad: json["precUnidad"],
        rucEmp: json["rucEmp"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "codProd": codProd,
        "nomProd": nomProd,
        "cantUnidad": cantUnidad,
        "descUnidad": descUnidad,
        "precUnidad": precUnidad,
        "rucEmp": rucEmp,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
    };
}

class Image {
    Image({
        this.orden,
        this.url,
    });

    String orden;
    String url;

    factory Image.fromJson(Map<String, dynamic> json) => Image(
        orden: json["orden"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "orden": orden,
        "url": url,
    };
}
