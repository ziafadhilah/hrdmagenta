import 'dart:convert';
import 'dart:developer';

import 'package:carousel_pro/carousel_pro.dart';

import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hrdmagenta/model/notifacations.dart';
import 'package:hrdmagenta/page/admin/l/announcement/DetailAnnouncement.dart';
import 'package:hrdmagenta/page/employee/absence/DetailAbsenceNotifEmplyee.dart';
import 'package:hrdmagenta/page/employee/absence/tabmenu_absence.dart';
import 'package:hrdmagenta/page/employee/checkin/checkin.dart';
import 'package:hrdmagenta/page/employee/checkout/checkout.dart';
import 'package:hrdmagenta/page/employee/leave/LeaveList.dart';
import 'package:hrdmagenta/page/employee/permission/list.dart';
import 'package:hrdmagenta/page/employee/project/detail.dart';
import 'package:hrdmagenta/page/employee/project/tabmenu_project.dart';
import 'package:hrdmagenta/page/employee/sick/list.dart';
import 'package:hrdmagenta/services/api_clien.dart';
import 'package:hrdmagenta/utalities/color.dart';
import 'package:hrdmagenta/utalities/constants.dart';
import 'package:hrdmagenta/utalities/font.dart';
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

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final List<Notif> ListNotif = [];
  Map _projects;
  bool _loading = true;
  var user_id;

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
      Text("Check In", style: subtitleMainMenu)
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
      Text("Check Out", style: subtitleMainMenu)
    ]);
  }



  Widget _buildMenuaabsence() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TabsMenuAbsence()));
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



  Widget _buildMenuoffwork() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            // Navigator.pushNamed(context, "leave_list_employee-page");
            Get.to(LeaveListEmployee(status: "approved",));
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
            Get.to(ListSickPageEmployee(status: "approved",));
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
            Get.to(ListPermissionPageEmployee());
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

  Widget _buildmenupyslip() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            //Navigator.pushNamed(context, "pyslip_list_employee-page");
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
      Text("payslip", style: subtitleMainMenu)
    ]);
  }

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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            _buildMenucheckin(),
                            _buildMenucheckout(),
                            _buildMenuaabsence(),

                            _buildMenuproject(),


                          ],
                        ),
                        Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            _buildmenupyslip(),
                            _buildMenuoffwork(),
                            _buildMenusick(),
                            _buildMenupermission()

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
    return InkWell(
      onTap: (){
        Get.to(DetailProjects(id: '${_projects['data'][index]['id'].toString()}',));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
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
                        child: _loading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 20, bottom: 20),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                            itemCount: 1,
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
      http.Response response = await http
          .get("$base_url/api/employees/$user_id/events?status=approved");
      _projects = jsonDecode(response.body);
      print(_projects['data'].length);

      setState(() {
        _loading = false;
      });
    } catch (e) {}
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: new Text(
            "Home",
            style: TextStyle(color: Colors.black87),
          ),
        ),
      ),
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
                    height: double.infinity,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(0),
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                      height: 250,
                                      child: Carousel(
                                        autoplay: true,
                                        indicatorBgPadding: 8,
                                        images: [
                                          NetworkImage(
                                              "https://vip.keluargaallah.com/assets/uploads/projects/56/Project-header---EO.jpg"),
                                          NetworkImage(
                                              "https://www.ruangkerja.id/hs-fs/hubfs/membangun%20perusahaan.jpg?width=600&name=membangun%20perusahaan.jpg"),
                                          NetworkImage(
                                              "https://pintek.id/blog/wp-content/uploads/2020/12/perusahaan-startup-1024x683.jpg"),
                                          NetworkImage(
                                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdARQSAn3H0I4m52-7Co7fLa6Eff0mPgumPg&usqp=CAU"),
                                          NetworkImage(
                                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQtZSosUkHA8evWPkN_nNOzKaUt1woUQse-A&usqp=CAU"),
                                        ],
                                      ))
                                ],
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

                          Container(
                            margin: EdgeInsets.only(left: 10, top: 5),
                            child: Text("Event",
                                textAlign: TextAlign.left,
                                style: titleMainMenu),
                          ),

                          _buildproject(),


                          SizedBox(
                            height: 15,
                          ),
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
            builder: (context) => detail_absence_employee_notif(
                  id: payload,
                )));
  }

  Future getDatapref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = sharedPreferences.getString("user_id");
    });
    setState(() {
      dataProject(user_id);
    });
  }

  //inialisasi state
  void initState() {
    getDatapref();

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
