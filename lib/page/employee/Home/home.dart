import 'dart:convert';

import 'package:carousel_pro/carousel_pro.dart';

import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hrdmagenta/model/notifacations.dart';
import 'package:hrdmagenta/page/admin/l/announcement/DetailAnnouncement.dart';
import 'package:hrdmagenta/page/employee/absence/DetailAbsenceNotifEmplyee.dart';
import 'package:hrdmagenta/page/employee/absence/absence.dart';
import 'package:hrdmagenta/page/employee/absence/tabmenu_absence.dart';
import 'package:hrdmagenta/page/employee/checkin/checkin.dart';
import 'package:hrdmagenta/page/employee/checkout/checkout.dart';
import 'package:hrdmagenta/page/employee/leave/LeaveList.dart';
import 'package:hrdmagenta/page/employee/loan/list.dart';
import 'package:hrdmagenta/page/employee/permission/list.dart';
import 'package:hrdmagenta/page/employee/project/detail.dart';
import 'package:hrdmagenta/page/employee/project/tabmenu_project.dart';
import 'package:hrdmagenta/page/employee/sick/list.dart';
import 'package:hrdmagenta/services/api_clien.dart';
import 'package:hrdmagenta/utalities/color.dart';
import 'package:hrdmagenta/utalities/constants.dart';
import 'package:hrdmagenta/utalities/font.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeEmployee extends StatefulWidget {
  @override
  _HomeEmployeeState createState() => _HomeEmployeeState();
}

enum statusLogin { signIn, notSignIn }

class _HomeEmployeeState extends State<HomeEmployee> {
  final GlobalKey<ScaffoldState> scaffoldState = new GlobalKey<ScaffoldState>();

  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  final List<Notif> ListNotif = [];
  Map _projects;
  bool _loading = true;
  var user_id, address, first_name;

