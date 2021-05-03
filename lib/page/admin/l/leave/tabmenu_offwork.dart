
import 'package:flutter/material.dart';
import 'package:hrdmagenta/page/admin/l/leave/offwork_status.dart';

class TabsMenuOffworkAdmin extends StatelessWidget {

  List<Widget> containers = [

   offwork_status_admin(
     type: "pending",

   ),
    offwork_status_admin(
      type: "rejected",
    ),
    offwork_status_admin(
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
          title: Text('Cuti',
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