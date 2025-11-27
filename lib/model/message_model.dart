// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
    final String? status;
    final String? message;
    final Data? data;

    Message({
        this.status,
        this.message,
        this.data,
    });

    Message copyWith({
        String? status,
        String? message,
        Data? data,
    }) => 
        Message(
            status: status ?? this.status,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory Message.fromJson(Map<String, dynamic> json) => Message(
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
    final List<Item>? items;
    final dynamic nextCursor;

    Data({
        this.items,
        this.nextCursor,
    });

    Data copyWith({
        List<Item>? items,
        dynamic nextCursor,
    }) => 
        Data(
            items: items ?? this.items,
            nextCursor: nextCursor ?? this.nextCursor,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        nextCursor: json["nextCursor"],
    );

    Map<String, dynamic> toJson() => {
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
        "nextCursor": nextCursor,
    };
}

class Item {
    final int? id;
    final String? content;
    final DateTime? createdAt;
    final Sender? sender;
    final List<ReadBy>? readBy;
    final bool? isReadByMe;

    Item({
        this.id,
        this.content,
        this.createdAt,
        this.sender,
        this.readBy,
        this.isReadByMe,
    });

    Item copyWith({
        int? id,
        String? content,
        DateTime? createdAt,
        Sender? sender,
        List<ReadBy>? readBy,
        bool? isReadByMe,
    }) => 
        Item(
            id: id ?? this.id,
            content: content ?? this.content,
            createdAt: createdAt ?? this.createdAt,
            sender: sender ?? this.sender,
            readBy: readBy ?? this.readBy,
            isReadByMe: isReadByMe ?? this.isReadByMe,
        );

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        content: json["content"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
        readBy: json["readBy"] == null ? [] : List<ReadBy>.from(json["readBy"]!.map((x) => ReadBy.fromJson(x))),
        isReadByMe: json["isReadByMe"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "createdAt": createdAt?.toIso8601String(),
        "sender": sender?.toJson(),
        "readBy": readBy == null ? [] : List<dynamic>.from(readBy!.map((x) => x.toJson())),
        "isReadByMe": isReadByMe,
    };
}

class ReadBy {
    final int? userId;
    final DateTime? readAt;

    ReadBy({
        this.userId,
        this.readAt,
    });

    ReadBy copyWith({
        int? userId,
        DateTime? readAt,
    }) => 
        ReadBy(
            userId: userId ?? this.userId,
            readAt: readAt ?? this.readAt,
        );

    factory ReadBy.fromJson(Map<String, dynamic> json) => ReadBy(
        userId: json["userId"],
        readAt: json["readAt"] == null ? null : DateTime.parse(json["readAt"]),
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "readAt": readAt?.toIso8601String(),
    };
}

class Sender {
    final int? id;
    final String? email;
    final String? name;

    Sender({
        this.id,
        this.email,
        this.name,
    });

    Sender copyWith({
        int? id,
        String? email,
        String? name,
    }) => 
        Sender(
            id: id ?? this.id,
            email: email ?? this.email,
            name: name ?? this.name,
        );

    factory Sender.fromJson(Map<String, dynamic> json) => Sender(
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
