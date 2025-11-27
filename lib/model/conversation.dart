// To parse this JSON data, do
//
//     final conversation = conversationFromJson(jsonString);

import 'dart:convert';

Conversation conversationFromJson(String str) => Conversation.fromJson(json.decode(str));

String conversationToJson(Conversation data) => json.encode(data.toJson());

class Conversation {
    final String? status;
    final Data? data;

    Conversation({
        this.status,
        this.data,
    });

    Conversation copyWith({
        String? status,
        Data? data,
    }) => 
        Conversation(
            status: status ?? this.status,
            data: data ?? this.data,
        );

    factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
    };
}

class Data {
    final int? conversationId;

    Data({
        this.conversationId,
    });

    Data copyWith({
        int? conversationId,
    }) => 
        Data(
            conversationId: conversationId ?? this.conversationId,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        conversationId: json["conversationId"],
    );

    Map<String, dynamic> toJson() => {
        "conversationId": conversationId,
    };
}
