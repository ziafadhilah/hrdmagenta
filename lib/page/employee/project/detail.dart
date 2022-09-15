import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hrdmagenta/page/employee/budget/budget_project.dart';
import 'package:hrdmagenta/page/employee/project/map.dart';
import 'package:hrdmagenta/page/employee/task/tabmenu_task.dart';
import 'package:hrdmagenta/services/api_clien.dart';
import 'package:hrdmagenta/utalities/color.dart';
import 'package:hrdmagenta/utalities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:shared_preferences/shared_preferences.dart';

class DetailProjects extends StatefulWidget {
  var id, venue;

  DetailProjects({this.id, this.venue});

  @override
  _DetailProjectsState createState() => _DetailProjectsState();
}

class _DetailProjectsState extends State<DetailProjects> {
  bool _loading = true;
  var projectNumber,
      quotation,
      projectStartDate,
      projectEndDate,
      description,
      customer,
      picCustomer,
      address,
      latitude,
      longitude,
      totalProjectCost,
      totalIn,
      totalOut,
      balance,
      percentage,
      budgetStartDate,
      budgetEndDate,
      members,
      user_id,
      task = 0,
      budgetid="0",
      status_member;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Map _projectdetail, tasks;
  Map<String, double> budgetCategory = {
    "Konsumsi": 100000,
    "transportasi": 200000,
    "lainnya": 30000,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black87, //modify arrow color from here..
        ),
        backgroundColor: Colors.white,
        title: new Text(
          "Project Detail",
          style: TextStyle(color: Colors.black87),
        ),
        // actions: [
        //   IconButton(
        //       icon: Icon(
        //         Icons.monetization_on_outlined,
        //         size: 30,
        //       ),
        //       tooltip: "Budget",
        //       onPressed: () {
        //         Get.to(budgetproject(
        //           projectNumber: projectNumber,
        //           projectId: widget.id,
        //           budgetStartDate: budgetStartDate,
        //           budgetEndDate: budgetEndDate,
        //           statusMember: status_member,
        //         ));
        //       }),
        //   task > 0
        //       ? IconButton(
        //           icon: taskIcon,
        //           tooltip: "tak",
        //           onPressed: () {
        //             _updateTask();
        //           })
        //       : Container()
        // ],
      ),
      body: _loading == true
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : RefreshIndicator(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Row(
                          children: [
                            Text(
                              "Detail",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "robotol-bold",
                                  fontSize: 17),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                width: double.maxFinite,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 30,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            print("budget start date ${budgetStartDate.toString()}");
                                            Get.to(budgetproject(
                                              projectNumber: projectNumber,
                                              projectId: widget.id,
                                              budgetStartDate: budgetStartDate.toString(),
                                              budgetEndDate: budgetEndDate,
                                              statusMember: status_member,
                                              budgetid: budgetid.toString(),

                                            ));
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    baseColor),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            )),
                                          ),
                                          child: _loading
                                              ? Container(
                                                  width: 30,
                                                  height: 30,
                                                  child: const Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                    color: Colors.white,
                                                    strokeWidth: 2,
                                                  )))
                                              : const Text(
                                                  "Budget",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontFamily:
                                                          "roboto-regular"),
                                                )),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 30,
                                      child: ElevatedButton(
                                          onPressed: () {},
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    baseColor),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            )),
                                          ),
                                          child: _loading
                                              ? Container(
                                                  width: 30,
                                                  height: 30,
                                                  child: const Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                    color: Colors.white,
                                                    strokeWidth: 2,
                                                  )))
                                              : const Text(
                                                  "Task",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontFamily:
                                                          "roboto-regular"),
                                                )),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      _detailProject(),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text(
                          "Angota",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "robotol-bold",
                              fontSize: 17),
                        ),
                      ),
                      _members(),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text(
                          "Persentase",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "robotol-bold",
                              fontSize: 17),
                        ),
                      ),
                      _percentageTask(),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              onRefresh: dataProject,
            ),
    );
  }

  //detail peroject

  Widget _detailProject() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        margin: EdgeInsets.only(top: 10),
        color: Colors.white,
        width: double.infinity,
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   child: Text(
              //     "Detail",
              //     style: TextStyle(
              //         fontWeight: FontWeight.bold,
              //         fontFamily: "SFReguler",
              //         fontSize: 18),
              //   ),
              // ),

              //nama event
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "No. Project",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  letterSpacing: 0.5,
                                  fontFamily: "roboto-regular"),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            child: Text(
                              "${projectNumber != null ? projectNumber : ""}",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 11,
                                  letterSpacing: 0.5,
                                  fontFamily: "roboto-regular"),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: Get.mediaQuery.size.width - 45,
                            child: Divider(
                              height: 1,
                              color: Colors.black.withOpacity(0.1),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Container(
              //   margin: EdgeInsets.only(top: 10),
              //   child: Row(
              //     children: <Widget>[
              //       Container(
              //         margin: EdgeInsets.only(left: 5),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: <Widget>[
              //             Container(
              //               child: Text(
              //                 "Quotation",
              //                 style: TextStyle(
              //                     color: Colors.black,
              //                     fontSize: 15,
              //                     fontFamily: "SFReguler"),
              //               ),
              //             ),
              //             SizedBox(
              //               height: 5,
              //             ),
              //             Container(
              //               width: Get.mediaQuery.size.width - 45,
              //               child: Text(
              //                 "${quotation != null ? quotation : ""}",
              //                 textAlign: TextAlign.justify,
              //                 style: TextStyle(
              //                     color: Colors.black45, fontSize: 15),
              //               ),
              //             ),
              //             SizedBox(
              //               height: 5,
              //             ),
              //             Container(
              //               width: Get.mediaQuery.size.width - 45,
              //               height: 1,
              //               color: Colors.black12,
              //             )
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "Tanggal Mulai Project",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  letterSpacing: 0.5,
                                  fontFamily: "roboto-regular"),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: Get.mediaQuery.size.width - 45,
                            child: Text(
                              "${projectStartDate != null ? projectStartDate : ""}",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 11,
                                  letterSpacing: 0.5,
                                  fontFamily: "roboto-regular"),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: Get.mediaQuery.size.width - 45,
                            child: Divider(
                              height: 1,
                              color: Colors.black.withOpacity(0.1),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "Tanggal Akhir Project",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  letterSpacing: 0.5,
                                  fontFamily: "roboto-regular"),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: Get.mediaQuery.size.width - 45,
                            child: Text(
                              "${projectEndDate != null ? projectEndDate : ""}",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 11,
                                  letterSpacing: 0.5,
                                  fontFamily: "roboto-regular"),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: Get.mediaQuery.size.width - 45,
                            child: Divider(
                              height: 1,
                              color: Colors.black.withOpacity(0.1),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "Deskripsi",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  letterSpacing: 0.5,
                                  fontFamily: "roboto-regular"),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: Get.mediaQuery.size.width - 45,
                            child: Text(
                              "${description != null ? description : ""}",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 11,
                                  letterSpacing: 0.5,
                                  fontFamily: "roboto-regular"),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: Get.mediaQuery.size.width - 45,
                            child: Divider(
                              height: 1,
                              color: Colors.black.withOpacity(0.1),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: Get.mediaQuery.size.width - 45,
                            child: Text(
                              "Customer",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  letterSpacing: 0.5,
                                  fontFamily: "roboto-regular"),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: Get.mediaQuery.size.width - 45,
                            child: Text(
                              "${customer != null ? customer : ""}",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 11,
                                  letterSpacing: 0.5,
                                  fontFamily: "roboto-regular"),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: Get.mediaQuery.size.width - 45,
                            child: Divider(
                              height: 1,
                              color: Colors.black.withOpacity(0.1),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: Get.mediaQuery.size.width - 45,
                            child: Text(
                              "PIC Customer",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  letterSpacing: 0.5,
                                  fontFamily: "roboto-regular"),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: Get.mediaQuery.size.width - 45,
                            child: Text(
                              "${picCustomer != null ? picCustomer : ""}",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 11,
                                  letterSpacing: 0.5,
                                  fontFamily: "roboto-regular"),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: Get.mediaQuery.size.width - 45,
                            child: Divider(
                              height: 1,
                              color: Colors.black.withOpacity(0.1),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //lokasi
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: Get.mediaQuery.size.width - 45,
                            child: Text(
                              "Venue",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  letterSpacing: 0.5,
                                  fontFamily: "roboto-regular"),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: Get.mediaQuery.size.width - 45,
                            child: Text(
                              "${widget.venue}",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 11,
                                  letterSpacing: 0.5,
                                  fontFamily: "roboto-regular"),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: Get.mediaQuery.size.width - 45,
                            child: Divider(
                              height: 1,
                              color: Colors.black.withOpacity(0.1),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //saldo awal
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "Total Biaya Project",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  letterSpacing: 0.5,
                                  fontFamily: "roboto-regular"),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: Get.mediaQuery.size.width - 45,
                            child: Text(
                              "${totalProjectCost != null ? totalProjectCost : ""}",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 11,
                                  letterSpacing: 0.5,
                                  fontFamily: "roboto-regular"),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Container(
              //   margin: EdgeInsets.only(top: 10),
              //   child: Row(
              //     children: <Widget>[
              //       Container(
              //         margin: EdgeInsets.only(left: 5),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: <Widget>[
              //             Container(
              //               child: Text(
              //                 "Total In",
              //                 style: TextStyle(
              //                     color: Colors.black,
              //                     fontSize: 15,
              //                     fontFamily: "SFReguler"),
              //               ),
              //             ),
              //             SizedBox(
              //               height: 5,
              //             ),
              //             Container(
              //               width: Get.mediaQuery.size.width - 45,
              //               child: Text(
              //                 "${totalIn != null ? totalIn : ""}",
              //                 style: TextStyle(
              //                     color: Colors.black45, fontSize: 15),
              //               ),
              //             ),
              //             SizedBox(
              //               height: 5,
              //             ),
              //             Container(
              //               width: Get.mediaQuery.size.width - 45,
              //               height: 1,
              //               color: Colors.black12,
              //             )
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              //
              // //saldo
              // Container(
              //   margin: EdgeInsets.only(top: 20),
              //   child: Row(
              //     children: <Widget>[
              //       Container(
              //         margin: EdgeInsets.only(left: 5),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: <Widget>[
              //             Container(
              //               child: Text(
              //                 "Total Out",
              //                 style: TextStyle(
              //                     color: Colors.black,
              //                     fontSize: 15,
              //                     fontFamily: "SFReguler"),
              //               ),
              //             ),
              //             SizedBox(
              //               height: 5,
              //             ),
              //             Container(
              //               width: Get.mediaQuery.size.width - 45,
              //               child: Text(
              //                 "${totalOut != null ? totalOut : ""}",
              //                 style: TextStyle(
              //                     color: Colors.black45, fontSize: 15),
              //               ),
              //             ),
              //             SizedBox(
              //               height: 5,
              //             ),
              //             Container(
              //               width: Get.mediaQuery.size.width - 45,
              //               height: 1,
              //               color: Colors.black12,
              //             )
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Container(
              //   margin: EdgeInsets.only(top: 20),
              //   child: Row(
              //     children: <Widget>[
              //       Container(
              //         margin: EdgeInsets.only(left: 5),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: <Widget>[
              //             Container(
              //               child: Text(
              //                 "Saldo",
              //                 style: TextStyle(
              //                     color: Colors.black,
              //                     fontSize: 15,
              //                     fontFamily: "SFReguler"),
              //               ),
              //             ),
              //             SizedBox(
              //               height: 5,
              //             ),
              //             Container(
              //               width: Get.mediaQuery.size.width - 45,
              //               child: Text(
              //                 "${balance != null ? balance : ""}",
              //                 style: TextStyle(
              //                     color: Colors.black45, fontSize: 15),
              //               ),
              //             ),
              //             SizedBox(
              //               height: 5,
              //             ),
              //             Container(
              //               width: Get.mediaQuery.size.width - 45,
              //               height: 1,
              //               color: Colors.black12,
              //             )
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  //merbers
  Widget _members() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
          margin: EdgeInsets.only(top: 10),
          color: Colors.white,
          width: double.infinity,
          child: Container(
              margin: EdgeInsets.only(bottom: 40, right: 10, left: 10),
              child: Column(
                children: List.generate(members.length, (index) {
                  return Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: employee_profile,
                                width: 60,
                                height: 60,
                              ),
                              Container(
                                  child: Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        "${members[index]['name']}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontFamily: "roboto-regular"),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      child: Text(
                                        "${members[index]['status'] == "members" ? "Anggota" : "PIC"}",
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontSize: 13,
                                            fontFamily: "roboto-light"),
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                            ],
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: Get.mediaQuery.size.width - 45,
                            child: Divider(
                              height: 1,
                              color: Colors.black.withOpacity(0.1),
                            ),
                          )
                        ],
                      ));
                }),
              ))),
    );
  }

  //presentasi task
  Widget _percentageTask() {
    return Card(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        color: Colors.white,
        width: double.infinity,
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   child: Text(
              //     "Persentasi Tugas",
              //     style: TextStyle(
              //         fontWeight: FontWeight.bold,
              //         fontFamily: "SFReguler",
              //         fontSize: 18),
              //   ),
              // ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 10),
                child: CircularPercentIndicator(
                  radius: 100.0,
                  lineWidth: 8.0,
                  percent: percentage != null ? percentage : 0,
                  center: new Text(
                    "${((percentage != null ? percentage : 0) * 100).toStringAsFixed(2)}%",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "SFReguler",
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  progressColor: baseColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Widget _builmap() {
  //   return InkWell(
  //     onTap: () {},
  //     child: InkWell(
  //       onTap: () {
  //         print("tes");
  //       },
  //       child: Container(
  //           margin: EdgeInsets.only(left: 5, right: 5),
  //           child: SizedBox(
  //             width: Get.mediaQuery.size.width,
  //             height: 300.0,
  //             child: Stack(
  //               children: [
  //                 GoogleMap(
  //                     initialCameraPosition: CameraPosition(
  //                         target: LatLng(
  //                             double.parse(latitude), double.parse(longitude)),
  //                         zoom: 11.0),
  //                     markers: Set<Marker>.of(<Marker>[
  //                       Marker(
  //                         markerId: MarkerId("1"),
  //                         position: LatLng(
  //                             double.parse(latitude), double.parse(longitude)),
  //                       ),
  //                     ]),
  //                     gestureRecognizers:
  //                         <Factory<OneSequenceGestureRecognizer>>[
  //                       Factory<OneSequenceGestureRecognizer>(
  //                         () => ScaleGestureRecognizer(),
  //                       ),
  //                     ].toSet()),
  //                 InkWell(
  //                   onTap: () {
  //                     Get.to(MapsProject(
  //                       latitude: latitude,
  //                       longitude: longitude,
  //                       projectNumber: projectNumber,
  //                       venue: widget.venue,
  //                     ));
  //                   },
  //                   child: Container(
  //                     width: 300,
  //                     height: 200,
  //                     color: Colors.transparent,
  //                   ),
  //                 )
  //               ],
  //             ),
  //           )),
  //     ),
  //   );
  // }

  // Widget _widgetMembers(){
  //   return
  //
  // }

  void _updateTask() async {
    var result = await Get.to(Tabstasks(
      id: widget.id,
    ));
    if (result == 'update') {
      dataProject();
    }
  }

  void _getAddressFromLatLng(var latitude, longgitude) async {
    try {
      List<Placemark> p =
          await geolocator.placemarkFromCoordinates(latitude, longgitude);

      Placemark place = p[0];

      setState(() {
        address = "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  Future dataProject() async {
    try {
      setState(() {
        _loading = true;
      });

      http.Response response = await http
          .get(Uri.parse("$baset_url_event/api/projects/${widget.id}"));
      _projectdetail = jsonDecode(response.body);
      print("data _${_projectdetail}");

      //detail
      projectNumber = _projectdetail['data']['number'];
      // quotation = "tew";
      projectStartDate = DateFormat('dd/MM/yyyy')
          .format(DateTime.parse("${_projectdetail['data']['start_date']}"));
      projectEndDate = DateFormat('dd/MM/yyyy')
          .format(DateTime.parse("${_projectdetail['data']['end_date']}"));
      description = _projectdetail['data']['description'];
      customer = _projectdetail['data']['customer'];
      picCustomer = _projectdetail['data']['pic_event'];
      totalProjectCost = NumberFormat.currency(decimalDigits: 0, locale: "id")
          .format(_projectdetail['data']['amount']);
      // // _getAddressFromLatLng(
      // //     double.parse("${_projectdetail['data']['latitude']}"),
      // //     double.parse("${_projectdetail['data']['longtitude']}"));
      // // latitude = _projectdetail['data']['latitude'];
      // // longitude = _projectdetail['data']['longtitude'];
      // task = _projectdetail['data']['tasks'].length;

      //bugget
      if (_projectdetail['data']['budgets'].length !=null ) {
        budgetStartDate = _projectdetail['data']['budgets']['start_date'];
        budgetEndDate = _projectdetail['data']['budgets']['end_date'];
        budgetid=_projectdetail['data']['budgets']['id'].toString();

        // totalIn = NumberFormat.currency(decimalDigits: 0, locale: "id")
        //     .format(_projectdetail['data']['budgets']['daily_money_reguler']);
        // totalOut = NumberFormat.currency(decimalDigits: 0, locale: "id")
        //     .format(_projectdetail['data']['budgets']['daily_money_reguler']);
        // balance = NumberFormat.currency(decimalDigits: 0, locale: "id")
        //     .format(_projectdetail['data']['budgets']['daily_money_reguler']);
      }

      if (_projectdetail['data']['tasks'].length > 0) {
        //task
        var completed_task = _projectdetail['data']['tasks']
            .where((prod) => prod["status"] == "completed")
            .toList();
        percentage =
            (completed_task.length) / (_projectdetail['data']['tasks'].length);
      }

      //members
      if (_projectdetail['data']['members'].length > 0) {
        members = _projectdetail['data']['members'];
        var checkedPic = _projectdetail['data']['members']
            .where(
                (prod) => prod["employee_id"].toString() == user_id.toString())
            .toList();
        status_member = checkedPic[0]['status'];
      } else {
        members = [];
      }

      setState(() {
        _loading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  Future getDatapref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = sharedPreferences.getString("user_id");
    });
  }

  @override
  void initState() {
    dataProject();
    getDatapref();
    // TODO: implement initState
    super.initState();
  }
}
