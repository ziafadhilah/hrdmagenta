// To parse this JSON data, do
//
//     final loginEmployee = loginEmployeeFromJson(jsonString);

import 'dart:convert';

LoginEmployee loginEmployeeFromJson(String str) => LoginEmployee.fromJson(json.decode(str));

String loginEmployeeToJson(LoginEmployee data) => json.encode(data.toJson());

class LoginEmployee {
  LoginEmployee({
    this.message,
    this.error,
    this.code,
    this.data,
  });

  String message;
  bool error;
  int code;
  Data data;

  factory LoginEmployee.fromJson(Map<String, dynamic> json) => LoginEmployee(
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
    this.designation,
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
  Designation designation;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
    designation: Designation.fromJson(json["designation"]),
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
    "designation": designation.toJson(),
  };
}

class Designation {
  Designation({
    this.id,
    this.name,
    this.departmentId,
    this.description,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.addedBy,
    this.department,
  });

  int id;
  String name;
  int departmentId;
  String description;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  int addedBy;
  Department department;

  factory Designation.fromJson(Map<String, dynamic> json) => Designation(
    id: json["id"],
    name: json["name"],
    departmentId: json["department_id"],
    description: json["description"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    addedBy: json["added_by"],
    department: Department.fromJson(json["department"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "department_id": departmentId,
    "description": description,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "added_by": addedBy,
    "department": department.toJson(),
  };
}

class Department {
  Department({
    this.id,
    this.name,
    this.companyId,
    this.employeeId,
    this.companyLocationId,
    this.addedBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.company,
    this.location,
  });

  int id;
  String name;
  int companyId;
  int employeeId;
  int companyLocationId;
  int addedBy;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  Company company;
  Company location;

  factory Department.fromJson(Map<String, dynamic> json) => Department(
    id: json["id"],
    name: json["name"],
    companyId: json["company_id"],
    employeeId: json["employee_id"],
    companyLocationId: json["company_location_id"],
    addedBy: json["added_by"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    company: Company.fromJson(json["company"]),
    location: Company.fromJson(json["location"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "company_id": companyId,
    "employee_id": employeeId,
    "company_location_id": companyLocationId,
    "added_by": addedBy,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "company": company.toJson(),
    "location": location.toJson(),
  };
}

class Company {
  Company({
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
    this.companyId,
    this.employeeId,
    this.locationName,
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
  int companyId;
  int employeeId;
  String locationName;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    id: json["id"],
    name: json["name"] == null ? null : json["name"],
    registrationNumber: json["registration_number"] == null ? null : json["registration_number"],
    contactNumber: json["contact_number"],
    email: json["email"],
    website: json["website"],
    npwp: json["npwp"],
    address: json["address"],
    province: json["province"],
    city: json["city"],
    zipCode: json["zip_code"],
    country: json["country"],
    logo: json["logo"] == null ? null : json["logo"],
    addedBy: json["added_by"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    companyId: json["company_id"] == null ? null : json["company_id"],
    employeeId: json["employee_id"] == null ? null : json["employee_id"],
    locationName: json["location_name"] == null ? null : json["location_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name == null ? null : name,
    "registration_number": registrationNumber == null ? null : registrationNumber,
    "contact_number": contactNumber,
    "email": email,
    "website": website,
    "npwp": npwp,
    "address": address,
    "province": province,
    "city": city,
    "zip_code": zipCode,
    "country": country,
    "logo": logo == null ? null : logo,
    "added_by": addedBy,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "company_id": companyId == null ? null : companyId,
    "employee_id": employeeId == null ? null : employeeId,
    "location_name": locationName == null ? null : locationName,
  };
}