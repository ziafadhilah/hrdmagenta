
import 'package:flutter/material.dart';
import 'package:hrdmagenta/page/admin/l/absence/status_absence.dart';
import 'package:hrdmagenta/page/employee/absence/absence.dart';





class TabsAbsenceAdmin extends StatelessWidget {

  List<Widget> containers = [

   absence_status_admin(
     type: "pending",

   ),
    absence_status_admin(
      type: "rejected",
    ),
    absence_status_admin(
      type: "approved",
    ),

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
          title: Text('Attendance',
            style: TextStyle(color: Colors.black87),

          ),
          bottom: TabBar(
            labelColor: Colors.black87,
            tabs: <Widget>[

              Tab(
                text: 'PENDING',
              ),
              Tab(
                text: 'REJECTED',
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