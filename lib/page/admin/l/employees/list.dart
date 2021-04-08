import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hrdmagenta/services/api_clien.dart';
import 'package:hrdmagenta/utalities/constants.dart';
import 'package:http/http.dart' as http;
class ListEmployee extends StatefulWidget {
  @override
  _ListEmployeeState createState() => _ListEmployeeState();
}

class _ListEmployeeState extends State<ListEmployee> {
  ///widget
  Map _employee;
  bool _isLoading;
  Widget _buildemployees(index){
    return Container(
      margin: EdgeInsets.only(left: 5,top: 15),
      child: Row(
        children: <Widget>[
          Container(
            child:CircleAvatar(
              radius: 30,
              child: employee_profile,

            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("${_employee['data'][index]["first_name"]} ${_employee['data'][index]["last_name"]}",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                ),
                Text(_employee['data'][index]["work_placement"],
                  style: TextStyle(
                    color: Colors.black38
                  ),

                ),
                Container(

                  width:MediaQuery.of(context).size.width-100,
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _listemployee(){
    return Container(
      child: Expanded(
        child: Container(
          child:_isLoading==true?Center(child: CircularProgressIndicator(),):ListView.builder(
              itemCount: _employee['data'].length,
              itemBuilder:(context,index){
                return _employee['data'][index]['mobile_access_type']!="admin"?_buildemployees(index):Text("");
              }),

        ),
      ),
    );
  }

  ///faunction
  _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(

        decoration: InputDecoration(

            hintText: 'Search...'
        ),
        onChanged: (text) {
          // text = text.toLowerCase();
          // setState(() {
          //   _ModelListTampil = _ModelList.where((note) {
          //     var noteTitle = note.kata.toLowerCase();
          //     return noteTitle.contains(text);
          //   }).toList();
          // });
        },
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black87, //modify arrow color from here..
        ),
        backgroundColor: Colors.white,
        title: Text("Employess",
          style: TextStyle(color: Colors.black87),

        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            // Container(
            //   width: double.infinity,
            //   height: 150,
            //   color: Colors.redAccent[100],
            // ),
            _searchBar(),
            _listemployee()


          ],
        ),

      ),
    );
  }

  //ge data from api--------------------------------
  Future dataEmployee() async{
    try{
      setState(() {
        _isLoading=true;
      });
      http.Response response=await http.get("$base_url/api/employees");
      _employee=jsonDecode(response.body);

      setState(() {
        _isLoading=false;
      });
    }catch(e){

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataEmployee();
  }
}