  //-----main menu-----
  Widget _buildMenucheckin() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Checkin()));
          },
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(margin: EdgeInsets.all(15.0), child: checkin),
          ),
        ),
      ),
      Text("Clock In", style: subtitleMainMenu)
    ]);
  }

  Widget _buildMenucheckout() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Checkout()));
          },
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(margin: EdgeInsets.all(15.0), child: checkout),
          ),
        ),
      ),
      Text("Clock Out", style: subtitleMainMenu)
    ]);
  }

  Widget _buildMenuaabsence() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => absence()));
          },
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(margin: EdgeInsets.all(15.0), child: absent),
          ),
        ),
      ),
      Text(
        "Kehadiran",
        style: subtitleMainMenu,
      )
    ]);
  }

  Widget _buildMenuproject() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Tabsproject()));
          },
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(margin: EdgeInsets.all(15.0), child: project),
          ),
        ),
      ),
      Text("Event", style: subtitleMainMenu)
    ]);
  }

  // Widget _buildMenuloan() {
  //   return Column(children: <Widget>[
  //     new Container(
  //       width: 70,
  //       height: 70,
  //       child: InkWell(
  //         onTap: () {
  //           Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                   builder: (context) => ListLoanEmployeePage()));
  //         },
  //         child: Card(
  //           elevation: 1,
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10.0),
  //           ),
  //           child: Container(margin: EdgeInsets.all(15.0), child: loan),
  //         ),
  //       ),
  //     ),
  //     Text("Kasbon", style: subtitleMainMenu)
  //   ]);
  // }

  Widget _buildMenuoffwork() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            // Navigator.pushNamed(context, "leave_list_employee-page");
            Get.to(LeaveListEmployee(
              status: "approved",
            ));
          },
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(margin: EdgeInsets.all(15.0), child: offwork),
          ),
        ),
      ),
      Text("Cuti", style: subtitleMainMenu)
    ]);
  }

  Widget _buildMenusick() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            // Navigator.pushNamed(context, "leave_list_employee-page");
            Get.to(ListSickPageEmployee(
              status: "approved",
            ));
          },
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(margin: EdgeInsets.all(15.0), child: sick),
          ),
        ),
      ),
      Text("Sakit", style: subtitleMainMenu)
    ]);
  }

  Widget _buildMenupermission() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            // Navigator.pushNamed(context, "leave_list_employee-page");
            // Get.to(LeaveListEmployee(status: "approved",));
            Get.to(ListPermissionPageEmployee(
              status: "approved",
            ));
          },
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(margin: EdgeInsets.all(15.0), child: permission),
          ),
        ),
      ),
      Text("izin", style: subtitleMainMenu)
    ]);
  }

  // Widget _buildmenupyslip() {
  //   return Column(children: <Widget>[
  //     new Container(
  //       width: 70,
  //       height: 70,
  //       child: InkWell(
  //         onTap: () {
  //           //Navigator.pushNamed(context, "pyslip_list_employee-page");
  //           Services services = new Services();
  //           services.payslipPermission(context, user_id);
  //         },
  //         child: Card(
  //           elevation: 1,
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10.0),
  //           ),
  //           child: Container(margin: EdgeInsets.all(15.0), child: pyslip),
  //         ),
  //       ),
  //     ),
  //     Text("payslip", style: subtitleMainMenu)
  //   ]);
  // }

  Widget _buildMainMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Container(
            width: double.infinity,
            child: Container(
              margin: EdgeInsets.only(top: 15, bottom: 15),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            _buildMenucheckin(),
                            _buildMenucheckout(),
                            _buildMenuaabsence(),
                            // _buildMenuloan()
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            // _buildmenupyslip(),
                            // _buildMenupermission(),
                            _buildMenusick(),
                            _buildMenuoffwork(),
                            SizedBox(
                              width: 70,
                            ),
                          ],
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  //----end main menu---

  //-----projects-----
  Widget _buildproject() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Container(
        child: Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Expanded(
              child: _loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: _projects['data'].length == 0
                          ? 1
                          : _projects['data'].length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return _projects['data'].length == 0
                            ? _buildNoproject()
                            : _buildProgress(index);
                      }),
              //   child: _buildNoproject(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoproject() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              child: no_data_project,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Belum ada project yang sedang berjalan",
            style: subtitleMainMenu,
          )
        ],
      ),
    );
  }

  Widget _buildProgress(index) {
    var venue = "";
    if (_projects['data'][index]['quotations'].length > 0) {
      venue = _projects['data'][index]['quotations'][0]['venue_event'];
    }
    var status = _projects['data'][index]['status'];
    var balance = NumberFormat.currency(decimalDigits: 0, locale: "id")
        .format(_projects['data'][index]['budget']['balance']);
    var completed_task = _projects['data'][index]['task']
        .where((prod) => prod["status"] == "completed")
        .toList();
    var percentage =
        (completed_task.length) / (_projects['data'][index]['task'].length);
    var task = _projects['data'][index]['task'];

    return InkWell(
      onTap: () {
        Get.to(DetailProjects(
          id: '${_projects['data'][index]['id'].toString()}',
        ));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: Card(
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width - 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                  "${_projects['data'][index]['project_number']}",
                                  style: subtitleMainMenu),
                            ),
                            Container(
                              child: Text("$venue",
                                  style: TextStyle(
                                      color: Colors.black38,
                                      fontFamily: "SFReguler",
                                      fontSize: 14)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Text("$balance",
                                  style: TextStyle(
                                      color: Colors.black38,
                                      fontFamily: "SFReguler",
                                      fontSize: 14)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 70,
                        child: Container(
                          child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(top: 3, bottom: 3),
                              child: Text(
                                "${status == "approved" ? "In Progress" : status == "closed" ? "completed" : ""}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              )),
                          decoration: BoxDecoration(
                            color: status == "approved"
                                ? Colors.green
                                : status == "closed"
                                    ? Colors.lightBlue
                                    : Colors.white,
                            borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(10.0),
                              topRight: const Radius.circular(10.0),
                              bottomLeft: const Radius.circular(10.0),
                              bottomRight: const Radius.circular(10.0),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: Get.mediaQuery.size.width / 2,
                        height: 100,
                        child: ListView.builder(
                          itemBuilder: (context, index_member) {
                            return _buildteam(index_member, index);
                          },
                          scrollDirection: Axis.horizontal,
                          itemCount: _projects['data'][index]['members'] == null
                              ? 0
                              : _projects['data'][index]['members'].length,
                        ),
                      ),
                      Container(
                        width: Get.mediaQuery.size.width / 2 - 30,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                new CircularPercentIndicator(
                                  radius: 100.0,
                                  lineWidth: 10.0,
                                  animation: true,
                                  percent: task.length > 0 ? percentage : 0.00,
                                  center: new Text(
                                    "${task.length > 0.0 ? (percentage * 100).toStringAsFixed(2) : 0.00} %",
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0),
                                  ),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: baseColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildteam(index_member, index) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          //container image
          Container(
            child: CircleAvatar(
              radius: 30,
              child: employee_profile,
            ),
          ),
        ],
      ),
    );
  }

//----end announcement-----
  Widget _buildInformation() {
    return InkWell(
      onTap: () {
        Get.to(DetailAnnouncement());
      },
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                elevation: 1,
                child: Container(
                  margin: EdgeInsets.only(top: 15, bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Stack(
                              children: [
                                Container(
                                  color: Color.fromRGBO(255, 255, 255, 2),
                                  width: double.infinity,
                                  height: 170,
                                  child: Image.asset(
                                    "assets/announcement.jpg",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Container(
                                  height: 200,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 20, right: 20),
                                        width: double.maxFinite,
                                        child: Text(
                                          "Cuti bersama dimulai dari tanggal 6 - 7 mei 2021",
                                          style: titlteannoucement1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              width: double.maxFinite,
                              child: Text(
                                "Cuti bersama dimulai dari tanggal 6 - 7 mei 2021",
                                style: titlteannoucement,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              width: double.maxFinite,
                              child: Text(
                                "2 November 2021",
                                style: TextStyle(color: Colors.black38),
                              ),
                            ),
                          ],
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
    );
  }

  //----end announcement

  Widget _buildNoAbbouncement() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              child: no_data_announcement,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Belum ada pengumuman",
            style: subtitleMainMenu,
          )
        ],
      ),
    );
  }

  //data from api
  Future dataProject(user_id) async {
    try {
      setState(() {
        _loading = true;
      });

      http.Response response = await http.get(Uri.parse(
          "${baset_url_event}/api/projects/approved/employees/${user_id}?page=1&record=5"));
      _projects = jsonDecode(response.body);
      // print("${_projects}");
      // print(baset_url_event);

      setState(() {
        _loading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   title: Center(
      //     child: new Text(
      //       "Home",
      //       style: TextStyle(color: Colors.black87),
      //     ),
      //   ),
      // ),
      key: scaffoldState,
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
        child: RefreshIndicator(
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Stack(
                children: <Widget>[
                  Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Colors.white),
                  Container(
                    // height: double.infinity,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 12.0),
                            padding: EdgeInsets.only(top: 70, bottom: 20),
                            child: Row(
                              children: [
                                iconProf,
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "$first_name",
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: btnColor1,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                              ),
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 12.0),
                            padding: EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Selamat datang, $first_name",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Jabatan",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 0,
                                  offset: Offset(0, 1),
                                )
                              ],
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 12.0),
                            padding: EdgeInsets.all(12.0),
                            child: Center(
                              child: Container(
                                // margin: EdgeInsets.symmetric(horizontal: 12.0),
                                width: MediaQuery.of(context).size.width,
                                child: RaisedButton(
                                  color: HexColor('#EFEDFF'),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3.0),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    "Clock In",
                                    style: TextStyle(color: btnColor1),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 5),
                            child: Text("Main Menu",
                                textAlign: TextAlign.left,
                                style: titleMainMenu),
                          ),
                          _buildMainMenu(),

                          SizedBox(
                            height: 15,
                          ),

                          // Container(
                          //   margin: EdgeInsets.only(left: 10, top: 5),
                          //   child: Row(
                          //     children: [
                          //       Container(
                          //         child: Text("Projects",
                          //             textAlign: TextAlign.left,
                          //             style: titleMainMenu),
                          //       ),
                          //       Container(
                          //         width: Get.mediaQuery.size.width - 90,
                          //         child: InkWell(
                          //           onTap: () {
                          //             Get.to(Tabsproject());
                          //           },
                          //           child: Container(
                          //             child: Text("Lihat Semua",
                          //                 textAlign: TextAlign.right,
                          //                 style:
                          //                     TextStyle(color: Colors.black45)),
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 10,
                          // ),

                          // _buildproject(),

                          // SizedBox(
                          //   height: 15,
                          // ),
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 5),
                            child: Text("Announcement",
                                textAlign: TextAlign.left,
                                style: titleMainMenu),
                          ),
                          // _buildInformation(),
                          _buildNoAbbouncement()
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          onRefresh: getDatapref,
        ),
      ),
    );
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

  //notification
  showNotifcation(String title, String body, String data) async {
    var android = new AndroidNotificationDetails('chanel id', 'chanel name');
    var ios = new IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: ios);
    await flutterLocalNotificationsPlugin.show(0, '$title', '$body', platform,
        payload: "$data");
  }

  Future onSelectNotification(var payload) {
    debugPrint("payload : ${payload}");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => detail_absence_employee_notif(
          id: payload,
        ),
      ),
    );
  }

  Future getDatapref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = sharedPreferences.getString("user_id");
      first_name = sharedPreferences.getString("first_name");
    });
    setState(() {
      dataProject(user_id);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  //inialisasi state
  void initState() {
    getDatapref();

    // _firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print("onMessage: ${message['notification']['data']}");
    //     final notif = message['notification'];
    //     final data = message['data'];
    //
    //     setState(() {
    //       ListNotif.add(
    //         Notif(
    //             title: notif['title'],
    //             body: notif['body'],
    //             id: data['id'],
    //             screen: data['id']),
    //       );
    //     });
    //     setState(() {
    //       showNotifcation(notif['title'], notif['body'], data['id']);
    //     });
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("onLaunch: $message");
    //
    //     final notification = message['data'];
    //     setState(() {
    //       ListNotif.add(Notif(
    //         title: '${notification['title']}',
    //         body: '${notification['body']}',
    //       ));
    //     });
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print("onResume: $message");
    //   },
    // );
    // _firebaseMessaging.requestNotificationPermissions(
    //     const IosNotificationSettings(sound: true, badge: true, alert: true));
    // super.initState();
    // flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    // var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    // var iOS = new IOSInitializationSettings();
    // var initSetttings = new InitializationSettings(android: android, iOS: iOS);
    // flutterLocalNotificationsPlugin.initialize(initSetttings,
    //     onSelectNotification: onSelectNotification);
  }
}
