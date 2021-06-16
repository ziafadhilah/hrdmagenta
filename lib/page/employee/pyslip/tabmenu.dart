
import 'package:flutter/material.dart';
import 'package:hrdmagenta/page/employee/absence/absence.dart';
import 'package:hrdmagenta/page/employee/pyslip/ListPayslip.dart';
import 'package:hrdmagenta/utalities/constants.dart';




class TabsMenuPayslip extends StatelessWidget {
  BuildContext _context;
  final navigatorKey = GlobalKey<NavigatorState>();
  List<Widget> containers = [
    PyslipListPage(
      type:"custom_period"

    ),
    PyslipListPage(
      type:"fix_period"

    ),
    PyslipListPage(
      type:"non_fix_period"

    )
  ];


  @override
  Widget build(BuildContext context) {
    this._context = context;

    return  DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black87, //modify arrow color from here..
          ),


          backgroundColor: Colors.white,
          title: Text('Payslip',
            style: TextStyle(color: Colors.black87),
          ),
          bottom: TabBar(
            labelColor: Colors.black87,
            tabs: <Widget>[
              Tab(
                text: 'Harian',
              ),
              Tab(
                text: 'Bulanan',
              ),
              Tab(
                text: 'Tahunan',
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