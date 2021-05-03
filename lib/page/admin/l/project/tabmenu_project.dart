
import 'package:flutter/material.dart';
import 'package:hrdmagenta/page/admin/l/project/project.dart';
import 'package:hrdmagenta/page/employee/project/status_finished.dart';
import 'package:hrdmagenta/page/employee/project/project.dart';

import 'package:hrdmagenta/utalities/constants.dart';





class TabsprojectAdmin extends StatelessWidget {

  List<Widget> containers = [
    Project_admin(status: "approved",),
    Project_admin(status: "closed",),




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
          title: Text('Event',
            style: TextStyle(color: Colors.black87),

          ),
          bottom: TabBar(
            labelColor: Colors.black87,
            tabs: <Widget>[
              Tab(
                text: 'IN PROGRESS',

              ),
              Tab(
                text: 'CLOSED',
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