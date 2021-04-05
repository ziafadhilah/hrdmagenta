
import 'package:flutter/material.dart';
import 'package:hrdmagenta/page/employee/absence/absence.dart';
import 'package:hrdmagenta/utalities/constants.dart';




class TabsMenuAbsence extends StatelessWidget {
BuildContext _context;
final navigatorKey = GlobalKey<NavigatorState>();
  List<Widget> containers = [
    absence(
      type: "Check In",
    ),
    absence(
      type: "Check Out",
    )
  ];


  @override
  Widget build(BuildContext context) {
    this._context = context;

    return  DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black87, //modify arrow color from here..
            ),
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: choiceAction,

                itemBuilder: (BuildContext context){
                  return Constants.AbsenceStatus.map((String choice){
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();

                },
              )
            ],

            backgroundColor: Colors.white,
            title: Text('Attendance',
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


  void choiceAction(String choice) {
    if (choice==Constants.Absence){
      Navigator.of(_context).pushNamed("tabmenu_absence_status_employee-page");

    }

  }


}