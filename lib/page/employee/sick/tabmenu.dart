import 'package:flutter/material.dart';
import 'package:hrdmagenta/page/employee/absence/absence_status.dart';
import 'package:hrdmagenta/page/employee/leave/LeaveList.dart';
import 'package:hrdmagenta/page/employee/leave/LeaveStatus.dart';
import 'package:hrdmagenta/page/employee/sick/list.dart';
import 'package:hrdmagenta/page/employee/sick/liststatus.dart';
import 'package:hrdmagenta/utalities/constants.dart';

class TabMenuSickPageEmployee extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();
  List<Widget> containers = [
    ListstatusSickPageEmployee(
      status: "pending",
    ),
    ListstatusSickPageEmployee(status: "rejected",
    ),
    ListstatusSickPageEmployee(
      status: "approved",
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
          title: Text(
            'Status Pengajuan Sakit',
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
