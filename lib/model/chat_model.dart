// To parse this JSON data, do
//
//     final chat = chatFromJson(jsonString);

import 'dart:convert';

Chat chatFromJson(String str) => Chat.fromJson(json.decode(str));

String chatToJson(Chat data) => json.encode(data.toJson());

class Chat {
    final String? status;
    final String? message;
    final Data? data;

    Chat({
        this.status,
        this.message,
        this.data,
    });

    Chat copyWith({
        String? status,
        String? message,
        Data? data,
    }) => 
        Chat(
            status: status ?? this.status,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory Chat.fromJson(Map<String, dynamic> json) => Chat(
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
    final bool? isGroup;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final List<Participant>? participants;
    final int? totalMessages;
    final int? unreadCount;
    final LastMessage? lastMessage;

    Datum({
        this.id,
        this.isGroup,
        this.createdAt,
        this.updatedAt,
        this.participants,
        this.totalMessages,
        this.unreadCount,
        this.lastMessage,
    });

    Datum copyWith({
        int? id,
        bool? isGroup,
        DateTime? createdAt,
        DateTime? updatedAt,
        List<Participant>? participants,
        int? totalMessages,
        int? unreadCount,
        LastMessage? lastMessage,
    }) => 
        Datum(
            id: id ?? this.id,
            isGroup: isGroup ?? this.isGroup,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            participants: participants ?? this.participants,
            totalMessages: totalMessages ?? this.totalMessages,
            unreadCount: unreadCount ?? this.unreadCount,
            lastMessage: lastMessage ?? this.lastMessage,
        );

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        isGroup: json["isGroup"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        participants: json["participants"] == null ? [] : List<Participant>.from(json["participants"]!.map((x) => Participant.fromJson(x))),
        totalMessages: json["totalMessages"],
        unreadCount: json["unreadCount"],
        lastMessage: json["lastMessage"] == null ? null : LastMessage.fromJson(json["lastMessage"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "isGroup": isGroup,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "participants": participants == null ? [] : List<dynamic>.from(participants!.map((x) => x.toJson())),
        "totalMessages": totalMessages,
        "unreadCount": unreadCount,
        "lastMessage": lastMessage?.toJson(),
    };
}

class LastMessage {
    final int? id;
    final String? content;
    final Participant? sender;
    final DateTime? createdAt;

    LastMessage({
        this.id,
        this.content,
        this.sender,
        this.createdAt,
    });

    LastMessage copyWith({
        int? id,
        String? content,
        Participant? sender,
        DateTime? createdAt,
    }) => 
        LastMessage(
            id: id ?? this.id,
            content: content ?? this.content,
            sender: sender ?? this.sender,
            createdAt: createdAt ?? this.createdAt,
        );

    factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
        id: json["id"],
        content: json["content"],
        sender: json["sender"] == null ? null : Participant.fromJson(json["sender"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "sender": sender?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
    };
}

class Participant {
    final int? id;
    final String? email;
    final String? name;

    Participant({
        this.id,
        this.email,
        this.name,
    });

    Participant copyWith({
        int? id,
        String? email,
        String? name,
    }) => 
        Participant(
            id: id ?? this.id,
            email: email ?? this.email,
            name: name ?? this.name,
        );

    factory Participant.fromJson(Map<String, dynamic> json) => Participant(
        id: json["id"],
        email: json["email"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
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
