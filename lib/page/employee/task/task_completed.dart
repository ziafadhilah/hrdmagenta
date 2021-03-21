
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hrdmagenta/model/tasks.dart';
import 'package:hrdmagenta/services/api_clien.dart';
import 'package:hrdmagenta/utalities/color.dart';

import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;


class task_complated extends StatefulWidget {
  task_complated ({
    this.tasks,
    this.status,
    this.id

});
  var tasks,status,id;


  @override
  _task_complatedState createState() => new _task_complatedState();
}


class _task_complatedState extends State<task_complated > {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  File imageFile;
  var Cdesciription=TextEditingController();
  var Cfile=TextEditingController();
  Map _task;
  bool _loading=false;
  Services services=new Services();







//functions
  /// Get from gallery
  _getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {

        imageFile = File(pickedFile.path);
        //Toast.show("$imageFile", context);
        Cfile.text=imageFile.toString();
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }





  @override
  Widget build(BuildContext context) {
    final items = _loading?"":_task['data'][int.parse(widget.id)]['tasks'][0];
    return new Scaffold(
      body: new Container(
        color: Colors.white,
        child:Container(
          width: double.infinity,
          height: double.infinity,


          child: _loading?Center(child: CircularProgressIndicator()): ListView.builder(
              itemCount:_task['data'][int.parse(widget.id)]['tasks'].length,
              itemBuilder:(context,index){
                return widget.status==_task['data'][int.parse(widget.id)]['tasks'][index]['status']? _listtask_inprogress(index):Text("");



                // return _listtask(index);
              }),

        ),
      ),
    );
  }

  Widget _listtask_completed(index){
    return Container(

      child: Card(
        child: Container(
          margin: EdgeInsets.only(left: 10,right: 10),
          child: Column(
            children: <Widget>[
              Container(

                width: double.infinity,
                child: Text("${_task['data'][int.parse(widget.id)]['tasks'][index]['task']}",
                  style: TextStyle(fontSize: 18,
                    color: Colors.black87
                  ),
                ),

              ),
             SizedBox(height: 15,),
             Column(
               crossAxisAlignment: CrossAxisAlignment.end,
               children: [
                 Container(

                   width: double.infinity,
                   height: 30,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.end,
                     children: [
                       Text("Completed",
                         style: TextStyle(color: baseColor1),
                       ),
                     ],
                   ),


                 ),

               ],
             ),


            ],
          ),
        ),
      ),

    );
  }

  Widget _listtask_inprogress(index){
    return Container(

      child: Card(
        child: Container(
          margin: EdgeInsets.only(left: 10,right: 10),
          child: Column(
            children: <Widget>[
              Container(

                width: double.infinity,
                child: Text("${_task['data'][int.parse(widget.id)]['tasks'][index]['task']}",
                  style: TextStyle(fontSize: 18,
                      color: Colors.black87
                  ),
                ),

              ),
              SizedBox(height: 15,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(

                    width: double.infinity,
                    height: 30,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Completed",
                          style: TextStyle(color: baseColor1),
                        ),
                      ],
                    ),


                  ),

                ],
              ),


            ],
          ),
        ),
      ),

    );
  }
  //ge data from api--------------------------------
  Future dataProject() async{
    try{
      setState(() {
        _loading=true;
      });
      http.Response response=await http.get("http://${base_url}/api/employees/1/events?status=approved");
      _task=jsonDecode(response.body);


      setState(() {
        _loading=false;
      });
    }catch(e){

    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataProject();

  }
  
}