import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrdmagenta/page/employee/leave/TabMenuLeave.dart';
import 'package:hrdmagenta/page/employee/project/shimmer_project.dart';

import 'package:hrdmagenta/utalities/color.dart';
import 'package:hrdmagenta/utalities/constants.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LeaveListStatus extends StatefulWidget {
  LeaveListStatus({this.status});

  var status;

  @override
  _LeaveListStatusState createState() => _LeaveListStatusState();
}

class _LeaveListStatusState extends State<LeaveListStatus> {
  //variable
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  var user_id;

  Map _projects;
  bool _loading = false;

  Widget _buildnodata() {
    return Container(
      height: MediaQuery.of(context).size.height - 150,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: no_data_leave,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                child: Text(
                  "Belum ada cuti",
                  style: TextStyle(color: Colors.black38, fontSize: 18),
                )),
          ],
        ),
      ),
    );
  }

//main contex---------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: RefreshIndicator(
        child: Container(
          child: Container(
            color: Colors.white38,
            child: Container(
              child: _loading
                  ? Center(
                child: ShimmerProject(),
              )
                  : ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, indext) {
                    return _leave();
                  }),
            ),
          ),
        ),
        onRefresh: getDatapref,
      ),
    );
  }
  Widget _leave(){
    return Card(
      child: Container(
        margin: EdgeInsets.only(top: 10,bottom: 20),
        width: Get.mediaQuery.size.width,
        child: Container(
          margin: EdgeInsets.only(top: 10,left: 5,right: 5),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(width: Get.mediaQuery.size.width,
                margin: EdgeInsets.only(left: 10),
                child:Text("Tanggal pengajuan",
                  style: TextStyle(color: Colors.black45,fontFamily: "SFReguler")
                  ,textAlign: TextAlign.end,),),
              SizedBox(height: 10,),
              Container(child:Text("Tanggal cuti",style: TextStyle(color: Colors.black38),),),
              SizedBox(height: 10,),
              Flex(
                  direction: Axis.horizontal,
                  children: [Expanded(child: Container(child:Text("2021-11-20,2021-11-10",style: TextStyle(color: Colors.black87,fontFamily: "SFReguler"),),))]),
              SizedBox(height: 15,),
              btnAction()

            ],
          ),
        ),

      ),
    );
  }
  Widget btnAction(){
    return  Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,

        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            width: 40,
            height: 40,
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.black12,
              ),
              child: IconButton(
                iconSize: 20,
                icon: Icon(Icons.edit_outlined,color: Colors.black45,),
                onPressed: () {
                  print('pressed');
                },
              ),
            ),
          ),

          Container(
            width: 40,
            height: 40,
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.black12,
              ),
              child: IconButton(
                iconSize: 20,
                icon: Icon(Icons.restore_from_trash_outlined,color: Colors.black45,),
                onPressed: () {
                  print('pressed');
                },
              ),
            ),
          ),
        ],
      ),

    );
  }

  Future getDatapref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = sharedPreferences.getString("user_id");
    });
  }

  @override
  void initState() {
    super.initState();
    //show modal detail project
    getDatapref();
  }

  void choiceAction(String choice) {
    if (choice == Constants.Leave) {
      Get.testMode = true;

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TabsMenuLeavestatus()),
      );

      //print(choice);

    }
  }
}
