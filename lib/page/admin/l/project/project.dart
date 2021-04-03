import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hrdmagenta/page/admin/l/budget/budget_project.dart';

import 'package:hrdmagenta/page/employee/task/tabmenu_task.dart';
import 'package:hrdmagenta/page/employee/project/shimmer_project.dart';
import 'package:hrdmagenta/services/api_clien.dart';
import 'package:hrdmagenta/utalities/color.dart';
import 'package:hrdmagenta/utalities/constants.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:http/http.dart' as http;

class Project_admin extends StatefulWidget {
  Project_admin({this.status});

  var status;

  @override
  _Project_adminState createState() => _Project_adminState();
}

class _Project_adminState extends State<Project_admin> {
  //variable
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  var user_id;

  VoidCallback _showPersBottomSheetCallBack;
  Map _projects;
  bool _loading = false;

//------------bottom sheet--------
  void _showModalSheet(var index) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            height: MediaQuery.of(context).size.height - 40,
            child: new Card(
              elevation: 1,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //project
                          Text(
                            "Project",
                            style: TextStyle(
                              fontFamily: "OpenSans",
                              color: textColor1,
                              fontSize: 20,
                            ),
                          ),

                          new Divider(
                            color: Colors.black38,
                          ),

                          _detailproject(index),
                          _buildstardate(index),
                          _buildenddate(index),

                          _buildlocation(index),
                          _budgetAwal(index),
                          _budgetsisa(index),

                          //team
                          Text(
                            "Members",
                            style: TextStyle(
                              fontFamily: "OpenSans",
                              color: textColor1,
                              fontSize: 20,
                            ),
                          ),
                          new Divider(
                            color: Colors.black38,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            height: 200,
                            child: _loading == true
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ListView.builder(
                                    itemCount: _projects['data'][index]
                                            ['members']
                                        .length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index_member) {
                                      return _buildteam(index_member, index);
                                    }),
                          ),

