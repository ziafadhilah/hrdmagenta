import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hrdmagenta/model/companies.dart';
import 'package:hrdmagenta/model/login_employee.dart';
import 'package:hrdmagenta/page/employee/budget/budget_project.dart';
import 'package:hrdmagenta/shared_preferenced/sessionmanage.dart';
import 'package:hrdmagenta/utalities/alert_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

String base_url="127.0.0.1:8000";

class Services{
  SharedPreference sharedPreference=new SharedPreference();
  budgetproject budget=new budgetproject();


 //function employeeee
  ///login employee
  Future<void> loginEmployee(BuildContext context, var username, var  password) async {
    loading(context);
    final response = await http.post("http://$base_url/api/login/mobile/employee", body: {
      "username": username.toString().trim(),
      "password": password,
    });

    //
    final data = jsonDecode(response.body);
    if (data['code']==200){
      final loginmodel=loginEmployeeFromJson(response.body);
      sharedPreference.saveDataEmployee(1 ,loginmodel.data.id.toString(), loginmodel.data.employeeId, loginmodel.data.username, loginmodel.data.firstName, loginmodel.data.lastName, loginmodel.data.email, "", loginmodel.data.contactNumber, loginmodel.data.gender);
      Navigator.pop(context);
      Navigator.pushNamedAndRemoveUntil(context, "navbar_employee-page", (route) => false);

    }else{
      Navigator.pop(context);
      alert_error(context, "${data['message']}", "Close");

    }

  }
///project employee
//  Future<List<Project>> dataProject(BuildContext context) async {
//
//
//         final response = await http.get("http://192.168.1.105/magentaeo/api/quotation");
//         if (200==response.statusCode){
//           var projects= projectFromJson(response.body);
//           //return projects;
//            //var responseJson = json.decode(response.body);
//            return compute(projectFromJson,response.body);
//
//         }else{
//           Toast.show("else ", context, duration: 5, gravity: Toast.BOTTOM);
//
//           return List<Project>();
//         }
//
//   }


  ///expense budget employee
  Future<void> expenseBudget(BuildContext context, var amount,date,note,event_id,budget_category_id,requested_by,image) async {
   loading(context);
    final response = await http.post("http://$base_url/api/event-budgets", body: {
      "note": note,
      "amount":amount,
      "type":"expense",
      "budget_category_id":budget_category_id,
      "event_id":event_id,
      "requested_by":requested_by,
      "date":date,
      //"file": file.toString().trim(),
      "status": "pending"
    });

    final responseJson=jsonDecode(response.body);



   if (responseJson['code']==200){

      toast_success("${responseJson['message']}");
      Navigator.pop(context);
      Navigator.pop(context);
    }else{

      toast_error("${responseJson['message']}");
      Navigator.pop(context);


    }


  }
  ///function checkin employee
  Future<void> checkin(BuildContext context, var photos, var  remark,var employee_id,lat,long,date,time) async {
    loading(context);
    final response = await http.post("http://$base_url/api/attendances/action/check-in", body: {
      "employee_id": employee_id.toString(),
      "date":date.toString(),
      "clock_in":"${date.toString()} ${time.toString()}",
      "image": photos.toString().trim(),
      "note":remark,
      "clock_in_latitude": lat,
      "clock_in_longitude": long,
      "status":"pending"

    });

    final responseJson=jsonDecode(response.body);
    if (responseJson['code']==200){
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      Navigator.pop(context);
      sharedPreferences.setString("clock_in", time.toString());
      sharedPreferences.setBool("check_in", true);
      sharedPreferences.setBool("check_out", false);
      // alert_success(context, "${responseJson['message']}", "Back");
      toast_success("${responseJson['message']}");
      Navigator.pop(context);

    }else{
      Navigator.pop(context);
      alert_info(context, "${responseJson['message']}", "Back");


    }

  }
  ///function checkout employee
  Future<void> checkout(BuildContext context, var photos, var  remark,var employee_id,lat,long,date,time) async {
    loading(context);
    final response = await http.post("http://$base_url/api/attendances/action/check-out", body: {
      "employee_id": employee_id.toString(),
      "date":date.toString(),
      "clock_out":"${date.toString()} ${time.toString()}",
      "image": photos.toString().trim(),
      "note":remark,
      "clock_out_latitude": lat,
      "clock_out_longitude": long,
      "status":"pending"

    });



    final responseJson=jsonDecode(response.body);

    if (responseJson['code']==200){
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      Navigator.pop(context);
      sharedPreferences.setString("clock_out", time.toString());
      sharedPreferences.setBool("check_in", false);
      sharedPreferences.setBool("check_out", true);
     // alert_success(context, "${responseJson['message']}", "Back");
      toast_success("${responseJson['message']}");
      Navigator.pop(context);


    }else{
      Navigator.pop(context);

      alert_info(context, "${responseJson['message']}", "Back");


    }

  }

  ///function change password employee
  Future<void> change_password(BuildContext context, var password,username,email,id) async {
    loading(context);
    final response = await http.patch("http://$base_url/api/employees/$id/edit-account", body: {
      "username": username,
      "email":email,
      "password":password,
    });

    final responseJson=jsonDecode(response.body);
    if (responseJson['code']==200){
      Navigator.pop(context);
      toast_success("${responseJson['message']}");
      Navigator.pop(context);
    }else{
      Navigator.pop(context);
      toast_error("${responseJson['message']}");
  
    }

  }
///finihed task
  Future<void> finished_task(BuildContext context, var id) async {
    final response = await http.post("http://$base_url/api/event-tasks/$id/finish");
    final responseJson=jsonDecode(response.body);
    if (responseJson['code']==200){
      return "200";
    }else{
      return "400";


    }


  }

  ///function companies
  Future<List<Companies>> companies(BuildContext context, var id) async {

    loading(context);
    final response=await http.get("http://$base_url/api/employees/1/companies");
    final data=jsonDecode(response.body);
    Toast.show("$data", context);
    if (data['code']==200){
      final List<Companies> company = companiesFromJson(response.body) as List<Companies>;

      return company;
    }else{
      Navigator.pop(context);

    }
  }




  //-----------end fucnction employeee-------

  //fuction admin

  Future<void> loginAdmin(BuildContext context, var username, var  password) async {
    loading(context);
    final response = await http.post("http://$base_url/api/login/mobile/admin", body: {
      "username": username.toString().trim(),
      "password": password,
    });
    //
    final data = jsonDecode(response.body);
    if (data['code']==200){
      final loginmodel=loginEmployeeFromJson(response.body);
      sharedPreference.saveDataEmployee(2 ,loginmodel.data.id.toString(), loginmodel.data.employeeId, loginmodel.data.username, loginmodel.data.firstName, loginmodel.data.lastName, loginmodel.data.email, "", loginmodel.data.contactNumber, loginmodel.data.gender);
      Navigator.pop(context);
      Navigator.pushNamedAndRemoveUntil(context, "navbar_admin-page", (route) => false);

    }else{
      Navigator.pop(context);
      alert_error(context, "${data['message']}", "Close");

    }
  }


  Future<void> approveAbsence(BuildContext context, var id_attendance,user_id, status,request_status,note,request_note) async {
    loading(context);
    final response = await http.post("http://$base_url/api/attendances/$id_attendance/$status", body: {
      "$request_status": "${user_id}",
      "${request_note}": "${note}",
    });
    //
    final data = jsonDecode(response.body);
    if (data['code']==200){
      alert_success1(context, "${data['message']}", "Back");


    }else{
      Navigator.pop(context);
      alert_error(context, "${data['message']}", "Close");


    }
  }
}
