import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrdmagenta/page/employee/leave/LeaveEdit.dart';
import 'package:hrdmagenta/page/employee/permission/add.dart';
import 'package:hrdmagenta/page/employee/permission/tabmenu.dart';
import 'package:hrdmagenta/page/employee/project/shimmer_project.dart';
import 'package:hrdmagenta/services/api_clien.dart';
import 'package:hrdmagenta/utalities/color.dart';
import 'package:hrdmagenta/utalities/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class ListPermissionPageAdmin extends StatefulWidget {
  ListPermissionPageAdmin({this.status});
  var status;
  @override
  _ListPermissionPageAdminState createState() => _ListPermissionPageAdminState();
}

class _ListPermissionPageAdminState extends State<ListPermissionPageAdmin> {
  //variable
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  var user_id;
  var _permission;

  bool _loading = true;

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
                  "Belum ada pengajuan izin",
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
                  itemCount:_permission['data'].length<=0?1:_permission['data'].length,

                  itemBuilder: (context, index) {
                    return _permission['data'].length.toString()=='0'?_buildnodata(): _leave(index);

                  }),
            ),
          ),
        ),
        onRefresh: getDatapref,
      ),
    );
  }
  Widget _leave(index){
    var id=_permission['data'][index]['id'];
    var date_of_filing=_permission['data'][index]['date_of_filing'];
    var permission_dates=_permission['data'][index]['permission_dates'];
    var description=_permission['data'][index]['description'];
    var category=_permission['data'][index]['permission_category']['name'];
    var max_day=_permission['data'][index]['permission_category']['max_day'];
    // var date_of_filing=DateFormat().format(DateFormat().parse(_leaves['data'][index]['date_of_filing'].toString()));
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
                child:Text(_permission['data'][index]['date_of_filing'].toString(),
                  style: TextStyle(color: Colors.black45,fontFamily: "SFReguler")
                  ,textAlign: TextAlign.end,),),
              SizedBox(height: 10,),

              Container(width: Get.mediaQuery.size.width,
                child:Text("${category} (Maksimal:${max_day}  Hari)",
                  style: TextStyle(color:Colors.black87,fontFamily: "SFBlack")
                  ,textAlign: TextAlign.start,),),

              SizedBox(height: 10,),
              Container(child:Text("Tanggal Izin",style: TextStyle(color: Colors.black38),),),
              SizedBox(height: 5,),
              Flex(
                  direction: Axis.horizontal,
                  children: [Expanded(child: Container(child:Text("${_permission['data'][index]['permission_dates'].toString()}",style: TextStyle(color: Colors.black87,fontFamily: "SFReguler"),),))]),
              SizedBox(height: 15,),
              _permission['data'][index]['status']=="pending"?btnAction(id,_permission['data'][index]['date_of_filing'],_permission['data'][index]['leave_dates'],_permission['data'][index]['description']): _permission['data'][index]['status']=="approved"?detailApproval(index):detailRejection(index)

            ],
          ),
        ),

      ),
    );
  }
  Widget btnAction(id,date_of_filing,leave_dates,description){
    return  Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.black12,
              ),
              child: IconButton(
                iconSize: 20,
                icon: Icon(Icons.approval,color: Colors.black45,),
                onPressed: () {
                  //print('pressed');
                  Services services=new Services();
                  // services.deleteLeave(context, id);
                  var remarkController=new TextEditingController();
                  Alert(
                    context: context,
                    type: AlertType.warning,
                    title: "Apakah kamu yakin?",
                    desc: "Data akan di Approve/Reject",
                    content: Column(
                      children: <Widget>[
                        // TextField(
                        //   controller: remarkController,
                        //   decoration: InputDecoration(
                        //     labelText: 'Catatan',
                        //   ),
                        // ),
                      ],
                    ),
                    buttons: [
                      DialogButton(
                        child: Text(
                          "Approve",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          Get.back();
                          services.permissionAproval(context, id, "approve").then((value){
                            _dataPermission(user_id);
                          });
                        },
                        color: Colors.green,
                      ),
                      DialogButton(
                        child: Text(
                          "Reject",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          Get.back();
                          services.permissionAproval(context, id, "reject").then((value){
                            _dataPermission(user_id);
                          });
                        },
                        gradient: LinearGradient(colors: [Colors.red, Colors.red]),
                      )
                    ],
                  ).show();
                },
              ),
            ),
          ),
        ],
      ),

    );
  }

  Widget detailApproval(index){
    return Container(
      width: Get.mediaQuery.size.width,
      child: Column(
        children: [
          Container(
            width: Get.mediaQuery.size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2),
                        bottomRight: Radius.circular(2),
                        topRight: Radius.circular(2),
                        bottomLeft: Radius.circular(2)),
                    color: Colors.green,
                  ),

                  child: Column(

                    children: <Widget>[
                      Container(

                        margin: EdgeInsets.all(7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Approved",style: TextStyle(color: Colors.white,fontFamily: "SFReguler",fontSize: 12),),
                          ],
                        ),)

                    ],
                  ),

                ),
              ],
            ),
          ),
        ],

      ),
    );
  }
  Widget detailRejection(index){
    return Container(
      width: Get.mediaQuery.size.width,
      child: Column(
        children: [
          Container(
            width: Get.mediaQuery.size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2),
                        bottomRight: Radius.circular(2),
                        topRight: Radius.circular(2),
                        bottomLeft: Radius.circular(2)),
                    color: Colors.red,
                  ),

                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Rejected",style: TextStyle(color: Colors.white,fontFamily: "SFReguler",fontSize: 12),),
                          ],
                        ),)

                    ],
                  ),

                ),
              ],
            ),
          ),
        ],

      ),
    );
  }



  void editLeave(var id,date_of_filing,leave_dates,description) async{
    var result=await Get.to(LeaveEdit(
      id: id,
      date_of_filing: date_of_filing,
      leave_dates: leave_dates,
      description: description,));
    if (result=="update"){
      _dataPermission(user_id);
    }
  }
  //ge data from api--------------------------------
  Future _dataPermission(var user_id) async {
    try {
      setState(() {
        _loading = true;
      });
      http.Response response = await http.get(
          "$base_url/api/permission-submissions?status=${widget.status}");
      _permission = jsonDecode(response.body);
      print(_permission);
      setState(() {
        _loading = false;
      });
    } catch (e) {}
  }
  Future getDatapref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = sharedPreferences.getString("user_id");
      _dataPermission(user_id);
    });
  }

  @override
  void initState() {
    super.initState();
    //show modal detail project
    getDatapref();
  }

  void choiceAction(String choice) {
    if (choice == Constants.Permission) {
      Get.testMode = true;
      Get.to(TabMenuPermissionPageEmployee());
    }
  }
}
