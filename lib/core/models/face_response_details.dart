// To parse this JSON data, do
//
//     final faceResponseDetails = faceResponseDetailsFromJson(jsonString);

import 'dart:convert';

FaceResponseDetails faceResponseDetailsFromJson(String str) =>
    FaceResponseDetails.fromJson(json.decode(str));

String faceResponseDetailsToJson(FaceResponseDetails data) =>
    json.encode(data.toJson());

class FaceResponseDetails {
  FaceResponseDetails({
    this.statusCode,
    this.statusMessage,
    this.hasError,
    this.data,
  });

  int statusCode;
  String statusMessage;
  bool hasError;
  Data data;

  factory FaceResponseDetails.fromJson(Map<String, dynamic> json) =>
      FaceResponseDetails(
        statusCode: json["statusCode"],
        statusMessage: json["statusMessage"],
        hasError: json["hasError"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "statusMessage": statusMessage,
        "hasError": hasError,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.resultIndex,
    this.resultMessage,
    this.similarPercent,
  });

  int resultIndex;
  String resultMessage;
  int similarPercent;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        resultIndex: json["resultIndex"],
        resultMessage: json["resultMessage"],
        similarPercent: json["similarPercent"],
      );

  Map<String, dynamic> toJson() => {
        "resultIndex": resultIndex,
        "resultMessage": resultMessage,
        "similarPercent": similarPercent,
      };
}
