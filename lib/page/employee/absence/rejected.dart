import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hrdmagenta/page/employee/absence/detail.dart';
import 'package:hrdmagenta/page/employee/absence/shimmer_effect.dart';
import 'package:hrdmagenta/services/api_clien.dart';
import 'package:hrdmagenta/utalities/color.dart';
import 'package:hrdmagenta/utalities/constants.dart';
import 'package:hrdmagenta/utalities/font.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RejectAbsenceEmployeePage extends StatefulWidget {
  RejectAbsenceEmployeePage({this.type});

  var type;

  @override
  _RejectAbsenceEmployeePageState createState() => _RejectAbsenceEmployeePageState();
}

class _RejectAbsenceEmployeePageState extends State<RejectAbsenceEmployeePage> {
  var user_id;

  Map _absence;
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _loading
            ? Center(
          child: ShimmerAbsence(),
        )
            : ListView.builder(
          // itemCount: _budgeting['data']['cash_flow'].length,
            itemCount:
            _absence['data'].length == 0 ? 1 : _absence['data'].length,
            itemBuilder: (context, index) {
              return _absence['data'].length == 0
                  ? _buildnodata()
              :_absence['data'][index]['employee_id']==user_id?_buildlistabsence(index):Container();
            }),

        //
      ),
    );
  }

  Widget _buildlistabsence(index) {
    return _absence['data'][index]['category']=='present'?Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 100,
          child: Card(
            elevation: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 5,
                        top: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Container(
                              width: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  //container text
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(),
                                  ),
                                  Flexible(
                                    child: Container(
                                      margin:
                                      EdgeInsets.only(top: 10, left: 10),
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                              child: _absence['data'][index]
                                              ['status'] ==
                                                  "pending"
                                                  ? Container(
                                                child: Text(
                                                    "kehadiran ini butuh persetujuan",
                                                    style:
                                                    subtitleMainMenu),
                                              )
                                                  : _absence['data'][index]
                                              ['status'] ==
                                                  "rejected"
                                                  ? Container(
                                                  child: _absence['data'][index]['rejected_at'] !=
                                                      null
                                                      ? Text(
                                                      "Kehadiran kamu ditolak",
                                                      style:
                                                      subtitleMainMenu)
                                                      : Text(
                                                      "kamu telah ${_absence['data'][index]['type']}"))
                                                  : _absence['data'][index]
                                              ['status'] ==
                                                  "approved"
                                                  ? Container(
                                                child: _absence['data']
                                                [
                                                index]
                                                [
                                                'approved_at'] !=
                                                    null
                                                    ? Text(
                                                    "Kehadiran kamu disetujui",
                                                    style:
                                                    subtitleMainMenu)
                                                    : Container(
                                                  child: Text(
                                                      "kamu telah ${_absence['data'][index]['type']}"),
                                                ),
                                              )
                                                  : Text("")),
                                          Container(
                                            child: _absence['data'][index]
                                            ['type'] ==
                                                "check in"
                                                ? Container(
                                                child: _absence['data']
                                                [index]
                                                ['status'] ==
                                                    "pending"
                                                    ? Text(
                                                    DateFormat("dd/MM/yyyy hh:mm:ss").format(DateTime.parse(_absence['data'][index]['clock_in'])),
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors
                                                            .black26))
                                                    : _absence['data'][index]['status'] ==
                                                    "rejected"
                                                    ? Text(
                                                    "${_absence['data'][index]['rejected_at']}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black26))
                                                    : _absence['data'][index]['status'] == "approved"
                                                    ? Container(child: _absence['data'][index]['approved_at'] != null ? Text("${_absence['data'][index]['approved_at']}", style: TextStyle(fontSize: 15, color: Colors.black26)) : Text("${_absence['data'][index]['clock_in']}", style: TextStyle(fontSize: 15, color: Colors.black26)))
                                                    : Text(""))
                                                : Container(
                                                child: _absence['data'][index]['status'] == "pending"
                                                    ? Text( DateFormat("dd/MM/yyyy hh:mm:ss").format(DateTime.parse(_absence['data'][index]['clock_in'])), style: TextStyle(fontSize: 15, color: Colors.black26))
                                                    : _absence['data'][index]['status'] == "rejected"
                                                    ? Text("${_absence['data'][index]['rejected_at']}", style: TextStyle(fontSize: 15, color: Colors.black26))
                                                    : _absence['data'][index]['status'] == "approved"
                                                    ? Container(child: _absence['data'][index]['approved_at'] != null ? Text("${_absence['data'][index]['approved_at']}", style: TextStyle(fontSize: 15, color: Colors.black26)) : Text("${_absence['data'][index]['clock_out']}", style: TextStyle(fontSize: 15, color: Colors.black26)))
                                                    : Text("")),
                                          ),
                                          _absence['data'][index]['clock_in_latitude']!=null?InkWell(
                                            onTap: () {
                                              if (_absence['data'][index]
                                              ['type'] ==
                                                  "check in") {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            detail_absence(
                                                              status:
                                                              widget.type,
                                                              date: _absence[
                                                              'data']
                                                              [index]
                                                              ['date'],
                                                              time: _absence[
                                                              'data']
                                                              [index]
                                                              ['clock_in'],
                                                              image: _absence[
                                                              'data']
                                                              [index]
                                                              ['image'],
                                                              latitude: _absence[
                                                              'data']
                                                              [index][
                                                              'clock_in_latitude'],
                                                              longitude: _absence[
                                                              'data']
                                                              [index][
                                                              'clock_in_longitude'],
                                                              type: _absence[
                                                              'data']
                                                              [index]
                                                              ['type'],
                                                              rejected_by: _absence['data']
                                                              [
                                                              index]
                                                              [
                                                              'rejected_by'] ==
                                                                  null
                                                                  ? "null"
                                                                  : "${_absence['data'][index]['rejected_by']['first_name']} ${_absence['data'][index]['rejected_by']['last_name']}",
                                                              approved_by: _absence['data']
                                                              [
                                                              index]
                                                              [
                                                              'approved_by'] ==
                                                                  null
                                                                  ? "null"
                                                                  : "${_absence['data'][index]['approved_by']['first_name']} ${_absence['data'][index]['approved_by']['last_name']}",
                                                              rejected_on: _absence[
                                                              'data']
                                                              [index][
                                                              'rejected_at'],
                                                              rejection_note:
                                                              _absence['data']
                                                              [
                                                              index]
                                                              [
                                                              'rejection_note'],
                                                              approval_note:
                                                              _absence['data']
                                                              [
                                                              index]
                                                              [
                                                              'approval_note'],
                                                              approved_on: _absence[
                                                              'data']
                                                              [index][
                                                              'approved_at'],
                                                              note: _absence[
                                                              'data']
                                                              [index]
                                                              ['note'],
                                                              category: _absence[
                                                              'data']
                                                              [index]
                                                              ['category'],
                                                              work_placement: _absence[
                                                              'data']
                                                              [
                                                              index]
                                                              [
                                                              'employee']
                                                              [
                                                              'work_placement'],
                                                              firts_name_employee:
                                                              _absence['data']
                                                              [
                                                              index]
                                                              [
                                                              'employee']
                                                              [
                                                              'first_name'],
                                                              last_name_employee:
                                                              _absence['data']
                                                              [
                                                              index]
                                                              [
                                                              'employee']
                                                              [
                                                              'last_name'],
                                                              employee_id: _absence['data']
                                                              [
                                                              index]
                                                              ['employee'][
                                                              'employee_id'],
                                                              photo: _absence['data']
                                                              [
                                                              index]['employee']
                                                              ['photo'],
                                                              office_latitude: _absence['data'][index]['office_latitude'],
                                                              office_longitude: _absence['data'][index]['office_longitude'],
                                                            )));
                                              } else {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            detail_absence(
                                                              status:
                                                              widget.type,
                                                              date: _absence[
                                                              'data']
                                                              [index]
                                                              ['date'],
                                                              time: _absence[
                                                              'data']
                                                              [index]
                                                              ['clock_out'],
                                                              image: _absence[
                                                              'data']
                                                              [index]
                                                              ['image'],
                                                              latitude: _absence[
                                                              'data']
                                                              [index][
                                                              'clock_out_latitude'],
                                                              longitude: _absence[
                                                              'data']
                                                              [index][
                                                              'clock_out_longitude'],
                                                              type: _absence[
                                                              'data']
                                                              [index]
                                                              ['type'],
                                                              rejected_by: _absence['data']
                                                              [
                                                              index]
                                                              [
                                                              'rejected_by'] ==
                                                                  null
                                                                  ? "null"
                                                                  : "${_absence['data'][index]['rejected_by']['first_name']} ${_absence['data'][index]['rejected_by']['last_name']}",
                                                              approved_by: _absence['data']
                                                              [
                                                              index]
                                                              [
                                                              'approved_by'] ==
                                                                  null
                                                                  ? "null"
                                                                  : "${_absence['data'][index]['approved_by']['first_name']} ${_absence['data'][index]['approved_by']['last_name']}",
                                                              rejected_on: _absence[
                                                              'data']
                                                              [index][
                                                              'rejected_at'],
                                                              rejection_note:
                                                              _absence['data']
                                                              [
                                                              index]
                                                              [
                                                              'rejection_note'],
                                                              approval_note:
                                                              _absence['data']
                                                              [
                                                              index]
                                                              [
                                                              'approval_note'],
                                                              approved_on: _absence[
                                                              'data']
                                                              [index][
                                                              'approved_at'],
                                                              note: _absence[
                                                              'data']
                                                              [index]
                                                              ['note'],
                                                              category: _absence[
                                                              'data']
                                                              [index]
                                                              ['category'],
                                                              work_placement: _absence[
                                                              'data']
                                                              [
                                                              index]
                                                              [
                                                              'employee']
                                                              [
                                                              'work_placement'],
                                                              firts_name_employee:
                                                              _absence['data']
                                                              [
                                                              index]
                                                              [
                                                              'employee']
                                                              [
                                                              'first_name'],
                                                              last_name_employee:
                                                              _absence['data']
                                                              [
                                                              index]
                                                              [
                                                              'employee']
                                                              [
                                                              'last_name'],
                                                              employee_id: _absence['data']
                                                              [
                                                              index]
                                                              ['employee'][
                                                              'employee_id'],
                                                              photo: _absence['data']
                                                              [
                                                              index]['employee']
                                                              ['photo'],
                                                              office_latitude: _absence['data'][index]['office_latitude'],
                                                              office_longitude: _absence['data'][index]['office_longitude'],
                                                            )));
                                              }
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                right: 5,
                                                bottom: 5,
                                              ),
                                              width: double.infinity,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  Container(
                                                    child: Text(
                                                      "LIHAT DETAIL",
                                                      style: TextStyle(
                                                          color: textColor1),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ):Container()
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ):Container();
  }

  Widget _buildnodata() {
    return Container(
      height: MediaQuery.of(context).size.height - 150,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: no_data_project,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                child: Text(
                  "Belum ada kehaadiran yang berstatus ${widget.type}",
                  style: subtitleMainMenu,
                )),
          ],
        ),
      ),
    );
  }

  //ge data from api--------------------------------
  Future _dataAbsence(var user_id) async {
    try {
      setState(() {
        _loading = true;
      });
      http.Response response = await http.get(
          // "$base_url/api/employees/$user_id/attendances?status=${widget.type}");
          Uri.parse("${base_url}/api/attendances?status=${widget.type}"));
      _absence = jsonDecode(response.body);
      setState(() {
        _loading = false;
      });
    } catch (e) {}
  }

  void getDatapref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = sharedPreferences.getString("user_id");
      _dataAbsence(user_id);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDatapref();
  }
}
