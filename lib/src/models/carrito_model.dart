import 'dart:convert';

List<Carrito> carritoFromJson(String str) => List<Carrito>.from(json.decode(str).map((x) => Carrito.fromJson(x)));

String carritoToJson(List<Carrito> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Carrito {
    Carrito({
        this.codCart,
        this.codProd,
        this.imgProd,
        this.nomProd,
        this.cantProd,
        this.codUniPrec,
        this.descUniProd,
        this.valPrecUni,
        this.codEmp,
        this.razonSocial,
        this.rucEmp,
    });

    String codCart;
    String codProd;
    String imgProd;
    String nomProd;
    String cantProd;
    String codUniPrec;
    String descUniProd;
    String valPrecUni;
    String codEmp;
    String razonSocial;
    String rucEmp;

    factory Carrito.fromJson(Map<String, dynamic> json) => Carrito(
        codCart: json["codCart"],
        codProd: json["codProd"],
        imgProd: json["imgProd"],
        nomProd: json["nomProd"],
        cantProd: json["cantProd"],
        codUniPrec: json["codUniPrec"],
        descUniProd: json["descUniProd"],
        valPrecUni: json["valPrecUni"],
        codEmp: json["codEmp"],
        razonSocial: json["razonSocial"],
        rucEmp: json["rucEmp"],
    );

    Map<String, dynamic> toJson() => {
        "codCart": codCart,
        "codProd": codProd,
        "imgProd": imgProd,
        "nomProd": nomProd,
        "cantProd": cantProd,
        "codUniPrec": codUniPrec,
        "descUniProd": descUniProd,
        "valPrecUni": valPrecUni,
        "codEmp": codEmp,
        "razonSocial": razonSocial,
        "rucEmp": rucEmp,
    };
}
