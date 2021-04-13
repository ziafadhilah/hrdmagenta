import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrdmagenta/services/api_clien.dart';
import 'package:hrdmagenta/utalities/color.dart';
import 'package:hrdmagenta/validasi/validator.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void loading(BuildContext context) {
  ProgressDialog progressDialog = ProgressDialog(context);

  progressDialog.style(message: "Loading ...");

  progressDialog.show();
}

void alert_error(BuildContext context, var title, text_button) {
  Alert(
    context: context,
    title: "$title",
    type: AlertType.error,
    buttons: [
      DialogButton(
        child: Text(
          "$text_button",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        color: btnColor2,
        radius: BorderRadius.circular(0.0),
      ),
    ],
  ).show();
}

void alert_success(BuildContext context, var title, text_button) {
  Alert(
    context: context,
    title: "$title",
    type: AlertType.success,
    buttons: [
      DialogButton(
        child: Text(
          "$text_button",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
        color: btnColor2,
        radius: BorderRadius.circular(0.0),
      ),
    ],
  ).show();
}

void alert_success1(BuildContext context, var title, text_button) {
  Alert(
    context: context,
    title: "$title",
    type: AlertType.success,
    buttons: [
      DialogButton(
        child: Text(
          "$text_button",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, "tabmenu_absence_admin");
        },
        color: btnColor2,
        radius: BorderRadius.circular(0.0),
      ),
    ],
  ).show();
}

void alert_info(BuildContext context, var title, text_button) {
  Alert(
    context: context,
    title: "$title",
    type: AlertType.info,
    buttons: [
      DialogButton(
        child: Text(
          "$text_button",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
        color: btnColor2,
        radius: BorderRadius.circular(0.0),
      ),
    ],
  ).show();
}

void alert_approve(BuildContext context, var id_attendance, user_id, status,
    request_status, request_note) {
  Services services = new Services();
  var Cremarks = new TextEditingController();
  Alert(
    context: context,
    type: AlertType.warning,
    title: "Are you sure?",
    desc: "Data will be approved",
    content: Column(
      children: <Widget>[
        TextField(
          controller: Cremarks,
          decoration: InputDecoration(
            labelText: 'Remarks(optional)',
          ),
        ),
      ],
    ),
    buttons: [
      DialogButton(
        child: Text(
          "Cancel",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        color: Colors.grey,
      ),
      DialogButton(
        child: Text(
          "Approve",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          services.approveAbsence(context, id_attendance, user_id, status,
              request_status, Cremarks.text, request_note);
        },
        gradient: LinearGradient(colors: [Colors.green, Colors.green]),
      )
    ],
  ).show();
}

void alert_reject(BuildContext context, var id_attendance, user_id, status,
    request_status, request_note) {
  Services services = new Services();
  var Cremarks = new TextEditingController();
  Alert(
    context: context,
    type: AlertType.warning,
    title: "Are you sure?",
    desc: "Data will be rejected",
    content: Column(
      children: <Widget>[
        TextField(
          controller: Cremarks,
          decoration: InputDecoration(
            labelText: 'Remarks(optional)',
          ),
        ),
      ],
    ),
    buttons: [
      DialogButton(
        child: Text(
          "Cancel",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        color: Colors.grey,
      ),
      DialogButton(
        child: Text(
          "Reject",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          services.approveAbsence(context, id_attendance, user_id, status,
              request_status, Cremarks.text, request_note);
        },
        gradient: LinearGradient(colors: [Colors.red, Colors.red]),
      )
    ],
  ).show();
}

void validation_checkin(
    BuildContext context,
    var photos,
    remark,
    lat,
    long,
    employee_id,
    date,
    time,
    departement_name,
    distance,
    office_latitude,
    office_longitude,
    category) {
  Validasi validator = new Validasi();
  Alert(
    context: context,
    type: AlertType.warning,
    title: "Check In",
    desc: "Are you sure?",
    buttons: [
      DialogButton(
        child: Text(
          "Yes",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => {
          Navigator.pop(context),
          validator.validation_checkin(
              context,
              photos,
              remark,
              lat,
              long,
              employee_id,
              date,
              time,
              departement_name,
              distance,
              office_latitude,
              office_longitude,
              category)
        },
        color: btnColor1,
      ),
      DialogButton(
        child: Text(
          "Cancel",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        color: Colors.black38,
      )
    ],
  ).show();
}

void validation_checkout(
    BuildContext context,
    var photos,
    remark,
    lat,
    long,
    employee_id,
    date,
    time,
    departement_name,
    distance,
    office_latitude,
    office_longitude,
    category) {
  Validasi validator = new Validasi();
  Alert(
    context: context,
    type: AlertType.warning,
    title: "Check Out ",
    desc: "Are you sure ",
    buttons: [
      DialogButton(
        child: Text(
          "Yes",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => {
          Navigator.pop(context),
          validator.validation_checkout(
              context,
              photos,
              remark,
              lat,
              long,
              employee_id,
              date,
              time,
              departement_name,
              distance,
              office_latitude,
              office_longitude,
              category)
        },
        color: btnColor1,
      ),
      DialogButton(
        child: Text(
          "Cancel",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        color: Colors.black38,
      )
    ],
  ).show();
}

void toast_success(message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 4,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}

void toast_error(message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 4,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
