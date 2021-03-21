// To parse this JSON data, do
//
//     final companies = companiesFromJson(jsonString);

import 'dart:convert';

Companies companiesFromJson(String str) => Companies.fromJson(json.decode(str));

String companiesToJson(Companies data) => json.encode(data.toJson());

class Companies {
  Companies({
    this.message,
    this.error,
    this.code,
    this.data,
  });

  String message;
  bool error;
  int code;
  Data data;

  factory Companies.fromJson(Map<String, dynamic> json) => Companies(
    message: json["message"],
    error: json["error"],
    code: json["code"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "error": error,
    "code": code,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.name,
    this.registrationNumber,
    this.contactNumber,
    this.email,
    this.website,
    this.npwp,
    this.address,
    this.province,
    this.city,
    this.zipCode,
    this.country,
    this.logo,
    this.addedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String registrationNumber;
  String contactNumber;
  String email;
  dynamic website;
  String npwp;
  String address;
  String province;
  String city;
  String zipCode;
  String country;
  String logo;
  int addedBy;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    registrationNumber: json["registration_number"],
    contactNumber: json["contact_number"],
    email: json["email"],
    website: json["website"],
    npwp: json["npwp"],
    address: json["address"],
    province: json["province"],
    city: json["city"],
    zipCode: json["zip_code"],
    country: json["country"],
    logo: json["logo"],
    addedBy: json["added_by"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "registration_number": registrationNumber,
    "contact_number": contactNumber,
    "email": email,
    "website": website,
    "npwp": npwp,
    "address": address,
    "province": province,
    "city": city,
    "zip_code": zipCode,
    "country": country,
    "logo": logo,
    "added_by": addedBy,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
