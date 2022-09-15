import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrdmagenta/page/employee/leave/LeaveEdit.dart';
import 'package:hrdmagenta/page/employee/project/shimmer_project.dart';
import 'package:hrdmagenta/page/employee/sick/edit.dart';
import 'package:hrdmagenta/page/employee/sick/tabmenu.dart';
import 'package:hrdmagenta/services/api_clien.dart';
import 'package:hrdmagenta/utalities/color.dart';
import 'package:hrdmagenta/utalities/constants.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ListstatusSickPageEmployee extends StatefulWidget {
  ListstatusSickPageEmployee({this.status});
  var status;
  @override
  _ListstatusSickPageEmployeeState createState() =>
      _ListstatusSickPageEmployeeState();
}

class _ListstatusSickPageEmployeeState
    extends State<ListstatusSickPageEmployee> {
  //variable
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  var user_id;
  var _sick;
  var _visible = false;

  Map _projects;
  bool _loading = true;

  Widget _buildnodata() {
    return Container(
      height: MediaQuery.of(context).size.height - 150,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: no_data_leave,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                child: Text(
              "Belum ada pengajuan sakit",
              style: TextStyle(color: Colors.black38, fontSize: 18),
            )),
          ],
        ),
      ),
    );
  }

//main contex---------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        child: Container(
          child: Container(
            color: Colors.white38,
            child: Container(
              child: _loading
                  ? Center(
                      child: ShimmerProject(),
                    )
                  : ListView.builder(
                      itemCount:
                          _sick['data'].length <= 0 ? 1 : _sick['data'].length,
                      //  itemCount: 1,
                      itemBuilder: (context, index) {
                        return _sick['data'].length.toString() == '0'
                            ? _buildnodata()
                            : _leave(index);
                        //return _buildnodata();
                      }),
            ),
          ),
        ),
        onRefresh: getDatapref,
      ),
    );
  }

  Widget _leave(index) {
    var description = _sick['data'][index]['note'];
    var id = _sick['data'][index]['id'];
    var dates = _sick['data'][index]['application_dates'];
    var sick_dates = dates.split(',');
    print(sick_dates.length);
    var status = _sick['data'][index]['approval_status'];
    if (status == "pending") {
      if (sick_dates.length > 3) {
        _visible = true;
        print("true");
      } else {
        _visible = false;
        print("false");
      }
    } else {
      _visible = false;
    }

    // var date_of_filing=DateFormat().format(DateFormat().parse(_leaves['data'][index]['date_of_filing'].toString()));
    return Card(
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 20),
        width: Get.mediaQuery.size.width,
        child: Container(
          margin: EdgeInsets.only(top: 10, left: 5, right: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: Get.mediaQuery.size.width,
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  DateFormat('dd/MM/yyyy').format(
                      DateTime.parse(_sick['data'][index]['date'].toString())),
                  style:
                      TextStyle(color: Colors.black45, fontFamily: "SFReguler"),
                  textAlign: TextAlign.end,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  "Tanggal Sakit",
                  style: TextStyle(color: Colors.black38),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Flex(direction: Axis.horizontal, children: [
                Expanded(
                    child: Container(
                  child: Text(
                    _sick['data'][index]['application_dates'].toString(),
                    style: TextStyle(
                        color: Colors.black87, fontFamily: "SFReguler"),
                  ),
                ))
              ]),
              SizedBox(
                height: 15,
              ),
              description != null
                  ? Container(
                      child: Text(
                        "Keterangan",
                        style: TextStyle(color: Colors.black38),
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 5,
              ),
              description != null
                  ? Flex(direction: Axis.horizontal, children: [
                      Expanded(
                          child: Container(
                        child: Text(
                          "${_sick['data'][index]['note'].toString()}",
                          style: TextStyle(
                              color: Colors.black87, fontFamily: "SFReguler"),
                        ),
                      ))
                    ])
                  : Container(),
              SizedBox(
                height: 20,
              ),
              Visibility(
                visible: _visible,
                child: Container(
                  child: Row(
                    children: [
                      Container(
                          child: Icon(
                        Icons.warning_amber_outlined,
                        color: Colors.amber,
                        size: 20,
                      )),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          "Berikan surat keterangan sakit ke hrd",
                          style: TextStyle(
                              color: iconColor, fontFamily: "SFReguler"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              _sick['data'][index]['approval_status'] == "pending"
                  ? btnAction(
                      id,
                      _sick['data'][index]['date'],
                      _sick['data'][index]['application_dates'],
                      _sick['data'][index]['note'])
                  : _sick['data'][index]['approval_status'] == "approved"
                      ? detailApproval(index)
                      : detailRejection(index),
            ],
          ),
        ),
      ),
    );
  }

  Widget btnAction(id, date_of_filing, leave_dates, description) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            width: 40,
            height: 40,
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.black12,
              ),
              child: IconButton(
                iconSize: 20,
                icon: Icon(
                  Icons.edit_outlined,
                  color: Colors.black45,
                ),
                onPressed: () {
                  // Get.to(LeaveEdit(
                  //   id: id,
                  //   date_of_filing: date_of_filing,
                  //   leave_dates: leave_dates,
                  //   description: description,));
                  editSick(id, date_of_filing, leave_dates, description);
                },
              ),
            ),
          ),
          Container(
            width: 40,
            height: 40,
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.black12,
              ),
              child: IconButton(
                iconSize: 20,
                icon: Icon(
                  Icons.restore_from_trash_outlined,
                  color: Colors.black45,
                ),
                onPressed: () {
                  //print('pressed');
                  Services services = new Services();
                  // services.deleteLeave(context, id);
                  Alert(
                    context: context,
                    type: AlertType.warning,
                    title: "Apakah anda yakin?",
                    desc: "Data akan dihapus",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "Batalkan",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => Navigator.pop(context),
                        color: Colors.grey,
                      ),
                      DialogButton(
                        child: Text(
                          "Iya",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          Get.back();
                          services.deleteSick(context, id).then((value) {
                            _dataSick(user_id);
                          });
                        },
                        gradient: LinearGradient(
                            colors: [Colors.green, Colors.green]),
                      )
                    ],
                  ).show();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget detailApproval(index) {
    return Container(
      width: Get.mediaQuery.size.width,
      child: Column(
        children: [
          Container(
            width: Get.mediaQuery.size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2),
                        bottomRight: Radius.circular(2),
                        topRight: Radius.circular(2),
                        bottomLeft: Radius.circular(2)),
                    color: Colors.green,
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Approved",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "SFReguler",
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget detailRejection(index) {
    return Container(
      width: Get.mediaQuery.size.width,
      child: Column(
        children: [
          Container(
            width: Get.mediaQuery.size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2),
                        bottomRight: Radius.circular(2),
                        topRight: Radius.circular(2),
                        bottomLeft: Radius.circular(2)),
                    color: Colors.red,
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Rejected",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "SFReguler",
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void editSick(var id, date_of_filing, sick_dates, description) async {
    var result = await Get.to(EditSickPageEmployee(
      id: id,
      date_of_filling: date_of_filing,
      sick_dates: sick_dates,
      old_sick_dates: sick_dates,
      description: description,
    ));
    if (result == "update") {
      _dataSick(user_id);
    }
  }

  //ge data from api--------------------------------
  Future _dataSick(var user_id) async {
    try {
      setState(() {
        _loading = true;
      });
      http.Response response = await http.get(Uri.parse(
          "$base_url/api/employees/$user_id/sick-applications?approval_status=${widget.status}"));
      _sick = jsonDecode(response.body);

      setState(() {
        _loading = false;
      });
    } catch (e) {}
  }

  Future getDatapref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = sharedPreferences.getString("user_id");
      _dataSick(user_id);
    });
  }

  @override
  void initState() {
    super.initState();
    //show modal detail project
    getDatapref();
  }

  void choiceAction(String choice) {
    if (choice == Constants.Sick) {
      Get.testMode = true;
      Get.to(TabMenuSickPageEmployee());
    }
  }
}
