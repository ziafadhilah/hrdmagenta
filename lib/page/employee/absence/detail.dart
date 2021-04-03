import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:format_indonesia/format_indonesia.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hrdmagenta/page/employee/absence/map_absence.dart';
import 'package:hrdmagenta/utalities/constants.dart';
import 'package:hrdmagenta/utalities/font.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';

class detail_absence extends StatefulWidget {
  detail_absence(
      {this.status,
      this.employee,
      this.date,
      this.time,
      this.latitude,
      this.image,
      this.type,
      this.longitude,
      this.note,
      this.approval_note,
      this.approved_by,
      this.approved_on,
      this.rejected_by,
      this.rejected_on,
      this.rejection_note,
      this.firts_name_employee,
      this.last_name_employee,
      this.work_placement,
      this.category});


  var status,
      employee,
      type,
      date,
      time,
      latitude,
      longitude,
      image,
      approved_by,
      approved_on,
      rejected_by,
      rejected_on,
      note,
      rejection_note,
      approval_note,
      firts_name_employee,
      last_name_employee,
      work_placement,
      category;

  _detail_absenceState createState() => _detail_absenceState();
}

class _detail_absenceState extends State<detail_absence> {
  Position _currentPosition;
  String _currentAddress;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  var _time,_date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black87, //modify arrow color from here..
        ),
        backgroundColor: Colors.white,
        title: new Text(
          "Attendance Detail",
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 15),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                _buildProfile(),
                _buildAbsenceType(),
                _buildAbsencecategory(),
                _buildDate(),
                _buildTime(),
                _buildRemark(),
                _buildAdress(),
                _buildgridtext(),
                SizedBox(
                  height: 10,
                ),
                _buildgrid(),

                SizedBox(
                  height: 10,
                ),
                Container(
                    child: widget.status == "pending"
                        ? Text("")
                        : widget.status == "rejected"
                            ? _buildrejected()
                            : _buildapproved()),
                //_buildrejected(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //convert lat dan long to address
  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          double.parse(widget.latitude), double.parse(widget.longitude));
      Placemark place = p[0];
      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  //widget profile
  Widget _buildProfile() {
    return Container(
      margin: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          Container(
              child: CircleAvatar(
            child: male_avatar,
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
                    "${widget.firts_name_employee} ${widget.last_name_employee}",
                    style: TextStyle(
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
                    "${widget.work_placement}",
                    style: TextStyle(
                      fontSize: 15,
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

  //widget type
  Widget _buildAbsenceType() {
    return Container(
      margin: EdgeInsets.only(left: 5),
      width: double.infinity,
      height: 80,
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
                child: widget.type == "check in"
                    ? Icon(
                        Icons.login,
                        color: Colors.black38,
                        size: 40,
                      )
                    : Icon(
                        Icons.logout,
                        color: Colors.black38,
                        size: 40,
                      )),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Type",
                      style: titleAbsence,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(
                      "${widget.type}",
                      style: subtitleAbsence,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRemark() {
    return Container(
      margin: EdgeInsets.only(left: 5),
      width: double.infinity,
      height: 80,
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
                child: Icon(
              Icons.description,
              color: Colors.black38,
              size: 40,
            )),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Remark",
                      style: titleAbsence,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: (widget.note == "null") ?Text("-",
                      style: titleAbsence,
                    ): Text(
                      "${widget.note}",
                      style: subtitleAbsence,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget _buildAbsencecategory() {
    return Container(
      margin: EdgeInsets.only(left: 5),
      width: double.infinity,
      height: 80,
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
              child: Icon(
                Icons.category,
                color: Colors.black38,
                size: 40,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Category",
                      style: titleAbsence,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(
                      "${widget.category}",
                      style: subtitleAbsence,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

//widget date
  Widget _buildDate() {
    return Container(
      margin: EdgeInsets.only(left: 5),
      width: double.infinity,
      height: 80,
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
              child: Icon(
                Icons.date_range,
                color: Colors.black38,
                size: 40,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Date",
                      style: titleAbsence,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(
                      "${_date}",
                      style: subtitleAbsence,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

//widget adress
  Widget _buildAdress() {
    return Container(
      margin: EdgeInsets.only(left: 5),
      width: double.infinity,
      height: 80,
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
              child: Icon(
                Icons.location_on,
                color: Colors.black38,
                size: 40,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Address",
                      style: titleAbsence,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: _currentAddress == null
                        ? Text("")
                        : Text(
                            "$_currentAddress",
                            style: subtitleAbsence,
                          ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTime() {
    return Container(
      margin: EdgeInsets.only(left: 5),
      width: double.infinity,
      height: 80,
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
              child: Icon(
                Icons.access_time_rounded,
                color: Colors.black38,
                size: 40,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Time",
                      style: titleAbsence,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(
                      _time.toString(),
                      style: subtitleAbsence,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildgridtext() {
    return Container(
     height: 20,

      child: GridView.count(
        crossAxisCount: 2,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        primary: true,
        children: <Widget>[
          //photos
          Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                "Photo",
                style: titleAbsence,
              )),
          //map

          Container(
            margin: EdgeInsets.only(right: 10, left: 10),
            child: Text(
              "Location",
              style: titleAbsence,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildgrid() {
    return Container(
      height: 200,
      child: GridView.count(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        primary: true,
        crossAxisCount: 2,
        children: <Widget>[
          // photos
          Container(
            child: _buildphotos(),
          ),
          //map
          Container(
              margin: EdgeInsets.only(right: 10, left: 10), child: _builmap()),
        ],
      ),
    );
  }

  Widget _builmap() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Map_absence(
                      latitude: widget.latitude,
                      longitude: widget.longitude,
                    )));
      },
      child: Container(
          child: Center(
        child: SizedBox(
          width: 300.0,
          height: 300.0,
          child: GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(double.parse(widget.latitude),
                      double.parse(widget.longitude)),
                  zoom: 11.0),
              markers: Set<Marker>.of(<Marker>[
                Marker(
                  markerId: MarkerId("1"),
                  position: LatLng(double.parse(widget.latitude),
                      double.parse(widget.longitude)),
                ),
              ]),
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                Factory<OneSequenceGestureRecognizer>(
                  () => ScaleGestureRecognizer(),
                ),
              ].toSet()),
        ),
      )),
    );
  }

  Widget _buildphotos() {
    return Hero(
      tag: "avatar-1",
      child: Container(
        margin: EdgeInsets.only(left: 10),
        color: Colors.black87,
        height: double.infinity,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, "photoview_employee-page");
          },
          child: Image.asset(
            "assets/absen.jpeg",
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
        ), // tambahkan property berikut
      ),
    );
  }


  Widget _buildrejected() {
    return Container(
        child: widget.category != "Check In"
            ? Column(
                children: <Widget>[
                  Container(
                    color: Colors.redAccent.withOpacity(0.5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.redAccent,
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 2),
                          child: Text(
                            "REJECTED",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _buildrejectedby(),
                  _buildrejecteddate(),
                 // _buildrejectedon(),
                  _buildrejectednote()
                ],
              )
            : Text(""));
  }

  Widget _buildrejectedby() {
    return Container(
      margin: EdgeInsets.only(left: 5),
      width: double.infinity,
      height: 80,
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
              child: Icon(
                Icons.person,
                color: Colors.black38,
                size: 40,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Rejected By",
                      style: titleAbsence,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(
                      "${widget.rejected_by}",
                      style: subtitleAbsence,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildrejecteddate() {
    return Container(
      margin: EdgeInsets.only(left: 5),
      width: double.infinity,
      height: 80,
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
              child: Icon(
                Icons.date_range,
                color: Colors.black38,
                size: 40,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Rejected at",
                      style: titleAbsence,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(
                      "${widget.rejected_on}",
                      style: subtitleAbsence,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildrejectedon() {
    return Container(
      margin: EdgeInsets.only(left: 5),
      width: double.infinity,
      height: 80,
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
              child: Icon(
                Icons.timer_rounded,
                color: Colors.black38,
                size: 40,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Rejected On",
                      style: titleAbsence,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(
                      "${widget.rejected_on}",
                      style: subtitleAbsence,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildrejectednote() {
    return Container(
      margin: EdgeInsets.only(left: 5),
      width: double.infinity,
      height: 80,
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
              child: Icon(
                Icons.description,
                color: Colors.black38,
                size: 40,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Remarks",
                      style: titleAbsence,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: widget.rejection_note == "null"
                        ? Text(
                            "-",
                            style: subtitleAbsence,
                          )
                        : Text(
                            "${widget.rejection_note}",
                            style: subtitleAbsence,
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

  ///approved
  Widget _buildapproved() {
    return Container(
        child: widget.category != "Check In"
            ? Column(
                children: <Widget>[
                  Container(
                    color: Colors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.green,
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 2),
                          child: Text(
                            "APPROVED",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _buildapprovedby(),
                  _buildapproveddate(),
                //  _buildapprovedon(),
                  _buildapprovalnote()
                ],
              )
            : Text(""));
  }

  Widget _buildapprovedby() {
    return Container(
      margin: EdgeInsets.only(left: 5),
      width: double.infinity,
      height: 80,
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
              child: Icon(
                Icons.person,
                color: Colors.black38,
                size: 40,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Approved By",
                      style: titleAbsence,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(
                      "${widget.approved_by}",
                      style: subtitleAbsence,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildapproveddate() {
    return Container(
      margin: EdgeInsets.only(left: 5),
      width: double.infinity,
      height: 80,
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
              child: Icon(
                Icons.date_range,
                color: Colors.black38,
                size: 40,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Approved at",
                      style: titleAbsence,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(
                      "${widget.approved_on}",
                      style: subtitleAbsence,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildapprovedon() {
    return Container(
      margin: EdgeInsets.only(left: 5),
      width: double.infinity,
      height: 80,
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
              child: Icon(
                Icons.timer_rounded,
                color: Colors.black38,
                size: 40,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Approved On",
                      style: titleAbsence,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(
                      "${widget.approved_on}",
                      style: subtitleAbsence,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildapprovalnote() {
    return Container(
      margin: EdgeInsets.only(left: 5),
      width: double.infinity,
      height: 80,
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
              child: Icon(
                Icons.description,
                color: Colors.black38,
                size: 40,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Remarks",
                      style: titleAbsence,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: widget.approval_note == "null"
                        ? Text(
                            "-",
                            style: subtitleAbsence,
                          )
                        : Text(
                            "${widget.approval_note}",
                            style: subtitleAbsence,
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAddressFromLatLng();
    var waktu = Waktu();
    print(waktu.yMMMMEEEEd());

    _time = DateFormat('hh:mm:ss').format(DateTime.parse(widget.time));
    // _date=DateFormat(
    //     "EEEE, d MMMM yyyy","id_ID"
    // ).format(DateTime.now());

   _date = Waktu(DateTime.parse(widget.date)).yMMMd();


  }
}
