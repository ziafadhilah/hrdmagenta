import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hrdmagenta/page/admin/l/absence/tabmenu_absence.dart';
import 'package:hrdmagenta/page/admin/l/employees/list.dart';
import 'package:hrdmagenta/page/employee/absence/tabmenu_absence.dart';
import 'package:hrdmagenta/page/employee/budget/tabmenu_budget.dart';
import 'package:hrdmagenta/page/employee/project/tabmenu_project.dart';
import 'package:hrdmagenta/services/api_clien.dart';
import 'package:hrdmagenta/utalities/color.dart';
import 'package:hrdmagenta/utalities/constants.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:http/http.dart' as http;

class HomeAdmin extends StatefulWidget {
  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  Map _employee, _projects;
  bool _isLoading_employee = true;
  bool _isLoading_project = true;

  final GlobalKey<ScaffoldState> scaffoldState = new GlobalKey<ScaffoldState>();

  Widget _buildMenuTask() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            // Navigator.push(context, MaterialPageRoute(
            //     builder: (context) => Tabstask()
            // ));
            sendNotification("pesan", "title");
          },
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(margin: EdgeInsets.all(15.0), child: task),
          ),
        ),
      ),
      Text(
        "Task",
        style: TextStyle(
            color: Colors.black38,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
            fontSize: 15),
      )
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
                MaterialPageRoute(builder: (context) => TabsAbsenceAdmin()));
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
        "Absence",
        style: TextStyle(
            color: Colors.black38,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
            fontSize: 15),
      )
    ]);
  }



  Widget _buildMenubudget() {
    return Column(children: <Widget>[
      new Container(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Tabsappbudget()));
          },
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(margin: EdgeInsets.all(15.0), child: budget),
          ),
        ),
      ),
      Text(
        "Budget",
        style: TextStyle(
            color: Colors.black38,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
            fontSize: 15),
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
        "Project",
        style: TextStyle(
            color: Colors.black38,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
            fontSize: 15),
      )
    ]);
  }

  Widget _buildproject() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3.5,
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
                      itemCount: _projects['data'].length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return _buildProgress(index);
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
                            _buildMenuproject(),
                            _buildMenuTask(),
                            _buildMenuaabsence(),
                            _buildMenubudget(),
                          ],
                        ),
                        Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[],
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
    return Container(
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
                            itemCount: _employee['data'].length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return _employee['data'][index]['mobile_access_type']!="admin"? _buildemployee(index):Text("");
                            }),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 5),
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
                      "View All",
                      style: TextStyle(color: Colors.white70),
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
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height / 3.5,
        width: MediaQuery.of(context).size.width / 2,
        child: Card(
          child: Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${_projects['data'][index]['title']}",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black38,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: new CircularPercentIndicator(
                      radius: 100.0,
                      lineWidth: 13.0,
                      animation: true,
                      percent: _projects['data'][index]['progress'] / 100,
                      center: new Text(
                        "${_projects['data'][index]['progress']}%",
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: baseColor,
                    ),
                  ),
                ],
              ),
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
      body: RefreshIndicator(
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
                                        "employees",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
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
                              textAlign: TextAlign.left, style: titleStyle),
                        ),
                        _buildCardMenu(),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, top: 5),
                          child: Text("Project",
                              textAlign: TextAlign.left, style: titleStyle),
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
    );
  }

  //ge data from api--------------------------------
  Future _dataEmployee() async {
    try {
      setState(() {
        _isLoading_employee = true;
      });
      http.Response response =
          await http.get("http://${base_url}/api/employees");
      _employee = jsonDecode(response.body);

      setState(() {
        _isLoading_employee = false;
      });
    } catch (e) {

    }
  }

  //ge data from api--------------------------------
  Future dataProject() async {
    try {
      setState(() {
        _dataEmployee();
        _isLoading_project = true;
      });
      http.Response response =
          await http.get("http://${base_url}/api/events?status=approved");
      _projects = jsonDecode(response.body);

      setState(() {
        _isLoading_project = false;
      });
    } catch (e) {}
  }

  @override
  Future<void> sendNotification(String body, String title) async {
    String to = await FirebaseMessaging().getToken();
    String serverToken =
        'AAAAd5a4eRw:APA91bGlFuCRH2hAfwDLiUNdFeiYCXcnwyszIj0xwa_RF4IILoZjJiJ3NqbRfab6xI4Wn3DyfvdVMmrhVjUsmAzHRPClh6R5gb3aLEsFpZTm-ZAyDL28BFX6GrIQGnhpcnMfA6wTmdJJ';
    await http.post('https://fcm.googleapis.com/fcm/send',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverToken'
        },
        body: jsonEncode({
          'notification': {'title': title, 'body': body},
          'priority': 'high',
          'data': {'click_action': 'FLUTTER_NOTIFICATION_CLICK'},
          'to': '$to'
        }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dataEmployee();
    dataProject();
    print("tes");
  }
}
