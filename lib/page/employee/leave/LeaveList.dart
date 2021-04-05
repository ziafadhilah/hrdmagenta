import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hrdmagenta/page/employee/budget/budget_project.dart';
import 'package:hrdmagenta/page/employee/task/tabmenu_task.dart';
import 'package:hrdmagenta/page/employee/project/shimmer_project.dart';
import 'package:hrdmagenta/services/api_clien.dart';
import 'package:hrdmagenta/utalities/color.dart';
import 'package:hrdmagenta/utalities/constants.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LeaveListEmployee extends StatefulWidget {
  LeaveListEmployee({this.status});

  var status;

  @override
  _LeaveListEmployeeState createState() => _LeaveListEmployeeState();
}

class _LeaveListEmployeeState extends State<LeaveListEmployee> {
  //variable
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  var user_id;

  Map _projects;
  bool _loading = false;

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
              "No leave yet",
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
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: choiceAction,

            itemBuilder: (BuildContext context){
              return Constants.LeaveStatus.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();

            },
          )
        ],
        iconTheme: IconThemeData(
          color: Colors.black87, //modify arrow color from here..
        ),
        backgroundColor: Colors.white,
        title: new Text(
          "Leave",
          style: TextStyle(color: Colors.black87),
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: btnColor1,
      ),
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
                      itemCount: 1,
                      itemBuilder: (context, indext) {
                        return _buildnodata();
                      }),
            ),
          ),
        ),
        onRefresh: getDatapref,
      ),
    );
  }

  Future getDatapref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = sharedPreferences.getString("user_id");
    });
  }

  //inislisasi state------------------------------------
  @override
  void initState() {
    super.initState();
    //show modal detail project
    getDatapref();
  }
  void choiceAction(String choice) {
    if (choice==Constants.Leave){
      //Navigator.of(context).pushNamed("tabmenu_absence_status_employee-page");

    }

  }
}
