import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
    Usuario({
        this.codUsu,
        this.username,
        this.names,
        this.lastnames,
        this.email,
        this.celular,
        this.direccion,
        this.isConfirm,
        this.estado,
        this.token,
        this.created,
        this.expiresAt,
        this.statusCode,
    });

    int codUsu;
    String username;
    String names;
    String lastnames;
    String email;
    String celular;
    String direccion;
    String isConfirm;
    String estado;
    String token;
    String created;
    String expiresAt;
    int statusCode;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        codUsu: json["codUsu"],
        username: json["username"],
        names: json["names"],
        lastnames: json["lastnames"],
        email: json["email"],
        celular: json["celular"],
        direccion: json["direccion"],
        isConfirm: json["isConfirm"],
        estado: json["estado"],
        token: json["token"],
        created: json["created"],
        expiresAt: json["expiresAt"],
        statusCode: json["statusCode"],
    );

    Map<String, dynamic> toJson() => {
        "codUsu": codUsu,
        "username": username,
        "names": names,
        "lastnames": lastnames,
        "email": email,
        "celular": celular,
        "direccion": direccion,
        "isConfirm": isConfirm,
        "estado": estado,
        "token": token,
        "created": created,
        "expiresAt": expiresAt,
        "statusCode": statusCode,
    };
}







UsuarioRegistro usuarioRegistroFromJson(String str) => UsuarioRegistro.fromJson(json.decode(str));

String usuarioRegistroToJson(UsuarioRegistro data) => json.encode(data.toJson());

class UsuarioRegistro {
    UsuarioRegistro({
        this.response,
        this.userId,
        this.names,
        this.lastnames,
        this.email,
        this.password,
        this.isConfirmedEmail,
        this.status,
        this.token,
        this.tokenExpiresAt,
        this.createdAt,
        this.modifiedAt,
    });

    Response response;
    int userId;
    String names;
    String lastnames;
    String email;
    String password;
    String isConfirmedEmail;
    String status;
    String token;
    String tokenExpiresAt;
    String createdAt;
    dynamic modifiedAt;

    factory UsuarioRegistro.fromJson(Map<String, dynamic> json) => UsuarioRegistro(
        response: Response.fromJson(json["response"]),
        userId: json["userId"],
        names: json["names"],
        lastnames: json["lastnames"],
        email: json["email"],
        password: json["password"],
        isConfirmedEmail: json["isConfirmedEmail"],
        status: json["status"],
        token: json["token"],
        tokenExpiresAt: json["tokenExpiresAt"],
        createdAt: json["createdAt"],
        modifiedAt: json["modifiedAt"],
    );

    Map<String, dynamic> toJson() => {
        "response": response.toJson(),
        "userId": userId,
        "names": names,
        "lastnames": lastnames,
        "email": email,
        "password": password,
        "isConfirmedEmail": isConfirmedEmail,
        "status": status,
        "token": token,
        "tokenExpiresAt": tokenExpiresAt,
        "createdAt": createdAt,
        "modifiedAt": modifiedAt,
    };
}

class Response {
    Response({
        this.statusCode,
        this.isSuccess,
        this.details,
    });

    int statusCode;
    bool isSuccess;
    String details;

    factory Response.fromJson(Map<String, dynamic> json) => Response(
        statusCode: json["statusCode"],
        isSuccess: json["isSuccess"],
        details: json["details"],
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "isSuccess": isSuccess,
        "details": details,
    };
}


