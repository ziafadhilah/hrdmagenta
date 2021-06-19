
import 'package:flutter/material.dart';
import 'package:hrdmagenta/page/admin/l/absence/approved.dart';
import 'package:hrdmagenta/page/admin/l/absence/pending.dart';
import 'package:hrdmagenta/page/admin/l/absence/rejected.dart';
import 'package:hrdmagenta/page/admin/l/absence/status_absence.dart';
import 'package:hrdmagenta/page/employee/absence/absence.dart';





class TabsAbsenceAdmin extends StatelessWidget {


  List<Widget> containers = [
   PendingAbsenceAdminPage(
     type: "pending",
   ),
    RejectedAbsenceAdminPage(
      type: "rejected",
    ),
    ApprovedAbsenceAdminPage(
      type: "approved",
    ),
  ];



  @override
  Widget build(BuildContext context) {
    Future<bool> _willPopCallback() async {
      Navigator.of(context).pop('update');
    }

    return WillPopScope(
      onWillPop: _willPopCallback,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop("update"),
            ),

            backgroundColor: Colors.white,
            title: Text('Kehadiran',
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
      ),
    );
  }
}