import 'dart:convert';

List<CategoriaSubCategoria> categoriaSubCategoriaFromJson(String str) => List<CategoriaSubCategoria>.from(json.decode(str).map((x) => CategoriaSubCategoria.fromJson(x)));

String categoriaSubCategoriaToJson(List<CategoriaSubCategoria> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoriaSubCategoria {
    CategoriaSubCategoria({
        this.codCtg,
        this.nomCtg,
        this.subCtgsLvl1,
    });

    int codCtg;
    String nomCtg;
    List<SubCtgsLvl1> subCtgsLvl1;

    factory CategoriaSubCategoria.fromJson(Map<String, dynamic> json) => CategoriaSubCategoria(
        codCtg: json["codCtg"],
        nomCtg: json["nomCtg"],
        subCtgsLvl1: List<SubCtgsLvl1>.from(json["subCtgsLvl1"].map((x) => SubCtgsLvl1.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "codCtg": codCtg,
        "nomCtg": nomCtg,
        "subCtgsLvl1": List<dynamic>.from(subCtgsLvl1.map((x) => x.toJson())),
    };
}

class SubCtgsLvl1 {
    SubCtgsLvl1({
        this.codSubctg,
        this.nomSubctg,
        this.subCtgsLvl2,
    });

    int codSubctg;
    String nomSubctg;
    List<SubCtgsLvl2> subCtgsLvl2;

    factory SubCtgsLvl1.fromJson(Map<String, dynamic> json) => SubCtgsLvl1(
        codSubctg: json["codSubctg"],
        nomSubctg: json["nomSubctg"],
        subCtgsLvl2: List<SubCtgsLvl2>.from(json["subCtgsLvl2"].map((x) => SubCtgsLvl2.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "codSubctg": codSubctg,
        "nomSubctg": nomSubctg,
        "subCtgsLvl2": List<dynamic>.from(subCtgsLvl2.map((x) => x.toJson())),
    };
}

class SubCtgsLvl2 {
    SubCtgsLvl2({
        this.codSubctg,
        this.nomSubctg,
    });

    int codSubctg;
    String nomSubctg;

    factory SubCtgsLvl2.fromJson(Map<String, dynamic> json) => SubCtgsLvl2(
        codSubctg: json["codSubctg"],
        nomSubctg: json["nomSubctg"],
    );

    Map<String, dynamic> toJson() => {
        "codSubctg": codSubctg,
        "nomSubctg": nomSubctg,
    };
}
