import 'dart:convert';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'package:hrdmagenta/model/notifacations.dart';
import 'package:hrdmagenta/page/admin/l/absence/DetailAbsenceNotifAdmin.dart';
import 'package:hrdmagenta/page/admin/l/absence/tabmenu_absence.dart';
import 'package:hrdmagenta/page/admin/l/employees/DetailEmployee.dart';
import 'package:hrdmagenta/page/admin/l/employees/list.dart';
import 'package:hrdmagenta/page/admin/l/leave/tabmenu_offwork.dart';
import 'package:hrdmagenta/page/admin/l/permission/tabmenu.dart';
import 'package:hrdmagenta/page/admin/l/sick/tabmenu.dart';
import 'package:hrdmagenta/page/employee/project/detail.dart';
import 'package:hrdmagenta/services/api_clien.dart';
import 'package:hrdmagenta/utalities/color.dart';
import 'package:hrdmagenta/utalities/constants.dart';
import 'package:hrdmagenta/utalities/font.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeAdmin extends StatefulWidget {
  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  Map _employee, _projects;
  List _absence;
  Map _permission;
  Map _leave;
  Map _sick;
  bool _isLoading_employee = true;
  bool _isLoading_project = true;
  bool _isLoading_absence = true;
  bool _isLoading_sick = true;
  bool _isLoading_permission = true;
  bool _isLoading_leave = true;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final List<Notif> ListNotif = [];
  var _absenPending,user_id;

  final GlobalKey<ScaffoldState> scaffoldState = new GlobalKey<ScaffoldState>();

  Widget _buildMenuOffwork() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            // Navigator.push(context, MaterialPageRoute(
            //     builder: (context) => Tabstask()
            // ));
            //Navigator.pushNamed(context, "tabmenu_offwork_admin-page");
            navigatorLeave();
          },
          child: Stack(
            children: [
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(margin: EdgeInsets.all(15.0), child: offwork),
              ),
              Container(
                child: _isLoading_leave == true
                    ? Text("")
                    : Container(
                  margin: EdgeInsets.only(top: 15, right: 10),
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        child: _leave['data'].length == 0
                            ? Text("")
                            : CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.redAccent,
                          child: Text(
                            "${_leave['data'].length}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      Text("Cuti", style: subtitleMainMenu)
    ]);
  }
  Widget _buildMenuSick() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            Get.to(TabmenuSickPageAdmin());

          },
          child: Stack(
            children: [
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(margin: EdgeInsets.all(15.0), child: sick),
              ),
              Container(
                child: _isLoading_sick == true
                    ? Text("")
                    : Container(
                  margin: EdgeInsets.only(top: 15, right: 10),
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        child: _sick['data'].length == 0
                            ? Text("")
                            : CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.redAccent,
                          child: Text(
                            "${_sick['data'].length}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      Text("Sakit", style: subtitleMainMenu)
    ]);
  }
  Widget _buildMenuPermission() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            navigatorPermission();


          },

          child: Stack(
            children: [
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(margin: EdgeInsets.all(15.0), child: permission),
              ),
              Container(
                child: _isLoading_permission == true
                    ? Text("")
                    : Container(
                  margin: EdgeInsets.only(top: 15, right: 10),
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        child: _permission['data'].length == 0
                            ? Text("")
                            : CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.redAccent,
                          child: Text(
                            "${_permission['data'].length}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      Text("Izin", style: subtitleMainMenu)
    ]);
  }

  Widget _buildMenuaabsence() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            navigatorAttendances();
          },
          child: Stack(
            children: [
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(margin: EdgeInsets.all(15.0), child: absent),
              ),
              Container(
                child: _isLoading_absence == true
                    ? Text("")
                    : Container(
                        margin: EdgeInsets.only(top: 15, right: 10),
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              child: _absence.length == 0
                                  ? Text("")
                                  : CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Colors.redAccent,
                                      child: Text(
                                        "${_absence.length}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
      Text(
        "Kehadiran",
        style: subtitleMainMenu,
      )
    ]);
  }

  Widget _buildMenuannouncement() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => Tabsappbudget()));
            Navigator.pushNamed(context, "Announcement_list_employee-page");
          },
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(margin: EdgeInsets.all(15.0), child: announcement),
          ),
        ),
      ),
      Text("Pengumuman", style: subtitleMainMenu)
    ]);
  }
  Widget _buildMenupayslip() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            // // Navigator.push(context,
            // //     MaterialPageRoute(builder: (context) => Tabsappbudget()));
            // Navigator.pushNamed(context, "pyslip_list_employee-page");

            Services services=new Services();
            services.payslipPermission(context, user_id);
          },
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(margin: EdgeInsets.all(15.0), child: pyslip),
          ),
        ),
      ),
      Text("Payslip", style: subtitleMainMenu)
    ]);
  }
  Widget _buildMenuemployees() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ListEmployee()));
          },
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(margin: EdgeInsets.all(15.0), child: employees),
          ),
        ),
      ),
      Text("Karyawan", style: subtitleMainMenu)
    ]);
  }

  Widget _buildMenuproject() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, "tabs_project_admin-page");
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
      Text(
        "Event",
        style: subtitleMainMenu,
      )
    ]);
  }

  Widget _buildproject() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Container(
        child: Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Expanded(
              child: _isLoading_project
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

  Widget _buildCardMenu() {
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            _buildMenuemployees(),
                            _buildMenuaabsence(),
                            _buildMenuproject(),
                            _buildMenupayslip(),


                          ],
                        ),
                        Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            _buildMenuannouncement(),
                            _buildMenuPermission(),
                            _buildMenuSick(),
                            _buildMenuOffwork(),




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

  Widget _buildemployee(index) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailEmployee(
                    first_name: "${_employee['data'][index]['first_name']}",
                    last_name: "${_employee['data'][index]['last_name']}",
                    address: "${_employee['data'][index]['address']}",
                    email: "${_employee['data'][index]['email']}",
                    work_palcement:
                        "${_employee['data'][index]['work_placement']}",
                    contact_number:
                        "${_employee['data'][index]['contact_number']}",
                    date_of_birth:
                        "${_employee['data'][index]['date_of_birth']}",
                    gender: "${_employee['data'][index]['gender']}",
                  )),
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 30,
              child: employee_profile,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "${_employee['data'][index]['first_name']}",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listEmployee() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 90,
            margin: EdgeInsets.only(top: 100),
            width: double.infinity,
            child: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: _isLoading_employee == true
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: _employee['data'].length>10?10:_employee['data'].length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return _employee['data'][index]
                                          ['mobile_access_type'] !=
                                      "admin"
                                  ? _buildemployee(index)
                                  : Text("");
                            }),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 5,top: 10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListEmployee()));
                    },
                    child: Text(
                      "Lihat Semua",
                      style: TextStyle(color: Colors.white70, fontFamily: "SFReguler",),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProgress(index) {
    return InkWell(
      onTap: (){
        Get.to(DetailProjects(id: '${_projects['data'][index]['id']}',));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Card(
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),
                      Text("${_projects['data'][index]['title']}",
                          style: subtitleMainMenu),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Text(
                            "${_projects['data'][index]['city']['name']}, ${_projects['data'][index]['city']['province']['name']}",
                            style: TextStyle(
                                color: Colors.black38,
                                fontFamily: "SFReguler",
                                fontSize: 14)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: _isLoading_employee
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 1),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                            itemCount: _projects['data'][index]
                                                    ['members']
                                                .length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index_member) {
                                              return _buildteam(
                                                  index_member, index);
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        //   child: _buildNoproject(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.35 - 25,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(top: 3, bottom: 3),
                                child: Text(
                                  "in progress",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                )),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(10.0),
                                topRight: const Radius.circular(10.0),
                                bottomLeft: const Radius.circular(10.0),
                                bottomRight: const Radius.circular(10.0),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  new CircularPercentIndicator(
                                    radius: 110.0,
                                    lineWidth: 10.0,
                                    animation: true,
                                    percent: _projects['data'][index]
                                            ['progress'] /
                                        100,
                                    center: new Text(
                                      "${_projects['data'][index]['progress']}%",
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
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  width: double.infinity,
                                  color: baseColor,
                                  height: 230,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10, top: 75),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Karyawan",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                ///wodget employee
                                //_buildemployee(),
                                _listEmployee(),
                              ],
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
                          _buildCardMenu(),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 5),
                            child: Text("Event",
                                textAlign: TextAlign.left,
                                style: titleMainMenu),
                          ),
                          _buildproject(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          onRefresh: dataProject,
        ),
      ),
    );
  }

  //-----ge data from api----
  Future _dataEmployee() async {
    try {
      setState(() {
        _isLoading_employee = true;
      });
      http.Response response = await http.get("$base_url/api/employees");
      _employee = jsonDecode(response.body);

      setState(() {
        _isLoading_employee = false;
      });
    } catch (e) {}
  }

  //ge data from api--------------------------------
  Future dataProject() async {
    try {
      setState(() {
        _dataEmployee();
        _datasick();
        _datapermission();
        _dataLeave();
        _dataAbsence();
        _isLoading_project = true;
      });
      http.Response response =
          await http.get("$base_url/api/events?status=approved");
      _projects = jsonDecode(response.body);

      setState(() {
        _isLoading_project = false;
      });
    } catch (e) {}
  }

  //ge data from api--------------------------------
  Future _dataAbsence() async {
    try {
      setState(() {
        _isLoading_absence = true;
      });

      http.Response response =
          await http.get("$base_url/api/attendances?status=pending");
      var _absence_data = jsonDecode(response.body);
      _absence =_absence_data['data'].where((prod) => prod["category"] =="present").toList();
      print("data absen ${_absence.length}");
      setState(() {
        _isLoading_absence = false;
      });
    } catch (e) {}
  }
  Future _datapermission() async {
    try {
      setState(() {
        _isLoading_permission = true;
      });

      http.Response response =
      await http.get("$base_url/api/permission-submissions?status=pending");
      _permission = jsonDecode(response.body);
      setState(() {
        _isLoading_permission = false;
      });
    } catch (e) {}
  }
  Future _datasick() async {
    try {
      setState(() {
        _isLoading_sick = true;
      });

      http.Response response =
      await http.get("$base_url/api/sick-submissions?status=pending");
      _sick = jsonDecode(response.body);
      setState(() {
        _isLoading_sick = false;
      });
    } catch (e) {}
  }
  Future _dataLeave() async {
    try {
      setState(() {
        _isLoading_leave = true;
      });

      http.Response response =
      await http.get("$base_url/api/leave-submissions?status=pending");
      _leave = jsonDecode(response.body);
      setState(() {
        _isLoading_leave = false;
      });
    } catch (e) {}
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
            "Belum ada event yang sedang berjalan",
            style: subtitleMainMenu,
          )
        ],
      ),
    );
  }

  // @override
  // Future<void> sendNotification() async {
  //   String to = await FirebaseMessaging().getToken();
  //   print(to);
  //   String serverToken =
  //       'AAAAd5a4eRw:APA91bGlFuCRH2hAfwDLiUNdFeiYCXcnwyszIj0xwa_RF4IILoZjJiJ3NqbRfab6xI4Wn3DyfvdVMmrhVjUsmAzHRPClh6R5gb3aLEsFpZTm-ZAyDL28BFX6GrIQGnhpcnMfA6wTmdJJ';
  //   await http.post('https://fcm.googleapis.com/fcm/send',
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'key=$serverToken'
  //       },
  //       body: jsonEncode({
  //         'notification': {'title': title, 'body': body},
  //         'priority': 'high',
  //         'data': {'click_action': 'FLUTTER_NOTIFICATION_CLICK'},
  //         'to': '$to'
  //       }));
  // }
  //notification
  //notification
  showNotifcation(String title, String body, String data) async {
    var android = new AndroidNotificationDetails(
        'chanel id', 'chanel name', 'CHANEL DESCRIPTION');
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
            builder: (context) => detail_absence_admin_notif(
                  id: payload,
                )));
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

  Future getDatapref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = sharedPreferences.getString("user_id");
    });

  }


  void navigatorAttendances() async{
   var result =await Navigator.push(context,
        MaterialPageRoute(builder: (context) => TabsAbsenceAdmin()));

   if (result=="update"){
     _dataAbsence();
   }

  }
  void navigatorSick() async{
    var result =await  Get.to(TabmenuSickPageAdmin());

    if (result=="update"){
      _datasick();
    }

  }
  void navigatorLeave() async{
    var result =await Navigator.push(context,
        MaterialPageRoute(builder: (context) => TabsMenuOffworkAdmin()));

    if (result=="update"){
      _dataLeave();
    }

  }
  void navigatorPermission() async{
    var result =await Get.to(TabmenuPermissionPageAdmin());

    if (result=="update"){
      _datapermission();
    }

  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDatapref();
    _dataAbsence();
    _dataEmployee();
    dataProject();
    _dataLeave();
    _datapermission();
    _datasick();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: ${message['notification']['data']}");
        final notif = message['notification'];
        final data = message['data'];

        setState(() {
          ListNotif.add(
            Notif(
                title: notif['title'],
                body: notif['body'],
                id: data['id'],
                screen: data['id']),
          );
        });
        setState(() {
          showNotifcation(notif['title'], notif['body'], data['id']);
        });
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

        final notification = message['data'];
        setState(() {
          ListNotif.add(Notif(
            title: '${notification['title']}',
            body: '${notification['body']}',
          ));
        });
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    super.initState();
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSetttings = new InitializationSettings(android: android, iOS: iOS);
    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
  }
}
