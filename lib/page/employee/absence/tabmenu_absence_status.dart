import 'package:flutter/material.dart';
import 'package:hrdmagenta/page/employee/absence/absence_status.dart';
import 'package:hrdmagenta/utalities/constants.dart';



class TabsMenuAbsencestatus extends StatelessWidget {

  final navigatorKey = GlobalKey<NavigatorState>();
  List<Widget> containers = [
    absence_status(
      type: "pending",
    ),


    absence_status(
      type: "rejected",
    ),


    absence_status(
      type: "approved",
    )
  ];



  @override
  Widget build(BuildContext context) {

    return DefaultTabController(

      length: 3,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black87, //modify arrow color from here..
          ),


          backgroundColor: Colors.white,
          title: Text('Attendance Status',
            style: TextStyle(color: Colors.black87),
          ),
          bottom: TabBar(
            labelColor: Colors.black87,
            tabs: <Widget>[
              Tab(
                text: 'PENDING',
              ),
              Tab(
                text: 'REJECT',
              ),
              Tab(
                text: 'APPROVED',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: containers,
        ),
      ),
    );
  }




}