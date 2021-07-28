import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrdmagenta/model/companies.dart';
import 'package:hrdmagenta/page/employee/budget/budget_project.dart';

import 'package:hrdmagenta/page/employee/pyslip/tabmenu.dart';
import 'package:hrdmagenta/shared_preferenced/sessionmanage.dart';
import 'package:hrdmagenta/utalities/alert_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
String base_url = "http://hrd.magentamediatama.net";
String image_ur = "https://arenzha.s3.ap-southeast-1.amazonaws.com";
String baset_url_event="http://192.168.1.104:3000";


class Services {
  SharedPreference sharedPreference = new SharedPreference();
  budgetproject budget = new budgetproject();
  //function employeeee
  ///login employee
  Future<void> loginEmployee(
      BuildContext context, var username, var password) async {
    loading(context);
    try {
      String fcm_registration_token = await FirebaseMessaging().getToken();
      final response =
          await http.post("$base_url/api/login/mobile/employee", body: {
        "username": username.toString().trim(),
        "password": password,
        "fcm_registration_token": fcm_registration_token
      });

      //
      final data = jsonDecode(response.body);
      if (data['code'] == 200) {
        sharedPreference.saveDataEmployee(
            1,
            data['data']['id'].toString(),
            data['data']['employee_id'],
            data['data']['username'],
            data['data']['first_name'],
            data['data']['last_name'],
            data['data']['email'],
            "",
            data['data']['contact_number'],
            data['data']['work_placement'],
            data['data']['work_placement'],
            "",
            "",
            data['data']['gender']);
        Navigator.pop(context);
        Navigator.pushNamedAndRemoveUntil(
            context, "navbar_employee-page", (route) => false);
      } else {
        Navigator.pop(context);
        alert_error(context, "${data['message']}", "Close");
      }
    } on Exception catch (_) {
      alert_error(context, "Terjadi kesalahan", "Close");
    }
  }

  ///expense budget employee
  Future<void> expenseBudget(BuildContext context, var amount, date, note,
      event_id, budget_category_id, requested_by, image,project_number,status) async {
    print(status);
    loading(context);
    try{
      final response = await http.post("$baset_url_event/api/mobile/project/transactions", body: {
        "description": note,
        "amount": amount,
        "account_id": budget_category_id,
        "project_id": event_id,
        "date": date,
        //"file": file.toString().trim(),
        "status": status,
        "project_number":project_number
      });



      final responseJson = jsonDecode(response.body);
      if (responseJson['code'] == 200) {
        toast_success("${responseJson['message']}");
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        toast_error("${responseJson['message']}");
        Navigator.pop(context);
      }

    }catch(e){

      toast_error("${e}");
      print("${e}");

    }

  }

  ///expense budget employee
  Future<void> editTransaction(BuildContext context, var amount, date, note,
      event_id, budget_category_id, requested_by, image,project_number,transaction_id) async {
    loading(context);
    try{
      final response = await http.patch("$baset_url_event/api/mobile/project/transactions/${transaction_id}", body: {
        "description": note,
        "amount": amount,
        "account_id": budget_category_id,
        "project_id": event_id,
        "date": date,
        //"file": file.toString().trim(),
        "status": "approved",
        "project_number":project_number
      });



      final responseJson = jsonDecode(response.body);
      if (responseJson['code'] == 200) {
        toast_success("${responseJson['message']}");
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        toast_error("${responseJson['message']}");
        Navigator.pop(context);
      }

    }catch(e){
      Navigator.pop(context);
      toast_error("${e}");
      print("${e}");

    }

  }



  Future<void> deleteTransactionBudget(BuildContext context, var id,projectNumber) async {
    loading(context);
    try{
      final response = await http.delete("$baset_url_event/api/mobile/project/transactions/${id}/${projectNumber}",);

      final responseJson = jsonDecode(response.body);
      if (responseJson['code'] == 200) {
        toast_success("${responseJson['message']}");
        Navigator.pop(context);
        Navigator.pop(context);

      } else {
        toast_error("${responseJson['message']}");
        Navigator.pop(context);
      }

    }catch(e){
      Navigator.pop(context);
      toast_error("${e}");
      print("${e}");

    }

  }

