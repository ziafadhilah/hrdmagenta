
import 'package:flutter/material.dart';
import 'package:hrdmagenta/page/admin/l/absence/status_absence.dart';
import 'package:hrdmagenta/page/employee/absence/absence.dart';





class TabsAbsenceAdmin extends StatelessWidget {

  List<Widget> containers = [

   absence_status_admin(
     type: "Check In",

   ),
    absence_status_admin(
      type: "Check Out",
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black87, //modify arrow color from here..
          ),

          backgroundColor: Colors.white,
          title: Text('Absence',
            style: TextStyle(color: Colors.black87),

          ),
          bottom: TabBar(
            labelColor: Colors.black87,
            tabs: <Widget>[

              Tab(
                text: 'Check In',
              ),
              Tab(
                text: 'Check Out',
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