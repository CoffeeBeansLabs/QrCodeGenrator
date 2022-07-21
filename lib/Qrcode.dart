// To parse this JSON data, do
//
//     final qrcode = qrcodeFromJson(jsonString);

import 'dart:convert';


import 'package:json_annotation/json_annotation.dart';
Qrcode qrcodeFromJson(String str) => Qrcode.fromJson(json.decode(str));

String qrcodeToJson(Qrcode data) => json.encode(data.toJson());

@JsonSerializable()
class Qrcode {


  Qrcode({
    required this.uniqueId,
    required this.currentTime,
    required this.expiryTime,
  });

  String uniqueId;
  int currentTime;
  int expiryTime;

  factory Qrcode.fromJson(Map<String, dynamic> json) => Qrcode(
    uniqueId: json["uniqueId"],
    currentTime: json["currentTime"],
    expiryTime: json["expiryTime"],
  );

  Map<String, dynamic> toJson() => {
    "uniqueId": uniqueId,
    "currentTime": currentTime,
    "expiryTime": expiryTime,
  };
}
