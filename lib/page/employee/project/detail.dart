import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hrdmagenta/services/api_clien.dart';
import 'package:hrdmagenta/utalities/color.dart';
import 'package:hrdmagenta/utalities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pie_chart/pie_chart.dart';

class DetailProjects extends StatefulWidget {
  var id;

  DetailProjects({this.id});

  @override
  _DetailProjectsState createState() => _DetailProjectsState();
}

class _DetailProjectsState extends State<DetailProjects> {
  bool _loading = true;
  Map _projectdetail;
  Map<String, double> budgetCategory = {
    "Konsumsi": 100000,
    "transportasi":200000 ,
    "lainnya": 30000,

  };


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black87, //modify arrow color from here..
        ),
        backgroundColor: Colors.white,
        title: new Text(
          "Project Detail",
          style: TextStyle(color: Colors.black87),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.monetization_on_outlined,
                size: 30,
              ),
              tooltip: "Budget",
              onPressed: () {}),
          IconButton(icon: taskIcon, tooltip: "Budget", onPressed: () {})
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              _detailProject(),
              _mermbers(),
              _percentageTask(),
              _budgerCategory()
            ],
          ),
        ),
      ),
    );
  }

  //detail peroject

  Widget _detailProject() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      color: Colors.white,
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                "Detail",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "SFReguler",
                    fontSize: 18),
              ),
            ),

            //nama event
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Icon(
                      Icons.label,
                      size: 30,
                      color: Colors.black45,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Nama Event",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: "SFReguler"),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Text(
                            "Seminar",
                            style:
                                TextStyle(color: Colors.black45, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //lokasi
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Icon(
                      Icons.location_on,
                      size: 30,
                      color: Colors.black45,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Alamat",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: "SFReguler"),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Text(
                            "Jalan  manjahlega no 5",
                            style:
                                TextStyle(color: Colors.black45, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //saldo awal
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Icon(
                      Icons.monetization_on_outlined,
                      size: 30,
                      color: Colors.black45,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "saldo awal",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: "SFReguler"),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Text(
                            "IDR 10.000.000",
                            style:
                                TextStyle(color: Colors.black45, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //saldo
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Icon(
                      Icons.monetization_on,
                      size: 30,
                      color: Colors.black45,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Sisa  saldo",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: "SFReguler"),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Text(
                            "IDR 1.000.000",
                            style:
                                TextStyle(color: Colors.black45, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //merbers
  Widget _mermbers() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      color: Colors.white,

      width: double.infinity,
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                "Anggota",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "SFReguler",
                    fontSize: 18),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                children: <Widget>[
                  Container(
                    child: employee_profile,
                    width: 60,
                    height: 60,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Rifan Hidayat",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: "SFReguler"),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Text(
                            "pic",
                            style:
                            TextStyle(color: Colors.black45, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }

  //presentasi task
  Widget _percentageTask() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      color: Colors.white,

      width: double.infinity,
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                "Presentasi Task",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "SFReguler",
                    fontSize: 18),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20,left: 10),
              child: CircularPercentIndicator(
                radius: 100.0,
                lineWidth: 8.0,
                percent: 0.5,
                center: new Text("50%",style: TextStyle(color: Colors.black,fontFamily: "SFReguler",fontWeight: FontWeight.bold,fontSize: 20),),
                progressColor: baseColor,
              ),
            )

          ],
        ),
      ),
    );
  }

  //budget category
  Widget _budgerCategory() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      color: Colors.white,
      height: 100,
    
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(

              child: Text(
                "katergori budget",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "SFReguler",
                    fontSize: 18),
              ),
            ),
            Container(

            )
          ],
        ),
      ),
    );
  }

  Future dataProject(var user_id) async {
    try {
      setState(() {
        _loading = true;
      });

      http.Response response = await http
          .get("$base_url/api/employees/$user_id/events?status=${widget.id}");
      _projectdetail = jsonDecode(response.body);

      setState(() {
        _loading = false;
      });
    } catch (e) {}
  }
}
