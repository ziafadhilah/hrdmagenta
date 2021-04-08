import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hrdmagenta/page/admin/l/absence/detail.dart';
import 'package:hrdmagenta/page/employee/absence/detail.dart';
import 'package:hrdmagenta/page/employee/absence/shimmer_effect.dart';
import 'package:hrdmagenta/services/api_clien.dart';
import 'package:hrdmagenta/utalities/color.dart';
import 'package:hrdmagenta/utalities/constants.dart';
import 'package:http/http.dart' as http;

class offwork_status_admin extends StatefulWidget {
  offwork_status_admin({this.type});

  var type;

  @override
  _offwork_status_adminState createState() => _offwork_status_adminState();
}

class _offwork_status_adminState extends State<offwork_status_admin> {
  Map _absence;
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        child: Container(
          child: _loading
              ? Center(
                  child: ShimmerAbsence(),
                )
              : ListView.builder(
                  // itemCount: _budgeting['data']['cash_flow'].length,
                  itemCount: _absence['data'].length == 0
                      ? 1
                      : _absence['data'].length,
                  itemBuilder: (context, index) {
                    return _buildnodata();
                  }),

          //
        ),
        onRefresh: _dataAbsence,
      ),
    );
  }

  Widget _buildlistabsence(index) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 100,
          child: Card(
            elevation: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 5,
                        top: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Container(
                              width: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  //container text
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(),
                                  ),
                                  Flexible(
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(top: 10, left: 10),
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Text(
                                                "you ",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: textColor1),
                                              ),
                                              Text(
                                                  "Have been ${_absence['data'][index]['type']}",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black87)),
                                            ],
                                          ),
                                          Text(
                                              "${_absence['data'][index]['clock_in']}",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black26)),
                                          InkWell(
                                            onTap: () {

                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                right: 5,
                                                bottom: 5,
                                              ),
                                              width: double.infinity,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  Container(
                                                    child: Text(
                                                      "See Details",
                                                      style: TextStyle(
                                                          color: textColor1),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildnodata() {
    return Container(
      height: MediaQuery.of(context).size.height - 150,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: no_data_project,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                child: Text(
              "No Leave yet",
              style: TextStyle(color: Colors.black38, fontSize: 18),
            )),
          ],
        ),
      ),
    );
  }

  //ge data from api--------------------------------
  Future _dataAbsence() async {
    try {
      setState(() {
        _loading = true;
      });
      http.Response response = await http
          .get("$base_url/api/attendances?status=${widget.type}");
      _absence = jsonDecode(response.body);
      setState(() {
        _loading = false;
      });
    } catch (e) {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dataAbsence();
  }
}
