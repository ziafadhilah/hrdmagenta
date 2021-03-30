import 'package:flutter/material.dart';
import 'package:hrdmagenta/page/employee/project/status_finished.dart';
import 'package:hrdmagenta/page/employee/project/project.dart';

import 'package:hrdmagenta/utalities/constants.dart';

class Tabsproject extends StatelessWidget {
  List<Widget> containers = [
    Project(
      status: "approved",
    ),
    Project(
      status: "closed",
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
          title: Text(
            'Project',
            style: TextStyle(color: Colors.black87),
          ),
          bottom: TabBar(
            labelColor: Colors.black87,
            tabs: <Widget>[
              Tab(
                text: 'In Progress',
              ),
              Tab(
                text: 'Finished',
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
