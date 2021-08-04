import 'package:flutter/material.dart';
import 'package:hrdmagenta/page/employee/project/status_finished.dart';
import 'package:hrdmagenta/page/employee/project/project.dart';
import 'package:hrdmagenta/page/employee/task/task_completed.dart';
import 'package:hrdmagenta/page/employee/task/task_inprogress.dart';

import 'package:hrdmagenta/utalities/constants.dart';

class Tabstasks extends StatelessWidget {
  Tabstasks({this.task, this.id});

  var task, id;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black87, //modify arrow color from here..
          ),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context,'update');



            },
          ),

          backgroundColor: Colors.white,
          title: Text(
            'Task',
            style: TextStyle(color: Colors.black87),
          ),
          bottom: TabBar(
            labelColor: Colors.black87,
            tabs: <Widget>[
              Tab(
                text: 'In Progress ',
              ),
              Tab(
                text: 'Completed',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            task_inprogres(
              status: "in progress",
              tasks: "$task",
              id: "$id",
            ),
            task_complated(
              status: "completed",
              tasks: "$task",
              id: "$id",
            )
          ],
        ),
      ),
    );
  }
}
