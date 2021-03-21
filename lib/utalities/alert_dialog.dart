import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrdmagenta/utalities/color.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';



void loading(BuildContext context) {

  ProgressDialog progressDialog = ProgressDialog(context);
  progressDialog.style(message: "Loading ...");
  progressDialog.show();

}
void alert_error(BuildContext context,var title,text_button){
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

  )
      .show();
}


void alert_success(BuildContext context,var title,text_button){
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

  )
      .show();
}

void alert_success1(BuildContext context,var title,text_button){
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
        Navigator.pushReplacementNamed(context, "tabmenu_absence_admin");
        },
        color: btnColor2,
        radius: BorderRadius.circular(0.0),
      ),
    ],

  )
      .show();
}

void alert_info(BuildContext context,var title,text_button){
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

  )
      .show();
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