// To parse this JSON data, do
//
//     final detalleProducto = detalleProductoFromJson(jsonString);

import 'dart:convert';

DetalleProducto detalleProductoFromJson(String str) => DetalleProducto.fromJson(json.decode(str));

String detalleProductoToJson(DetalleProducto data) => json.encode(data.toJson());

class DetalleProducto {
    DetalleProducto({
        this.codProd,
        this.nomProd,
        this.descProd,
        this.images,
        this.featuredFeatures,
        this.allFeatures,
        this.unitPrices,
    });

    int codProd;
    String nomProd;
    String descProd;
    List<Image> images;
    List<FeaturedFeature> featuredFeatures;
    List<AllFeature> allFeatures;
    List<UnitPrice> unitPrices;

    factory DetalleProducto.fromJson(Map<String, dynamic> json) => DetalleProducto(
        codProd: json["codProd"],
        nomProd: json["nomProd"],
        descProd: json["descProd"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        featuredFeatures: List<FeaturedFeature>.from(json["featuredFeatures"].map((x) => FeaturedFeature.fromJson(x))),
        allFeatures: List<AllFeature>.from(json["allFeatures"].map((x) => AllFeature.fromJson(x))),
        unitPrices: List<UnitPrice>.from(json["unitPrices"].map((x) => UnitPrice.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "codProd": codProd,
        "nomProd": nomProd,
        "descProd": descProd,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "featuredFeatures": List<dynamic>.from(featuredFeatures.map((x) => x.toJson())),
        "allFeatures": List<dynamic>.from(allFeatures.map((x) => x.toJson())),
        "unitPrices": List<dynamic>.from(unitPrices.map((x) => x.toJson())),
    };
}

class AllFeature {
    AllFeature({
        this.cabFeature,
        this.descFeature,
    });

    String cabFeature;
    String descFeature;

    factory AllFeature.fromJson(Map<String, dynamic> json) => AllFeature(
        cabFeature: json["cabFeature"],
        descFeature: json["descFeature"],
    );

    Map<String, dynamic> toJson() => {
        "cabFeature": cabFeature,
        "descFeature": descFeature,
    };
}

class FeaturedFeature {
    FeaturedFeature({
        this.descFeature,
    });

    String descFeature;

    factory FeaturedFeature.fromJson(Map<String, dynamic> json) => FeaturedFeature(
        descFeature: json["descFeature"],
    );

    Map<String, dynamic> toJson() => {
        "descFeature": descFeature,
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

class UnitPrice {
    UnitPrice({
        this.codUniPrice,
        this.stockDisp,
        this.indProdFrac,
        this.cantUnit,
        this.descUnit,
        this.valPrecUnit,
        this.valFracUnit,
    });

    String codUniPrice;
    dynamic stockDisp;
    String indProdFrac;
    String cantUnit;
    String descUnit;
    String valPrecUnit;
    String valFracUnit;

    factory UnitPrice.fromJson(Map<String, dynamic> json) => UnitPrice(
        codUniPrice: json["codUniPrice"],
        stockDisp: json["stockDisp"],
        indProdFrac: json["indProdFrac"],
        cantUnit: json["cantUnit"],
        descUnit: json["descUnit"],
        valPrecUnit: json["valPrecUnit"],
        valFracUnit: json["valFracUnit"],
    );

    Map<String, dynamic> toJson() => {
        "codUniPrice": codUniPrice,
        "stockDisp": stockDisp,
        "indProdFrac": indProdFrac,
        "cantUnit": cantUnit,
        "descUnit": descUnit,
        "valPrecUnit": valPrecUnit,
        "valFracUnit": valFracUnit,
    };
}

