import 'dart:convert';

MensajeInformativo mensajeInformativoFromJson(String str) => MensajeInformativo.fromJson(json.decode(str));

String mensajeInformativoToJson(MensajeInformativo data) => json.encode(data.toJson());

class MensajeInformativo {
    MensajeInformativo({
        this.codMsg,
        this.codEmp,
        this.imgMsg,
        this.descMsg,
        this.estMsg,
    });

    int codMsg;
    int codEmp;
    dynamic imgMsg;
    String descMsg;
    String estMsg;

    factory MensajeInformativo.fromJson(Map<String, dynamic> json) => MensajeInformativo(
        codMsg: json["codMsg"],
        codEmp: json["codEmp"],
        imgMsg: json["imgMsg"],
        descMsg: json["descMsg"],
        estMsg: json["estMsg"],
    );

    Map<String, dynamic> toJson() => {
        "codMsg": codMsg,
        "codEmp": codEmp,
        "imgMsg": imgMsg,
        "descMsg": descMsg,
        "estMsg": estMsg,
    };
}