                          //Task
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Task",
                            style: TextStyle(
                              fontFamily: "OpenSans",
                              color: textColor1,
                              fontSize: 20,
                            ),
                          ),
                          new Divider(
                            color: Colors.black38,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          _buildTask(index)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _showBottomSheet() {
    setState(() {
      _showPersBottomSheetCallBack = null;
    });

    _scaffoldKey.currentState
        .showBottomSheet((context) {
          return new Container(
            height: 100,
            child: new Center(
              child: new Text("Hi BottomSheet"),
            ),
          );
        })
        .closed
        .whenComplete(() {
          if (mounted) {
            setState(() {
              _showPersBottomSheetCallBack = _showBottomSheet;
            });
          }
        });
  }

  //widget-------------------------------
  //content bottom sheet profile
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
          Container(
            margin: EdgeInsets.only(left: 20, top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${_projects['data'][index]['members'][index_member]['employee']['first_name']} ${_projects['data'][index]['members'][index_member]['employee']['last_name']}",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "${_projects['data'][index]['members'][index_member]['role']}",
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 15,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

//widget event name
  Widget _detailproject(index) {
    return Container(
      child: Row(
        children: <Widget>[
          //container image
          Container(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 30,
              child: Icon(
                Icons.label,
                size: 30,
                color: Colors.black38,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Title Event",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "${_projects['data'][index]['title']}",
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 15,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildstardate(index) {
    return Container(
      child: Row(
        children: <Widget>[
          //container image
          Container(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 30,
              child: Icon(
                Icons.access_time_outlined,
                size: 30,
                color: Colors.black38,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Start Date",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "${_projects['data'][index]['start_date']}",
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 15,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildlocation(index) {
    return Container(
      child: Row(
        children: <Widget>[
          //container image
          Container(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 30,
              child: Icon(
                Icons.location_on,
                size: 30,
                color: Colors.black38,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Location",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "${_projects['data'][index]['city']['name']}",
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 15,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildenddate(index) {
    return Container(
      child: Row(
        children: <Widget>[
          //container image
          Container(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 30,
              child: Icon(
                Icons.access_time_rounded,
                size: 30,
                color: Colors.black38,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "End Date",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "${_projects['data'][index]['end_date']}",
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 15,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  //
  Widget _budgetAwal(index) {
    return Container(
      child: Row(
        children: <Widget>[
          //container image
          Container(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 30,
              child: Icon(
                Icons.monetization_on,
                size: 30,
                color: Colors.black38,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Balance",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "IDR ${_projects['data'][index]['budget_summary']['balance']}",
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 15,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _budgetsisa(index) {
    return Container(
      child: Row(
        children: <Widget>[
          //container image
          Container(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 30,
              child: Icon(
                Icons.monetization_on_outlined,
                size: 30,
                color: Colors.black38,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Remaining budget",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "IDR ${_projects['data'][index]['budget_summary']['balance'] - _projects['data'][index]['budget_summary']['total_expense']}",
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 15,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTask(index) {
    return Container(
      width: double.infinity,
      child: Center(
        child: Column(
          children: <Widget>[
            new CircularPercentIndicator(
              radius: 120.0,
              lineWidth: 13.0,
              animation: true,
              percent: _projects['data'][index]['progress'] / 100,
              center: new Text(
                "${_projects['data'][index]['progress']}%",
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              footer: new Text(
                "Progress in Project",
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: baseColor,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: new RaisedButton(
                textColor: Colors.white,
                color: btnColor1,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Tabstasks(
                                task: _projects['data'][index].toString(),
                                id: index.toString(),
                              )));
                },
                child: new Text("Task"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //------ widget project----
  Widget _buildproject(index) {
    return Center(
      child: Container(
          width: double.infinity,
          child: Card(
            elevation: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      // Container(
                      //   width: 100,
                      //   height: 100,
                      //
                      //   child: Card(
                      //     color: Colors.black26,
                      //     elevation: 1,
                      //   ),
                      // ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(right: 5, left: 5, top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${_projects['data'][index]['title']}",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${_projects['data'][index]['city']['name']}",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black38),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "IDR ${_projects['data'][index]['budget_summary']['balance']}",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.green),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  width: double.infinity,
                                  height: 40,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      //button detail
                                      new RaisedButton(
                                        padding: const EdgeInsets.all(8.0),
                                        textColor: Colors.white,
                                        color: btnColor1,
                                        onPressed: () {
                                          _showModalSheet(index);
                                        },
                                        child: new Text("Detail"),
                                      ),

                                      //button budgeting

                                      Container(
                                        margin: EdgeInsets.only(left: 5),
                                        child: new OutlineButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => budgetprojectAdmin(
                                                        event_id: _projects['data']
                                                                [index]['id']
                                                            .toString(),
                                                        title_event: _projects['data']
                                                            [index]['title'],
                                                        active_budget:
                                                            _projects['data'][index]['budget_effective_date']
                                                                .toString(),
                                                        expired_budget:
                                                            _projects['data'][index]['budget_expire_date']
                                                                .toString(),
                                                        balance: _projects['data'][index]
                                                                    ['budget_summary']
                                                                ['balance']
                                                            .toString(),
                                                        remaining_budget: "${_projects['data'][index]['budget_summary']['balance'] - _projects['data'][index]['budget_summary']['total_expense']}")));
                                          },
                                          child: Text(
                                            'Budget',
                                            style: TextStyle(color: btnColor1),
                                          ),
                                        ),
                                      )
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
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
              "No projects yet",
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
      body: Container(
        child: Container(
          color: Colors.white38,
          child: Container(
            child: _loading
                ? Center(
                    child: ShimmerProject(),
                  )
                : ListView.builder(
                    itemCount: _projects['data'].length == 0
                        ? 1
                        : _projects['data'].length,
                    itemBuilder: (context, indext) {
                      return _projects['data'].length == 0
                          ? _buildnodata()
                          : _buildproject(indext);
                    }),
          ),
        ),
      ),
    );
  }

  //ge data from api--------------------------------
  Future dataProject() async {
    try {
      setState(() {
        _loading = true;
      });
      http.Response response = await http
          .get("http://${base_url}/api/events?status=${widget.status}");
      _projects = jsonDecode(response.body);
      print(_projects);

      setState(() {
        _loading = false;
      });
    } catch (e) {}
  }

  //inislisasi state------------------------------------
  @override
  void initState() {
    super.initState();
    //show modal detail project

    _showPersBottomSheetCallBack = _showBottomSheet;
    dataProject();
  }
}
