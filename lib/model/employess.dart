// To parse this JSON data, do
//
//     final employess = employessFromJson(jsonString);

import 'dart:convert';

Employess employessFromJson(String str) => Employess.fromJson(json.decode(str));

String employessToJson(Employess data) => json.encode(data.toJson());

class Employess {
  Employess({
    this.message,
    this.error,
    this.code,
    this.data,
  });

  String message;
  bool error;
  int code;
  List<Datum> data;

  factory Employess.fromJson(Map<String, dynamic> json) => Employess(
    message: json["message"],
    error: json["error"],
    code: json["code"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "error": error,
    "code": code,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.employeeId,
    this.firstName,
    this.lastName,
    this.companyId,
    this.companyLocationId,
    this.departmentId,
    this.designationId,
    this.dateOfBirth,
    this.gender,
    this.contactNumber,
    this.officeShiftId,
    this.reportTo,
    this.leaveId,
    this.address,
    this.email,
    this.username,
    this.password,
    this.pin,
    this.roleId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.isActiveAccount,
    this.hasMobileAccess,
  });

  int id;
  String employeeId;
  String firstName;
  String lastName;
  dynamic companyId;
  int companyLocationId;
  dynamic departmentId;
  int designationId;
  DateTime dateOfBirth;
  String gender;
  String contactNumber;
  dynamic officeShiftId;
  int reportTo;
  int leaveId;
  String address;
  String email;
  String username;
  String password;
  String pin;
  int roleId;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  int isActive;
  int isActiveAccount;
  int hasMobileAccess;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    employeeId: json["employee_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    companyId: json["company_id"],
    companyLocationId: json["company_location_id"],
    departmentId: json["department_id"],
    designationId: json["designation_id"],
    dateOfBirth: DateTime.parse(json["date_of_birth"]),
    gender: json["gender"],
    contactNumber: json["contact_number"],
    officeShiftId: json["office_shift_id"],
    reportTo: json["report_to"],
    leaveId: json["leave_id"],
    address: json["address"],
    email: json["email"],
    username: json["username"],
    password: json["password"],
    pin: json["pin"],
    roleId: json["role_id"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    isActive: json["is_active"],
    isActiveAccount: json["is_active_account"],
    hasMobileAccess: json["has_mobile_access"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employee_id": employeeId,
    "first_name": firstName,
    "last_name": lastName,
    "company_id": companyId,
    "company_location_id": companyLocationId,
    "department_id": departmentId,
    "designation_id": designationId,
    "date_of_birth": "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "contact_number": contactNumber,
    "office_shift_id": officeShiftId,
    "report_to": reportTo,
    "leave_id": leaveId,
    "address": address,
    "email": email,
    "username": username,
    "password": password,
    "pin": pin,
    "role_id": roleId,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "is_active": isActive,
    "is_active_account": isActiveAccount,
    "has_mobile_access": hasMobileAccess,
  };
}
