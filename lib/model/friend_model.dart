// To parse this JSON data, do
//
//     final friend = friendFromJson(jsonString);

import 'dart:convert';

Friend friendFromJson(String str) => Friend.fromJson(json.decode(str));

String friendToJson(Friend data) => json.encode(data.toJson());

class Friend {
    final String? status;
    final String? message;
    final Data? data;

    Friend({
        this.status,
        this.message,
        this.data,
    });

    Friend copyWith({
        String? status,
        String? message,
        Data? data,
    }) => 
        Friend(
            status: status ?? this.status,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory Friend.fromJson(Map<String, dynamic> json) => Friend(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    final List<Datum>? data;
    final Meta? meta;

    Data({
        this.data,
        this.meta,
    });

    Data copyWith({
        List<Datum>? data,
        Meta? meta,
    }) => 
        Data(
            data: data ?? this.data,
            meta: meta ?? this.meta,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "meta": meta?.toJson(),
    };
}

class Datum {
    final int? id;
    final String? email;
    final String? name;
    final DateTime? createdAt;

    Datum({
        this.id,
        this.email,
        this.name,
        this.createdAt,
    });

    Datum copyWith({
        int? id,
        String? email,
        String? name,
        DateTime? createdAt,
    }) => 
        Datum(
            id: id ?? this.id,
            email: email ?? this.email,
            name: name ?? this.name,
            createdAt: createdAt ?? this.createdAt,
        );

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "createdAt": createdAt?.toIso8601String(),
    };
}

class Meta {
    final int? page;
    final int? limit;
    final int? total;
    final int? totalPages;
    final bool? hasNextPage;
    final bool? hasPreviousPage;

    Meta({
        this.page,
        this.limit,
        this.total,
        this.totalPages,
        this.hasNextPage,
        this.hasPreviousPage,
    });

    Meta copyWith({
        int? page,
        int? limit,
        int? total,
        int? totalPages,
        bool? hasNextPage,
        bool? hasPreviousPage,
    }) => 
        Meta(
            page: page ?? this.page,
            limit: limit ?? this.limit,
            total: total ?? this.total,
            totalPages: totalPages ?? this.totalPages,
            hasNextPage: hasNextPage ?? this.hasNextPage,
            hasPreviousPage: hasPreviousPage ?? this.hasPreviousPage,
        );

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        page: json["page"],
        limit: json["limit"],
        total: json["total"],
        totalPages: json["totalPages"],
        hasNextPage: json["hasNextPage"],
        hasPreviousPage: json["hasPreviousPage"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "limit": limit,
        "total": total,
        "totalPages": totalPages,
        "hasNextPage": hasNextPage,
        "hasPreviousPage": hasPreviousPage,
    };
}
