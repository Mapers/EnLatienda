import 'dart:convert';

List<Empresa> empresaFromJson(String str) => List<Empresa>.from(json.decode(str).map((x) => Empresa.fromJson(x)));

String empresaToJson(List<Empresa> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Empresa {
    Empresa({
        this.codEmp,
        this.rucEmp,
        this.razonSocial,
        this.direcEmp,
        this.emailContact,
        this.logoEmp,
        this.colorPage,
        this.showInfo,
        this.showMessage,
        this.showCarousel,
        this.estEmp,
        this.costDelivery,
        this.coverEmp,
    });

    int codEmp;
    String rucEmp;
    String razonSocial;
    String direcEmp;
    String emailContact;
    String logoEmp;
    dynamic colorPage;
    String showInfo;
    String showMessage;
    String showCarousel;
    String estEmp;
    dynamic costDelivery;
    dynamic coverEmp;

    factory Empresa.fromJson(Map<String, dynamic> json) => Empresa(
        codEmp: json["codEmp"],
        rucEmp: json["rucEmp"] == null ? null : json["rucEmp"],
        razonSocial: json["razonSocial"] == null ? null : json["razonSocial"],
        direcEmp: json["direcEmp"],
        emailContact: json["emailContact"] == null ? null : json["emailContact"],
        logoEmp: json["logoEmp"] == null ? null : json["logoEmp"],
        colorPage: json["colorPage"],
        showInfo: json["showInfo"] == null ? null : json["showInfo"],
        showMessage: json["showMessage"] == null ? null : json["showMessage"],
        showCarousel: json["showCarousel"],
        estEmp: json["estEmp"],
        costDelivery: json["costDelivery"],
        coverEmp: json["coverEmp"],
    );

    Map<String, dynamic> toJson() => {
        "codEmp": codEmp,
        "rucEmp": rucEmp == null ? null : rucEmp,
        "razonSocial": razonSocial == null ? null : razonSocial,
        "direcEmp": direcEmp,
        "emailContact": emailContact == null ? null : emailContact,
        "logoEmp": logoEmp == null ? null : logoEmp,
        "colorPage": colorPage,
        "showInfo": showInfo == null ? null : showInfo,
        "showMessage": showMessage == null ? null : showMessage,
        "showCarousel": showCarousel,
        "estEmp": estEmp,
        "costDelivery": costDelivery,
        "coverEmp": coverEmp,
    };
}
