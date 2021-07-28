import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hrdmagenta/page/admin/l/task/tabmenutask.dart';
import 'package:hrdmagenta/page/employee/budget/budget_project.dart';
import 'package:hrdmagenta/page/employee/task/tabmenu_task.dart';
import 'package:hrdmagenta/services/api_clien.dart';
import 'package:hrdmagenta/utalities/color.dart';
import 'package:hrdmagenta/utalities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
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
  var projectNumber,
  quotation,
  projectStartDate,
  projectEndDate,
  description,
  customer,
  picCustomer,
  address,
  latitude,
  longitude,
  totalProjectCost,
  totalIn,
  totalOut,
  balance,
  percentage,
  budgetStartDate,
  budgetEndDate,
  members;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;




  Map _projectdetail,tasks;
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
              onPressed: () {Get.to(budgetproject(projectNumber: projectNumber,projectId: widget.id,budgetStartDate: budgetStartDate,budgetEndDate: budgetEndDate,));}),
          IconButton(icon: taskIcon, tooltip: "Budget", onPressed: () {
            Get.to(Tabstasks(id: widget.id,));
          })
        ],
      ),
      body: _loading==true?Container(child: Center(child: CircularProgressIndicator()),):SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 5,right: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 15,),
              Container(
                child: Text(
                  "Detail",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "SFReguler",
                      fontSize: 18),
                ),
              ),
              _detailProject(),
              SizedBox(height: 15,),

              Container(
                child: Text(
                  "Anggota",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "SFReguler",
                      fontSize: 18),
                ),
              ),

              _members(),
              SizedBox(height: 15,),
              Container(
                child: Text(
                  "Persentasi Tugas",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "SFReguler",
                      fontSize: 18),
                ),
              ),
        
              _percentageTask(),
              SizedBox(height: 15,),

              Container(
                child: Text(
                  "Lokasi Project",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "SFReguler",
                      fontSize: 18),
                ),
              ),
              SizedBox(height: 10,),
            //  _budgerCategory()
              _builmap(),
              SizedBox(height: 20,),
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
            // Container(
            //   child: Text(
            //     "Detail",
            //     style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         fontFamily: "SFReguler",
            //         fontSize: 18),
            //   ),
            // ),

            //nama event
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Row(
                children: <Widget>[

                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "No. Project",
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
                            "${projectNumber!=null?projectNumber:""}",
                            style:
                                TextStyle(color: Colors.black45, fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        Container(
                        width: Get.mediaQuery.size.width-35,
                        height: 1,
                        color: Colors.black12,
                      )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[

                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Quotation",
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
                          width: Get.mediaQuery.size.width-35,

                          child: Text(

                            "${quotation!=null?quotation:""}",
                            textAlign: TextAlign.justify,

                            style: TextStyle(color: Colors.black45, fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: Get.mediaQuery.size.width-35,
                          height: 1,
                          color: Colors.black12,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[

                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Tanggal Mulai Project",
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
                          width: Get.mediaQuery.size.width-35,
                          child: Text(
                            "${projectStartDate!=null?projectStartDate:""}",
                            textAlign: TextAlign.justify,
                            style:
                            TextStyle(color: Colors.black45, fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: Get.mediaQuery.size.width-35,
                          height: 1,
                          color: Colors.black12,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[

                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Tanggal Akhir Project",
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
                          width: Get.mediaQuery.size.width-35,
                          child: Text(
                            "${projectEndDate!=null?projectEndDate:""}",
                            style:
                            TextStyle(color: Colors.black45, fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: Get.mediaQuery.size.width-35,
                          height: 1,
                          color: Colors.black12,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[

                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(

                          child: Text(
                            "Deskripsi",
                            textAlign: TextAlign.justify,
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
                          width: Get.mediaQuery.size.width-35,
                          child: Text(
                            "${description!=null?description:""}",
                            style:
                            TextStyle(color: Colors.black45, fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: Get.mediaQuery.size.width-35,
                          height: 1,
                          color: Colors.black12,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[

                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: Get.mediaQuery.size.width-35,
                          child: Text(
                            "Customer",
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
                          width: Get.mediaQuery.size.width-35,
                          child: Text(
                            "${customer!=null?customer:""}",
                            style:
                            TextStyle(color: Colors.black45, fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: Get.mediaQuery.size.width-35,
                          height: 1,
                          color: Colors.black12,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[

                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: Get.mediaQuery.size.width-35,
                          child: Text(
                            "PIC Customer",
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
                          width: Get.mediaQuery.size.width-35,
                          child: Text(
                            "${picCustomer!=null?picCustomer:""}",
                            style:
                            TextStyle(color: Colors.black45, fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: Get.mediaQuery.size.width-35,
                          height: 1,
                          color: Colors.black12,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //lokasi
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[

                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                   width: Get.mediaQuery.size.width-35,
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
                            width: Get.mediaQuery.size.width-35,
                          child: Text(
                            "${address!=null?address:""}",
                            textAlign: TextAlign.justify,
                            style:
                                TextStyle(color: Colors.black45, fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: Get.mediaQuery.size.width-35,
                          height: 1,
                          color: Colors.black12,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //saldo awal
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[

                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Total Biaya Project",
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
                          width: Get.mediaQuery.size.width-35,
                          child: Text(
                            "${totalProjectCost!=null?totalProjectCost:""}",
                            style:
                                TextStyle(color: Colors.black45, fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: Get.mediaQuery.size.width-35,
                          height: 1,
                          color: Colors.black12,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[

                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Total In",
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
                          width: Get.mediaQuery.size.width-35,
                          child: Text(
                            "${totalIn!=null?totalIn:""}",
                            style:
                            TextStyle(color: Colors.black45, fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: Get.mediaQuery.size.width-35,
                          height: 1,
                          color: Colors.black12,
                        )
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
                    margin: EdgeInsets.only(left: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Total Out",
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
                          width: Get.mediaQuery.size.width-35,
                          child: Text(
                            "${totalOut!=null?totalOut:""}",
                            style:
                                TextStyle(color: Colors.black45, fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: Get.mediaQuery.size.width-35,
                          height: 1,
                          color: Colors.black12,
                        )
                      ],
                    ),
                  ),

                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                children: <Widget>[

                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Saldo",
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
                          width: Get.mediaQuery.size.width-35,
                          child: Text(
                            "${balance!=null?balance:""}",
                            style:
                            TextStyle(color: Colors.black45, fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: Get.mediaQuery.size.width-35,
                          height: 1,
                          color: Colors.black12,
                        )
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
  Widget _members() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      color: Colors.white,

      width: double.infinity,
      height: Get.mediaQuery.size.height * 0.35,
      child: Container(
        margin: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: members.length,
            itemBuilder: (contex,index){
          return Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: employee_profile,
                    width: 60,
                    height: 60,
                  ),
                  Container(
                      child:Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "${members[index]['first_name']}",
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
                                "${members[index]['status']=="members"?"Anggota":"PIC"}",
                                style:
                                TextStyle(color: Colors.black45, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      )

                  )


                ],


              )
          );

        }),

    )
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
            // Container(
            //   child: Text(
            //     "Persentasi Tugas",
            //     style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         fontFamily: "SFReguler",
            //         fontSize: 18),
            //   ),
            // ),
            Container(
              margin: EdgeInsets.only(top: 20,left: 10),
              child: CircularPercentIndicator(
                radius: 100.0,
                lineWidth: 8.0,
                percent: percentage!=null?percentage:0,
                center: new Text("${((percentage!=null?percentage:0) * 100).toStringAsFixed(2)}%",style: TextStyle(color: Colors.black,fontFamily: "SFReguler",fontWeight: FontWeight.bold,fontSize: 20),),
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
            // Container(
            //
            //   child: Text(
            //     "katergori Anggaran",
            //     style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         fontFamily: "SFReguler",
            //         fontSize: 18),
            //   ),
            // ),

          ],
        ),
      ),
    );
  }

  Widget _builmap() {
    return SizedBox(
      width: Get.mediaQuery.size.width,
      height: Get.mediaQuery.size.height/2,
      child: Stack(
        children: [
          GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(double.parse(latitude),
                      double.parse(longitude)),
                  zoom: 11.0),
              markers: Set<Marker>.of(<Marker>[
                Marker(
                  markerId: MarkerId("1"),
                  position: LatLng(double.parse(latitude),
                      double.parse(longitude)),
                ),
              ]),
              gestureRecognizers:
              <Factory<OneSequenceGestureRecognizer>>[
                Factory<OneSequenceGestureRecognizer>(
                      () => ScaleGestureRecognizer(),
                ),
              ].toSet()),
          Container(
            width: 300,
            height: 200,
            color: Colors.transparent,
          )
        ],
      ),
    );
  }


  // Widget _widgetMembers(){
  //   return
  //
  // }

  void _getAddressFromLatLng(var latitude,longgitude) async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          latitude, longgitude);

      Placemark place = p[0];

      setState(() {
        address =  "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  Future dataProject() async {
    try {
      setState(() {
        _loading = true;
      });

      http.Response response = await http
          .get("$baset_url_event/api/projects/detail-project/${widget.id}");
      _projectdetail = jsonDecode(response.body);

      //detail
      projectNumber=_projectdetail['data']['project_number'];
      quotation=_projectdetail['data']['quotation_number'];
      projectStartDate=DateFormat('dd/MM/yyyy').format(DateTime.parse("${_projectdetail['data']['project_start_date']}"));
      projectEndDate=DateFormat('dd/MM/yyyy').format(DateTime.parse("${_projectdetail['data']['project_end_date']}"));
      description=_projectdetail['data']['description'];
      customer=_projectdetail['data']['event_customer'];
      picCustomer=_projectdetail['data']['event_pic'];
      totalProjectCost=NumberFormat.currency(decimalDigits: 0,  locale: "id").format(_projectdetail['data']['total_project_cost']);
      _getAddressFromLatLng(double.parse("${_projectdetail['data']['latitude']}"),
          double.parse("${_projectdetail['data']['longtitude']}"));
      latitude=_projectdetail['data']['latitude'];
      longitude=_projectdetail['data']['longtitude'];
      //bugget
      budgetStartDate=_projectdetail['data']['budget']['budget_start_date'];
      budgetEndDate=_projectdetail['data']['budget']['budget_end_date'];
      totalIn= NumberFormat.currency(decimalDigits: 0,  locale: "id").format(_projectdetail['data']['budget']['total_in']);
      totalOut=NumberFormat.currency(decimalDigits: 0,  locale: "id").format(_projectdetail['data']['budget']['total_out']);
      balance=    NumberFormat.currency(decimalDigits: 0,  locale: "id").format(_projectdetail['data']['budget']['balance']);
      //task
      var completed_task= _projectdetail['data']['tasks'].where((prod) => prod["status"] == "completed").toList();
      percentage=(completed_task.length)/(_projectdetail['data']['tasks'].length);
      //members
      members=_projectdetail['data']['members'];




      setState(() {
        _loading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {

    dataProject();
    // TODO: implement initState
    super.initState();
  }
}


