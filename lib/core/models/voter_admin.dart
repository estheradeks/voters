// To parse this JSON data, do
//
//     final voterAdmin = voterAdminFromJson(jsonString);

import 'dart:convert';

VoterAdmin voterAdminFromJson(String str) =>
    VoterAdmin.fromJson(json.decode(str));

String voterAdminToJson(VoterAdmin data) => json.encode(data.toJson());

class VoterAdmin {
  VoterAdmin({
    this.firstName,
    this.lastName,
    this.address,
    this.email,
    this.image,
    this.phoneNumber,
    this.privateKey,
  });

  String firstName;
  String lastName;
  String address;
  String email;
  String image;
  String phoneNumber;
  String privateKey;

  factory VoterAdmin.fromJson(Map<String, dynamic> json) => VoterAdmin(
        firstName: json["first_name"],
        lastName: json["last_name"],
        address: json["address"],
        email: json["email"],
        image: json["image"],
        phoneNumber: json["phone_number"],
        privateKey: json["private_key"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "address": address,
        "email": email,
        "image": image,
        "phone_number": phoneNumber,
        "private_key": privateKey,
      };
}
