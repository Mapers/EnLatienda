// To parse this JSON data, do
//
//     final comentario = comentarioFromJson(jsonString);

import 'dart:convert';

Comentario comentarioFromJson(String str) => Comentario.fromJson(json.decode(str));

String comentarioToJson(Comentario data) => json.encode(data.toJson());

class Comentario {
    Comentario({
        this.response,
        this.comments,
    });

    Response response;
    List<Comment> comments;

    factory Comentario.fromJson(Map<String, dynamic> json) => Comentario(
        response: Response.fromJson(json["response"]),
        comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "response": response.toJson(),
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
    };
}

class Comment {
    Comment({
        this.response,
        this.commentId,
        this.productId,
        this.userId,
        this.description,
        this.rating,
        this.publishedAt,
        this.modifiedAt,
        this.status,
    });

    dynamic response;
    int commentId;
    int productId;
    int userId;
    String description;
    int rating;
    DateTime publishedAt;
    dynamic modifiedAt;
    String status;

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        response: json["response"],
        commentId: json["commentId"],
        productId: json["productId"],
        userId: json["userId"],
        description: json["description"],
        rating: json["rating"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        modifiedAt: json["modifiedAt"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "response": response,
        "commentId": commentId,
        "productId": productId,
        "userId": userId,
        "description": description,
        "rating": rating,
        "publishedAt": publishedAt.toIso8601String(),
        "modifiedAt": modifiedAt,
        "status": status,
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
