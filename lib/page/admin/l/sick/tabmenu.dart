
import 'package:flutter/material.dart';
import 'package:hrdmagenta/page/admin/l/leave/offwork_status.dart';
import 'package:hrdmagenta/page/admin/l/sick/list.dart';

class TabmenuSickPageAdmin extends StatelessWidget {

  List<Widget> containers = [

    ListSickPageAdmin(
      status: "pending",

    ),
    ListSickPageAdmin(
      status: "rejected",
    ),
    ListSickPageAdmin(
      status: "approved",
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
            title: Text('Pengajuan Sakit',
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