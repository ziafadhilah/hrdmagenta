import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hrdmagenta/page/employee/project/detail.dart';
import 'package:hrdmagenta/page/employee/project/shimmer_project.dart';
import 'package:hrdmagenta/services/api_clien.dart';
import 'package:hrdmagenta/utalities/color.dart';
import 'package:hrdmagenta/utalities/constants.dart';
import 'package:hrdmagenta/utalities/font.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Project extends StatefulWidget {
  Project({this.status});

  var status;

  @override
  _ProjectState createState() => _ProjectState();
}

class _ProjectState extends State<Project> {
  //variable
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  var user_id;
  final GlobalKey<ScaffoldState> scaffoldState = new GlobalKey<ScaffoldState>();

  VoidCallback _showPersBottomSheetCallBack;
  List _projects;
  bool _loading = true, allLoaded = false;
  var address;
  var page = 0, record = 15;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  List<Placemark> p;

  ScrollController _scrollController = new ScrollController();

//---projects---
  Widget _buildproject() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Container(
        child: Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Expanded(
              child: _loading
                  ? Center(
                      child: ShimmerProject(),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount: _projects.length == 0 ? 1 : _projects.length,
                      itemBuilder: (context, index) {
                        return _projects.length == 0
                            ? _buildnodata()
                            : _buildProgress(index);
                      }),
              //   child: _buildNoproject(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgress(index) {
    var venue = _projects[index]['quotations'][0]['venue_event'];

    var completed_task = _projects[index]['task']
        .where((prod) => prod["status"] == "completed")
        .toList();
    var percentage =
        (completed_task.length) / (_projects[index]['task'].length);
    var balance = NumberFormat.currency(decimalDigits: 0, locale: "id")
        .format(_projects[index]['budget']['balance']);
    var status = _projects[index]['status'];
    var tasks = _projects[index]['task'];

    return InkWell(
      onTap: () {
        Get.to(DetailProjects(
          id: '${_projects[index]['id'].toString()}',
          venue: venue,
        ));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Card(
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width - 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                  "${_projects[index]['project_number']}",
                                  style: subtitleMainMenu),
                            ),
                            Container(
                              child: Text("$venue",
                                  style: TextStyle(
                                      color: Colors.black38,
                                      fontFamily: "SFReguler",
                                      fontSize: 14)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Text("$balance",
                                  style: TextStyle(
                                      color: Colors.black38,
                                      fontFamily: "SFReguler",
                                      fontSize: 14)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 70,
                        child: Container(
                          child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(top: 3, bottom: 3),
                              child: Text(
                                "${status == "approved" ? "In Progress" : "${status}"}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              )),
                          decoration: BoxDecoration(
                            color: status == "approved"
                                ? Colors.green
                                : Colors.lightBlue,
                            borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(10.0),
                              topRight: const Radius.circular(10.0),
                              bottomLeft: const Radius.circular(10.0),
                              bottomRight: const Radius.circular(10.0),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: Get.mediaQuery.size.width / 2,
                        height: 100,
                        child: ListView.builder(
                          itemBuilder: (context, index_member) {
                            return _buildteam(index_member, index);
                          },
                          scrollDirection: Axis.horizontal,
                          itemCount: _projects[index]['members'] == null
                              ? 0
                              : _projects[index]['members'].length,
                        ),
                      ),
                      Container(
                        width: Get.mediaQuery.size.width / 2 - 30,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                new CircularPercentIndicator(
                                  radius: 100.0,
                                  lineWidth: 10.0,
                                  animation: true,
                                  percent: tasks.length > 0 ? percentage : 0.00,
                                  center: new Text(
                                    "${tasks.length > 0 ? (percentage * 100).toStringAsFixed(2) : 0.00} %",
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0),
                                  ),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: baseColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
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
              "Belum ada event",
              style: TextStyle(color: Colors.black38, fontSize: 18),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildteam(index_member, index) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          //container image
          Container(
            child: CircleAvatar(
              radius: 30,
              child: employee_profile,
            ),
          ),
        ],
      ),
    );
  }

  //---end projects---

//---main contex-----
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        child: Container(
          width: Get.mediaQuery.size.width,
          height: Get.mediaQuery.size.height,
          child: Container(color: Colors.white38, child: _buildproject()),
        ),
        onRefresh: getDatapref,
      ),
    );
  }

  //ge data from api
  Future dataProject(var user_id) async {
    try {
      setState(() {
        _loading = true;
        page=1;
      });

      http.Response response = await http.get(
          "$baset_url_event/api/projects/${widget.status}/employees/${user_id}?page=1&record=15");

      var data = jsonDecode(response.body);
      _projects = data['data'];

      setState(() {
        _loading = false;
      });
    } catch (e) {}
  }

  Future loadMore(var user_id) async {
    try {
      setState(() {
        allLoaded = true;
        page=page+1;
      });


      http.Response response = await http.get(
          "$baset_url_event/api/projects/${widget.status}/employees/${user_id}?page=${page}&record=${record}");
      var newData = jsonDecode(response.body);
      setState(() {
        for (var i = 0; i < newData['data'].length; i++) {
          _projects.add(newData['data'][i]);
        }
      });

      setState(() {
        allLoaded = false;
      });
    } catch (e) {}
  }

  Future getDatapref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = sharedPreferences.getString("user_id");
      dataProject(user_id);
    });
  }

  void _getAddressFromLatLng(var latitude, longgitude) async {
    try {
      List<Placemark> p =
          await geolocator.placemarkFromCoordinates(latitude, longgitude);

      Placemark place = p[0];

      setState(() {
        address = "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  //inislisasi state
  @override
  void initState() {
    super.initState();
    //show modal detail project
    getDatapref();
    //_showPersBottomSheetCallBack = _showBottomSheet;

    _scrollController.addListener(() {


      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMore(user_id);
      }
    });
  }
}

//
// //------------bottom sheet--------
//   void _showModalSheet(var index) {
//     showModalBottomSheet(
//         context: context,
//         builder: (builder) {
//           return Container(
//             height: MediaQuery.of(context).size.height - 40,
//             child: new Card(
//               elevation: 1,
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Container(
//                       margin: EdgeInsets.all(20),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           //project
//                           Text(
//                             "Event",
//                             style: TextStyle(
//                               fontFamily: "OpenSans",
//                               color: textColor1,
//                               fontSize: 20,
//                             ),
//                           ),
//
//                           new Divider(
//                             color: Colors.black38,
//                           ),
//
//                           _detailproject(index),
//                           _buildstardate(index),
//                           _buildenddate(index),
//
//                           _buildlocation(index),
//                           _budgetAwal(index),
//                           _budgetsisa(index),
//
//                           //team
//                           Text(
//                             "Members",
//                             style: TextStyle(
//                               fontFamily: "OpenSans",
//                               color: textColor1,
//                               fontSize: 20,
//                             ),
//                           ),
//                           new Divider(
//                             color: Colors.black38,
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             width: double.infinity,
//                             height: 200,
//                             child: _loading == true
//                                 ? Center(
//                                     child: CircularProgressIndicator(),
//                                   )
//                                 : ListView.builder(
//                                     itemCount: _projects['data'][index]
//                                             ['members']
//                                         .length,
//                                     scrollDirection: Axis.vertical,
//                                     itemBuilder: (context, index_member) {
//                                       return _buildteam(index_member, index);
//                                     }),
//                           ),
//
//                           //Task
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Text(
//                             "Task",
//                             style: TextStyle(
//                               fontFamily: "OpenSans",
//                               color: textColor1,
//                               fontSize: 20,
//                             ),
//                           ),
//                           new Divider(
//                             color: Colors.black38,
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           _buildTask(index)
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         });
//   }
//
//   void _showBottomSheet() {
//     setState(() {
//       _showPersBottomSheetCallBack = null;
//     });
//
//     _scaffoldKey.currentState
//         .showBottomSheet((context) {
//           return new Container(
//             height: 100,
//             child: new Center(
//               child: new Text("Hi BottomSheet"),
//             ),
//           );
//         })
//         .closed
//         .whenComplete(() {
//           if (mounted) {
//             setState(() {
//               _showPersBottomSheetCallBack = _showBottomSheet;
//             });
//           }
//         });
//   }
//
//
//
// //widget event name
//   Widget _detailproject(index) {
//     return Container(
//       child: Row(
//         children: <Widget>[
//           //container image
//           Container(
//             child: CircleAvatar(
//               backgroundColor: Colors.white,
//               radius: 30,
//               child: Icon(
//                 Icons.label,
//                 size: 30,
//                 color: Colors.black38,
//               ),
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(left: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   "Title Event",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   "${_projects['data'][index]['title']}",
//                   style: TextStyle(
//                     color: Colors.black38,
//                     fontSize: 15,
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildstardate(index) {
//     return Container(
//       child: Row(
//         children: <Widget>[
//           //container image
//           Container(
//             child: CircleAvatar(
//               backgroundColor: Colors.white,
//               radius: 30,
//               child: Icon(
//                 Icons.access_time_outlined,
//                 size: 30,
//                 color: Colors.black38,
//               ),
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(left: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   "Start Date",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   "${_projects['data'][index]['start_date']}",
//                   style: TextStyle(
//                     color: Colors.black38,
//                     fontSize: 15,
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildlocation(index) {
//     return Container(
//       child: Row(
//         children: <Widget>[
//           //container image
//           Container(
//             child: CircleAvatar(
//               backgroundColor: Colors.white,
//               radius: 30,
//               child: Icon(
//                 Icons.location_on,
//                 size: 30,
//                 color: Colors.black38,
//               ),
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(left: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   "Location",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   "${_projects['data'][index]['city']['name']}",
//                   style: TextStyle(
//                     color: Colors.black38,
//                     fontSize: 15,
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildenddate(index) {
//     return Container(
//       child: Row(
//         children: <Widget>[
//           //container image
//           Container(
//             child: CircleAvatar(
//               backgroundColor: Colors.white,
//               radius: 30,
//               child: Icon(
//                 Icons.access_time_rounded,
//                 size: 30,
//                 color: Colors.black38,
//               ),
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(left: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   "End Date",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   "${_projects['data'][index]['end_date']}",
//                   style: TextStyle(
//                     color: Colors.black38,
//                     fontSize: 15,
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   //
//   Widget _budgetAwal(index) {
//     return Container(
//       child: Row(
//         children: <Widget>[
//           //container image
//           Container(
//             child: CircleAvatar(
//               backgroundColor: Colors.white,
//               radius: 30,
//               child: Icon(
//                 Icons.monetization_on,
//                 size: 30,
//                 color: Colors.black38,
//               ),
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(left: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   "Balance",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   "IDR ${_projects['data'][index]['budget_summary']['balance']}",
//                   style: TextStyle(
//                     color: Colors.black38,
//                     fontSize: 15,
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _budgetsisa(index) {
//     return Container(
//       child: Row(
//         children: <Widget>[
//           //container image
//           Container(
//             child: CircleAvatar(
//               backgroundColor: Colors.white,
//               radius: 30,
//               child: Icon(
//                 Icons.monetization_on_outlined,
//                 size: 30,
//                 color: Colors.black38,
//               ),
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(left: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   "Remaining budget",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   "IDR ${_projects['data'][index]['budget_summary']['balance'] - _projects['data'][index]['budget_summary']['total_expense']}",
//                   style: TextStyle(
//                     color: Colors.black38,
//                     fontSize: 15,
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTask(index) {
//     return Container(
//       width: double.infinity,
//       child: Center(
//         child: Column(
//           children: <Widget>[
//             new CircularPercentIndicator(
//               radius: 120.0,
//               lineWidth: 13.0,
//               animation: true,
//               percent: _projects['data'][index]['progress'] / 100,
//               center: new Text(
//                 "${_projects['data'][index]['progress']}%",
//                 style:
//                     new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
//               ),
//               footer: new Text(
//                 "Progress in Project",
//                 style:
//                     new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
//               ),
//               circularStrokeCap: CircularStrokeCap.round,
//               progressColor: baseColor,
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Container(
//               child: new RaisedButton(
//                 textColor: Colors.white,
//                 color: btnColor1,
//                 onPressed: () {
//                   Navigator.pop(context);
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => Tabstasks(
//                                 task: _projects['data'][index].toString(),
//                                 id: index.toString(),
//                               )));
//                 },
//                 child: new Text("Task"),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//   //------ widget project----
//   // Widget _buildproject(index) {
//   //   return Center(
//   //     child: Container(
//   //         width: double.infinity,
//   //         child: Card(
//   //           elevation: 1,
//   //           child: Column(
//   //             crossAxisAlignment: CrossAxisAlignment.start,
//   //             children: [
//   //               Container(
//   //                 margin: EdgeInsets.all(10),
//   //                 child: Row(
//   //                   children: <Widget>[
//   //
//   //                     Expanded(
//   //                       flex: 1,
//   //                       child: Container(
//   //                         margin: EdgeInsets.only(right: 5, left: 5, top: 15),
//   //                         child: Column(
//   //                           crossAxisAlignment: CrossAxisAlignment.start,
//   //                           mainAxisAlignment: MainAxisAlignment.start,
//   //                           children: <Widget>[
//   //                             SizedBox(
//   //                               height: 10,
//   //                             ),
//   //                             Text(
//   //                               "${_projects['data'][index]['title']}",
//   //                               style: TextStyle(
//   //                                   fontSize: 18,
//   //                                   color: Colors.black87,
//   //                                   fontWeight: FontWeight.bold),
//   //                             ),
//   //                             SizedBox(
//   //                               height: 5,
//   //                             ),
//   //                             Text(
//   //                               "${_projects['data'][index]['city']['name']}",
//   //                               style: TextStyle(
//   //                                   fontSize: 15, color: Colors.black38),
//   //                             ),
//   //                             SizedBox(
//   //                               height: 15,
//   //                             ),
//   //                             Text(
//   //                               "IDR ${_projects['data'][index]['budget_summary']['balance']}",
//   //                               style: TextStyle(
//   //                                   fontSize: 15, color: Colors.green),
//   //                             ),
//   //                             SizedBox(
//   //                               height: 10,
//   //                             ),
//   //                             Container(
//   //                                 width: double.infinity,
//   //                                 height: 40,
//   //                                 child: Row(
//   //                                   mainAxisAlignment: MainAxisAlignment.end,
//   //                                   crossAxisAlignment: CrossAxisAlignment.end,
//   //                                   children: <Widget>[
//   //                                     //button detail
//   //                                     new RaisedButton(
//   //                                       padding: const EdgeInsets.all(8.0),
//   //                                       textColor: Colors.white,
//   //                                       color: btnColor1,
//   //                                       onPressed: () {
//   //                                         _showModalSheet(index);
//   //                                       },
//   //                                       child: new Text("Detail"),
//   //                                     ),
//   //
//   //                                     //button budgeting
//   //
//   //                                     Container(
//   //                                       margin: EdgeInsets.only(left: 5),
//   //                                       child: new OutlineButton(
//   //                                         onPressed: () {
//   //                                           Navigator.push(
//   //                                               context,
//   //                                               MaterialPageRoute(
//   //                                                   builder: (context) => budgetproject(
//   //                                                       event_id: _projects['data']
//   //                                                               [index]['id']
//   //                                                           .toString(),
//   //                                                       title_event: _projects['data']
//   //                                                           [index]['title'],
//   //                                                       active_budget:
//   //                                                           _projects['data'][index]['budget_effective_date']
//   //                                                               .toString(),
//   //                                                       expired_budget:
//   //                                                           _projects['data'][index]['budget_expire_date']
//   //                                                               .toString(),
//   //                                                       balance: _projects['data']
//   //                                                                       [index]
//   //                                                                   ['budget_summary']
//   //                                                               ['balance']
//   //                                                           .toString(),
//   //                                                       remaining_budget: "${_projects['data'][index]['budget_summary']['balance'] - _projects['data'][index]['budget_summary']['total_expense']}")));
//   //                                         },
//   //                                         child: Text(
//   //                                           'Budget',
//   //                                           style: TextStyle(color: btnColor1),
//   //                                         ),
//   //                                       ),
//   //                                     )
//   //                                   ],
//   //                                 ))
//   //                           ],
//   //                         ),
//   //                       ),
//   //                     )
//   //                   ],
//   //                 ),
//   //               ),
//   //             ],
//   //           ),
//   //         )),
//   //   );
//   // }
