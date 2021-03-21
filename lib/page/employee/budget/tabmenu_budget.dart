
import 'package:flutter/material.dart';

import 'package:hrdmagenta/page/employee/budget/status.dart';






class Tabsappbudget extends StatelessWidget {
  Tabsappbudget({
    this.event_id
});
  var event_id;



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
          title: Text('Budget',
            style: TextStyle(color: Colors.black87),
          ),
          bottom: TabBar(
            labelColor: Colors.black87,

            tabs: <Widget>[
              Tab(
                text: 'Expense',
              ),
              Tab(
                text: 'Deposit',
              ),

            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            budget_status(status: "expense",event_id: event_id,),
            budget_status(status: "income",event_id: event_id,),

          ],
        ),
      ),
    );
  }
}