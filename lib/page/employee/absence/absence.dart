import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrdmagenta/model/coin.dart';
import 'package:hrdmagenta/page/employee/absence/detail.dart';
import 'package:hrdmagenta/page/employee/absence/shimmer_effect.dart';
import 'package:hrdmagenta/page/employee/helper/api_helper.dart';


import 'package:hrdmagenta/services/api_clien.dart';
import 'package:hrdmagenta/utalities/color.dart';
import 'package:hrdmagenta/utalities/constants.dart';
import 'package:hrdmagenta/utalities/font.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class absence extends StatefulWidget {
  absence({this.type});

  var type;

  @override
  _absenceState createState() => _absenceState();
}

class _absenceState extends State<absence> {
  var user_id;

  Map _absence;
  bool _loading = true;
  Coin coin;
  var scrollController = ScrollController();
  bool updating = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

    body: Column(

      children: [
        Expanded(
          child: _loading
              ? Center(
                  child: ShimmerAbsence(),
                )
              : ListView.builder(
                  controller: scrollController,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _absence['data'].length == 0
                        ? _buildnodata()
                        : _buildlistabsence(index);
                  },
                  itemCount: _absence['data'].length == 0 ? 1 : _absence['data'].length,
                ),
        ),
        if (updating) CircularProgressIndicator()
      ],
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
                                          Row(
                                            children: [
                                              Container(
                                                  child: _absence['data'][index]
                                                              ['approved_at'] ==
                                                          null
                                                      ? Text(
                                                          "Kamu telah melakukan  ${_absence['data'][index]['type']} ",
                                                          style:
                                                              subtitleMainMenu)
                                                      : Text(
                                                          "kehadiran kamu telah disetujui")),
                                            ],
                                          ),
                                          Container(
                                            child: _absence['data'][index]
                                                        ['type'] ==
                                                    "check in"
                                                ? Container(
                                                    child: _absence['data']
                                                                    [index][
                                                                'approved_at'] ==
                                                            null
                                                        ? Text(
                                                            "${_absence['data'][index]['clock_in']}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .black26))
                                                        : Text(
                                                            "${_absence['data'][index]['approved_at']}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .black26)),
                                                  )
                                                : Container(
                                                    child: _absence['data']
                                                                    [index][
                                                                'approved_at'] ==
                                                            null
                                                        ? Text(
                                                            "${_absence['data'][index]['clock_out']}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .black26))
                                                        : Text(
                                                            "${_absence['data'][index]['approved_at']}",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .black26)),
                                                  ),
                                          ),
                                          InkWell(
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
                                                              office_latitude:
                                                                  _absence['data']
                                                                          [
                                                                          index]
                                                                      [
                                                                      'office_latitude'],
                                                              office_longitude:
                                                                  _absence['data']
                                                                          [
                                                                          index]
                                                                      [
                                                                      'office_longitude'],
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
                                                              office_latitude:
                                                                  _absence['data']
                                                                          [
                                                                          index]
                                                                      [
                                                                      'office_latitude'],
                                                              office_longitude:
                                                                  _absence['data']
                                                                          [
                                                                          index]
                                                                      [
                                                                      'office_longitude'],
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
                                                      "See Details",
                                                      style: TextStyle(
                                                          color: textColor1),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
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
    ):_absence['data'][index]['category']=='leave'?_leave(index):_absence['data'][index]['category']=='sick'?_sick(index):_permission(index);

  }

  Widget _leave(index){
    return Card(
      child: Container(
        margin: EdgeInsets.only(top: 10,bottom: 20),
        width: Get.mediaQuery.size.width,
        child: Container(
          margin: EdgeInsets.only(top: 10,left: 5,right: 5),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Container(child:Text("Cuti",style: TextStyle(color: Colors.black38),),),
              SizedBox(height: 10,),
              Flex(
                  direction: Axis.horizontal,
                  children: [Expanded(child: Container(child:Text("[${_absence['data'][index]['date'].toString()}]",style: TextStyle(color: Colors.black87,fontFamily: "SFReguler"),),))]),
              SizedBox(height: 15,),
              _absence['data'][index]['status']=="approved"?detailApproval(index):detailRejection(index)

            ],
          ),
        ),

      ),
    );
  }
  Widget _sick(index){
    return Card(
      child: Container(
        margin: EdgeInsets.only(top: 10,bottom: 20),
        width: Get.mediaQuery.size.width,
        child: Container(
          margin: EdgeInsets.only(top: 10,left: 5,right: 5),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Container(child:Text("Sakit",style: TextStyle(color: Colors.black38),),),
              SizedBox(height: 10,),
              Flex(
                  direction: Axis.horizontal,
                  children: [Expanded(child: Container(child:Text("[${_absence['data'][index]['date'].toString()}]",style: TextStyle(color: Colors.black87,fontFamily: "SFReguler"),),))]),
              SizedBox(height: 15,),
              _absence['data'][index]['status']=="approved"?detailApproval(index):detailRejection(index)

            ],
          ),
        ),

      ),
    );
  }
  Widget _permission(index){
    return Card(
      child: Container(
        margin: EdgeInsets.only(top: 10,bottom: 20),
        width: Get.mediaQuery.size.width,
        child: Container(
          margin: EdgeInsets.only(top: 10,left: 5,right: 5),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Container(child:Text("Izin",style: TextStyle(color: Colors.black38),),),
              SizedBox(height: 10,),
              Flex(
                  direction: Axis.horizontal,
                  children: [Expanded(child: Container(child:Text("[${_absence['data'][index]['date'].toString()}]",style: TextStyle(color: Colors.black87,fontFamily: "SFReguler"),),))]),
              SizedBox(height: 15,),
              _absence['data'][index]['status']=="approved"?detailApproval(index):detailRejection(index)

            ],
          ),
        ),

      ),
    );
  }

  Widget detailApproval(index){
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
                            Text("Approved",style: TextStyle(color: Colors.white,fontFamily: "SFReguler",fontSize: 12),),
                          ],
                        ),)

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
  Widget detailRejection(index){
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
                            Text("Rejected",style: TextStyle(color: Colors.white,fontFamily: "SFReguler",fontSize: 12),),
                          ],
                        ),)

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
              "Belum ada kehadiran",
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
          "$base_url/api/employees/$user_id/attendances?type=${widget.type}&status=approved");
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

  getCoin() async {
    coin = await apiHelper.getCoins();
    setState(() {});
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCoin();
    getDatapref();
  }
}
