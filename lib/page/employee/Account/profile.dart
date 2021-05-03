import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrdmagenta/services/api_clien.dart';
import 'package:hrdmagenta/utalities/constants.dart';
import 'package:http/http.dart' as http;

class DetailProfile extends StatefulWidget {
  var id;
  DetailProfile({
    this.id
});



  @override
  _DetailProfileState createState() => _DetailProfileState();
}

class _DetailProfileState extends State<DetailProfile> {

  var first_name,
      last_name,
      photo,
      work_palcement,
      contact_number,
      address,
      email,
      date_of_birth,
      gender;
  bool _isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black87, //modify arrow color from here..
        ),
        backgroundColor: Colors.white,
        title: new Text(
          "Profile",
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: SingleChildScrollView(
        child: _isLoading==true?Container(
          width: Get.mediaQuery.size.width,
            height: Get.size.height,
            child: Center(child: CircularProgressIndicator(),)): Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              _buildProfile(),
              _buildadress(),
              _buildemail(),
              _buildcontaocnumber(),
              _buildgeneder(),
              _builddateofbirth()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfile() {
    return Container(
      margin: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          Container(
              child: CircleAvatar(
                child: employee_profile,
                backgroundColor: Colors.transparent,
                radius: 40,
              )),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    "${first_name} ${last_name}",
                    style: TextStyle(
                        fontFamily: "SFReguler",
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    "${work_palcement}",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: "SFReguler",
                      color: Colors.black38,
                    ),
                  ),
                ),
              ],
            ),
          ) //Container
        ],
      ),
    );
  }

  Widget _buildadress() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                Container(
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 30,
                    child: Icon(
                      Icons.location_on,
                      color: Colors.black38,
                      size: 25,
                    ),
                  ),
                ),

                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Alamat",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: "SFReguler",
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: address == null
                              ? Text("-")
                              : Text(
                            address,
                            style: TextStyle(
                              fontFamily: "SFReguler",
                              fontSize: 14,
                              color: Colors.black38,
                            ),
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
          new Divider(
            color: Colors.black12,
          ),
        ],
      ),
    );
  }

  Widget _buildemail() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                Container(
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 30,
                    child: Icon(
                      Icons.email,
                      color: Colors.black38,
                      size: 25,
                    ),
                  ),
                ),

                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Email",
                          style: TextStyle(
                              fontFamily: "SFReguler",
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: email == null
                              ? Text("-")
                              : Text(
                            email,
                            style: TextStyle(
                              fontFamily: "SFReguler",
                              fontSize: 14,
                              color: Colors.black38,
                            ),
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
          new Divider(
            color: Colors.black12,
          ),
        ],
      ),
    );
  }

  Widget _buildcontaocnumber() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                Container(
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 30,
                    child: Icon(
                      Icons.phone,
                      color: Colors.black38,
                      size: 25,
                    ),
                  ),
                ),

                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Nomor telp",
                          style: TextStyle(
                              fontFamily: "SFReguler",
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: contact_number == null
                              ? Text("-")
                              : Text(
                            contact_number,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black38,
                            ),
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
          new Divider(
            color: Colors.black12,
          ),
        ],
      ),
    );
  }

  Widget _buildgeneder() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                Container(
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 30,
                    child: Icon(
                      Icons.gesture_outlined,
                      color: Colors.black38,
                      size: 25,
                    ),
                  ),
                ),

                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Jenis Kelamin",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: "SFReguler",
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: gender == null
                              ? Text("-")
                              : Text(
                            gender,
                            style: TextStyle(
                              fontFamily: "SFReguler",
                              fontSize: 14,
                              color: Colors.black38,
                            ),
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
          new Divider(
            color: Colors.black12,
          ),
        ],
      ),
    );
  }

  Widget _builddateofbirth() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          //row company profile
          Container(
            child: Row(
              children: <Widget>[
                //container icon
                Container(
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 30,
                    child: Icon(
                      Icons.date_range,
                      color: Colors.black38,
                      size: 25,
                    ),
                  ),
                ),

                //container text componey profile
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Tanggal lahir",
                          style: TextStyle(
                              fontFamily: "SFReguler",
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: date_of_birth == null
                              ? Text("-")
                              : Text(
                            date_of_birth,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "SFReguler",
                              color: Colors.black38,
                            ),
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
          new Divider(
            color: Colors.black12,
          ),
        ],
      ),
    );
  }
  ///function companies
  Future _employee(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    final response =
    await http.get("$base_url/api/employees/${widget.id}");
    final data = jsonDecode(response.body);

    if (data['code'] == 200) {
      //final compaymodel = companiesFromJson(response.body);
      first_name = data['data']['first_name'];
      last_name = data['data']['last_name'];
      photo = data['data']['photo'];
      work_palcement = data['data']['work_placement'];
      gender = data['data']['gender'];
      date_of_birth = data['data']['date_of_birth'];
      email =data['data']['email'];
      address =data['data']['address'];
      contact_number=data['data']['contact_number'];

      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _employee(context);
  }
}