  ///function checkin employee
  Future<void> checkin(
      BuildContext context,
      var photos,
      var remark,
      var employee_id,
      lat,
      long,
      date,
      time,
      status,
      office_latitude,
      office_longitude,
      category) async {
    loading(context);

    final response =
        await http.post("$base_url/api/attendances/action/check-in", body: {
      "employee_id": employee_id.toString(),
      "date": date.toString(),
      "clock_in": "${date.toString()} ${time.toString()}",
      "image": photos.toString().trim(),
      "note": remark,
      "clock_in_latitude": lat,
      "clock_in_longitude": long,
      "status": "$status",
      "category": "$category",
      "office_latitude": office_latitude,
      "office_longitude": office_longitude,
      "screen": "DetailAttendanceAdmin"
    });

    final responseJson = jsonDecode(response.body);
    if (responseJson['code'] == 200) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      Navigator.pop(context);
      // alert_success(context, "${responseJson['message']}", "Back");
      toast_success("${responseJson['message']}");
      Navigator.pop(context);

    } else {
      Navigator.pop(context);
      alert_info(context, "${responseJson['message']}", "Back");
      print(responseJson);
    }
  }

  ///function checkout employee
  Future<void> checkout(
      BuildContext context,
      var photos,
      var remark,
      var employee_id,
      lat,
      long,
      date,
      time,
      status,
      office_latitude,
      office_longitude,
      category) async {
    loading(context);
    final response =
        await http.post("$base_url/api/attendances/action/check-out", body: {
      "employee_id": employee_id.toString(),
      "date": date.toString(),
      "clock_out": "${date.toString()} ${time.toString()}",
      "image": photos.toString().trim(),
      "note": remark,
      "clock_out_latitude": lat,
      "clock_out_longitude": long,
      "status": "$status",
      "category": "$category",
      "office_latitude": office_latitude,
      "office_longitude": office_longitude,
      "screen": "DetailAttendanceAdmin"
    });


    final responseJson = jsonDecode(response.body);
    if (responseJson['code'] == 200) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      Navigator.pop(context);
      sharedPreferences.setString("clock_out", time.toString());
      sharedPreferences.setBool("check_in", false);
      sharedPreferences.setBool("check_out", true);
      // alert_success(context, "${responseJson['message']}", "Back");
      toast_success("${responseJson['message']}");
      Navigator.pop(context);
    } else {
      Navigator.pop(context);

      alert_info(context, "${responseJson['message']}", "Back");
    }
  }

  ///function change password employee
  Future<void> change_password(
      BuildContext context, var password, username, email, id) async {
    loading(context);
    final response =
        await http.patch("$base_url/api/employees/$id/edit-account", body: {
      "username": username.toString(),
      "email": email.toString(),
      "password": password.toString(),
    });

    final responseJson = jsonDecode(response.body);
    if (responseJson['code'] == 200) {
      Navigator.pop(context);
      toast_success("${responseJson['message']}");
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
      toast_error("${responseJson['message']}");
    }
  }

  ///finihed task
  Future<void> finished_task(BuildContext context, var id) async {
    final response = await http.patch("$baset_url_event/api/projects/task/${id}");
    final responseJson = jsonDecode(response.body);
    if (responseJson['code'] == 200) {
      return "200";
    } else {
      return "400";
    }
  }

  ///function companies
  Future<List<Companies>> companies(BuildContext context, var id) async {
    loading(context);
    final response = await http.get("$base_url/api/employees/1/companies");
    final data = jsonDecode(response.body);
    Toast.show("$data", context);
    if (data['code'] == 200) {
      final List<Companies> company =
          companiesFromJson(response.body) as List<Companies>;

      return company;
    } else {
      Navigator.pop(context);
    }
  }

  Future<void> clearTokenemployee(var id) async {
    final response =
        await http.post("$base_url/api/logout/mobile/employee", body: {
      "employee_id": id,
    });
    final data = jsonDecode(response.body);

    if (data['200']) {
      print("berhasil");
    } else {
      print("gagal");
    }
  }


  //leave
  Future<void> leaveSubmission(BuildContext context,var employee_id,date_of_filing,leaves_dates,description) async{
    loading(context);
    final response =
    await http.post("$base_url/api/leave-submissions", body: {
      "employee_id":employee_id,
      "date_of_filing":date_of_filing.toString(),
      "full_day_leave_dates":leaves_dates.toString(),
      "description":description,

    });

    final responseJson = jsonDecode(response.body);
    if (responseJson['code']==200){
      Toast.show("${responseJson['message']}", context);
      Get.back();
      Get.back();

    }else{
      print(leaves_dates.toString());
      toast_success("${responseJson['message']}");
      Get.back();
      print(responseJson.toString());
      print(date_of_filing.toString());

    }
  }


  Future<void> leaveEdit(BuildContext context,var id,employee_id,date_of_filing,leaves_dates,description) async{
    loading(context);
    final response =
    await http.patch("$base_url/api/leave-submissions/$id", body: {
      "employee_id":employee_id,
      "date_of_filing":date_of_filing.toString(),
      "full_day_leave_dates":leaves_dates.toString(),
      "description":description,
    });

    final responseJson = jsonDecode(response.body);
    if (responseJson['code']==200){
      toast_success("${responseJson['message']}");
      Navigator.pop(context,"update");
      Navigator.pop(context,"update");
    }else{
      print(leaves_dates.toString());
      Toast.show("${responseJson['message']}", context);
      print(responseJson.toString());
      print(date_of_filing.toString());

    }
  }


  Future<void> deleteLeave(BuildContext context,var id) async {
    loading(context);
    final response=await http.delete("${base_url}/api/leave-submissions/$id");
    final responseJson=jsonDecode(response.body);
    if (responseJson['code']==200){
      Get.back();
      toast_success("${responseJson['message']}");
      return responseJson;

    }else{
      Get.back();
      alert_error(context, "${responseJson['message']}", "Close");
      return responseJson;

    }

  }

  Future<void> leaveAproval(BuildContext context,var id,approval) async{
    loading(context);
    final response =
    await http.post("$base_url/api/leave-submissions/action/$approval/$id");

    final responseJson = jsonDecode(response.body);
    if (responseJson['code']==200){
      Get.back();
      toast_success("${responseJson['message']}");

    }else{
      Get.back();
      toast_error("${responseJson['message']}");

    }
  }
  //sick
  Future<void> sickSubmission(BuildContext context,var employee_id,date_of_filing,sick_dates,description) async{
    loading(context);
    final response =
    await http.post("$base_url/api/sick-submissions", body: {
      "employee_id":employee_id,
      "date_of_filing":date_of_filing.toString(),
      "sick_dates":sick_dates.toString(),
      "description":description,
      "status":"pending"
    });

    final responseJson = jsonDecode(response.body);
    if (responseJson['code']==200){
      toast_success("${responseJson['message']}");
      Get.back();
      Get.back();
    }else{
      toast_error("${responseJson['message']}");
      Get.back();
      print(responseJson.toString());
    }
  }

  Future<void> sickEdit(BuildContext context,var id,employee_id,date_of_filing,sick_dates,old_sick_dates,description) async{
    loading(context);
    final response =
    await http.patch("$base_url/api/sick-submissions/$id", body: {
      "employee_id":employee_id,
      "date_of_filing":date_of_filing.toString(),
      "sick_dates":sick_dates.toString(),
      "description":description,
      "old_sick_dates":old_sick_dates,
    });

    final responseJson = jsonDecode(response.body);
    if (responseJson['code']==200){
      toast_success("${responseJson['message']}");
      Get.back();
     Navigator.pop(context,"update");
    }else{
      toast_error("${responseJson['message']}");
      Get.back();
      print(responseJson.toString());
    }
  }

  Future<void> deleteSick(BuildContext context,var id) async {
    loading(context);
    final response=await http.delete("${base_url}/api/sick-submissions/$id");
    final responseJson=jsonDecode(response.body);
    if (responseJson['code']==200){
      Get.back();
      toast_success("${responseJson['message']}");
      return responseJson;
    }else{
      Get.back();
      alert_error(context, "${responseJson['message']}", "Close");
      return responseJson;
    }
  }

  Future<void> sickAproval(BuildContext context,var id,approval) async{
    loading(context);
    final response =
    await http.post("$base_url/api/sick-submissions/action/$approval/$id");

    final responseJson = jsonDecode(response.body);
    if (responseJson['code']==200){
      Get.back();
      toast_success("${responseJson['message']}");

    }else{
      Get.back();
      toast_error("${responseJson['message']}");

    }
  }

  //permission

  Future<void> permissionSubmission(BuildContext context,var employee_id,date_of_filing,permission_dates,number_of_days,permission_category_id,description) async{
    loading(context);
    final response =
    await http.post("$base_url/api/permission-submissions", body: {
      "employee_id":employee_id,
      "date_of_filing":date_of_filing.toString(),
      "permission_dates":permission_dates.toString(),
      "number_of_days":number_of_days,
      "description":description,
      "permission_category_id":permission_category_id

    });

    final responseJson = jsonDecode(response.body);
    if (responseJson['code']==200){
      toast_success("${responseJson['message']}");
      Get.back();
      Get.back();
    }else{
      toast_error("${responseJson['message']}");
      Get.back();
      print(responseJson.toString());
    }
  }
  Future<void> deletePermission(BuildContext context,var id) async {
    loading(context);
    final response=await http.delete("${base_url}/api/permission-submissions/$id");
    final responseJson=jsonDecode(response.body);
    if (responseJson['code']==200){
      Get.back();
      toast_success("${responseJson['message']}");
      return responseJson;

    }else{
      Get.back();
      alert_error(context, "${responseJson['message']}", "Close");
      return responseJson;

    }

  }
  Future<void> permissionAproval(BuildContext context,var id,approval) async{
    loading(context);
    final response =
    await http.post("$base_url/api/permission-submissions/action/$approval/$id");

    final responseJson = jsonDecode(response.body);
    if (responseJson['code']==200){
      Get.back();
      toast_success("${responseJson['message']}");

    }else{
      Get.back();
      toast_error("${responseJson['message']}");

    }
  }

  Future<void> editpermissionSubmission(BuildContext context,var id,employee_id,date_of_filing,
      permission_dates,number_of_days,
      permission_category_id,old_permission_dates,description) async{
    loading(context);
    final response =
    await http.patch("$base_url/api/permission-submissions/$id", body: {
      "employee_id":employee_id,
      "date_of_filing":date_of_filing.toString(),
      "permission_dates":permission_dates.toString(),
      "number_of_days":number_of_days,
      "description":description,
      "permission_category_id":permission_category_id,
      "old_permission_dates":old_permission_dates

    });

    final responseJson = jsonDecode(response.body);
    if (responseJson['code']==200){
      toast_success("${responseJson['message']}");
      Get.back();
     Navigator.pop(context,"update");
    }else{
      toast_error("${responseJson['message']}");
      Get.back();
      print(responseJson.toString());
    }
  }


  //payslip
  Future<void> payslipPermission(BuildContext context,var id) async{
    loading(context);
    final response =
    await http.get("$base_url/api/employees/$id");

    final responseJson = jsonDecode(response.body);
    if (responseJson['code']==200){
      print(responseJson.toString());
      if (responseJson['data']['payslip_permission'].toString()=="1"){
         Get.back();
          Get.to(TabsMenuPayslip());
      }else{
        Get.back();
        alert_error(context, "Anda tidak mempunyai akses", "Close");
      }
    }else{
      Get.back();
      // print(leaves_dates.toString());
      // Toast.show("${responseJson['message']}", context);
      // Get.back();
      // print(responseJson.toString());
      // print(date_of_filing.toString());

    }
  }


  //-----------end fucnction employeee-------

  //fuction admin

  Future<void> loginAdmin(
      BuildContext context, var username, var password) async {
    String fcm_registration_token = await FirebaseMessaging().getToken();
    loading(context);
    final response = await http.post("$base_url/api/login/mobile/admin", body: {
      "username": username.toString().trim(),
      "password": password,
      "fcm_registration_token": fcm_registration_token
    });
    //
    final data = jsonDecode(response.body);
    if (data['code'] == 200) {
      // final loginmodel = loginEmployeeFromJson(response.body);
      sharedPreference.saveDataEmployee(
          2,
          data['data']['id'].toString(),
          data['data']['employee_id'],
          data['data']['username'],
          data['data']['first_name'],
          data['data']['last_name'],
          data['data']['email'],
          "",
          data['data']['contact_number'],
          data['data']['work_placement'],
          data['data']['work_placement'],
          "",
          "",
          data['data']['gender']);
      Navigator.pop(context);
      Navigator.pushNamedAndRemoveUntil(
          context, "navbar_admin-page", (route) => false);
    } else {
      Navigator.pop(context);
      alert_error(context, "${data['message']}", "Close");
    }
  }

  Future<void> approveAbsence(BuildContext context, var id_attendance, user_id,
      status, request_status, note, request_note) async {
    loading(context);
    final response = await http
        .post("$base_url/api/attendances/$id_attendance/$status", body: {
      "$request_status": "${user_id}",
      "${request_note}": "${note}",
      "screen": "DetailAttendanceEmployee",
    });
    //
    final data = jsonDecode(response.body);
    if (data['code'] == 200) {
      Navigator.pop(context);
      Navigator.pop(context);
      alert_success1(context, "${data['message']}", "Back");
    } else {
      Navigator.pop(context);
      alert_error(context, "${data['message']}", "Close");
    }
  }

  Future<void> clearTokenadmin(var id) async {
    final response =
        await http.post("$base_url/api/logout/mobile/admin", body: {
      "employee_id": id,
    });
    final data = jsonDecode(response.body);

    if (data['200']) {
      print("berhasil");
    } else {
      print("gagal");
    }
  }
}
