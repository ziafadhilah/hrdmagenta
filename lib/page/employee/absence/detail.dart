import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hrdmagenta/page/employee/absence/map_absence.dart';
import 'package:hrdmagenta/utalities/constants.dart';
import 'package:hrdmagenta/utalities/textstyle.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
class detail_absence extends StatefulWidget {
  detail_absence({
    this.status,
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
    this.rejection_note




});

  var status,employee,type,date,time,
      latitude,longitude,image,approved_by,approved_on,rejected_by,rejected_on,note,rejection_note,approval_note;
  _detail_absenceState createState() => _detail_absenceState();
}

class _detail_absenceState extends State<detail_absence> {
  Position _currentPosition;
  String _currentAddress;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  var _time;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black87, //modify arrow color from here..
        ),

        backgroundColor: Colors.white,
        title: new Text("Absence Detail",
          style: TextStyle(color: Colors.black87),
        ),
      ),

      body :Container(
        margin: EdgeInsets.only(left: 15,right: 15,top: 15),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            _buildProfile(),
            _buildType(),
            _buildDate(),
            _buildTime(),
            _buildAdress(),
            SizedBox(height: 10,),
            _buildgridtext(),
            _buildgrid(),




          ],
        ),

      ),
    );

  }
  //convert lat dan long to address
  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          double.parse(widget.latitude),double.parse(widget.longitude));

      Placemark place = p[0];

      setState(() {
        _currentAddress =
        "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }
  Widget _buildgridtext(){
    return Container(
      height: 20,
      child: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          //photos
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text("Photo",
              style: titleAbsence,
            )

          ),

          //map
          Container(
              margin: EdgeInsets.only(right: 10,left: 10),
              child: Text("Location",
                style: titleAbsence,
              ),
          ),


        ],

      ),
    );
  }

  Widget _buildgrid(){
    return Expanded(
      child: Container(
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            //photos
            Container(
              child: _buildphotos(),

            ),

           //map
            Container(
                margin: EdgeInsets.only(right: 10,left: 10),
                child: _builmap()
            ),


          ],

        ),
      ),
    );
  }




  //widget profile
  Widget _buildProfile(){
    return Container(
      margin: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          Container(
      child:CircleAvatar(
        child: male_avatar,
      backgroundColor: Colors.transparent,
        radius: 40,)

          ),
          Container(
            margin: EdgeInsets.only(left: 10,right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start ,
              children: <Widget>[
                Container(
                  child: Text("Rifan Hidayat",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold
                    ),

                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  child: Text("Employee",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black38,

                    ),
                  ),
                ),



                //detail acount


              ],
            ),
          )//Container

        ],
      ),
    );
  }
  //widget type

Widget _buildType(){
    return Container(
      margin: EdgeInsets.only(left: 5),
      width: double.infinity,
      height: 80,
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
              child: Icon(Icons.login,
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
                    child: Text("Type",
                      style: titleAbsence,

                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    child: Text("${widget.type}",
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
  Widget _buildDate(){
    return Container(
      margin: EdgeInsets.only(left: 5),
      width: double.infinity,
      height: 80,
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
              child: Icon(Icons.date_range,
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
                    child: Text("Date",
                      style: titleAbsence,

                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    child: Text("${widget.date}",
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
  Widget _buildAdress(){
    return Container(
      margin: EdgeInsets.only(left: 5),
      width: double.infinity,
      height: 80,
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
              child: Icon(Icons.location_on,
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
                    child: Text("Adress",
                      style: titleAbsence,

                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    child: _currentAddress==null?Text(""):Text("$_currentAddress",
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
  Widget _buildTime(){
    return Container(
      margin: EdgeInsets.only(left: 5),
      width: double.infinity,
      height: 80,
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
              child: Icon(Icons.access_time_rounded,
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
                    child: Text("Time",
                      style: titleAbsence,

                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    child: Text(_time.toString(),
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
  Widget _builmap(){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => Map_absence(
              latitude: widget.latitude,
              longitude: widget.longitude,

            )
        ));

      },
      child: Container(
        child:Center(
          child: SizedBox(
            width: 300.0,
            height: 300.0,
            child: GoogleMap(
                initialCameraPosition:
                CameraPosition(
                    target: LatLng( double.parse(widget.latitude),double.parse(widget.longitude)),
                    zoom: 11.0),
                markers:
                Set<Marker>.of(<Marker>[
                  Marker(
                    markerId: MarkerId(
                        "1"),
                    position: LatLng(
                        double.parse(widget.latitude),
                        double.parse(widget.longitude)),

                  ),
                ]),
                gestureRecognizers: <
                    Factory<
                        OneSequenceGestureRecognizer>>[
                  Factory<
                      OneSequenceGestureRecognizer>(
                        () =>
                        ScaleGestureRecognizer(),
                  ),
                ].toSet()),
          ),
        )
      ),
    );


  }

  Widget _buildphotos(){
    return Hero(
      tag: "avatar-1",
      child: Container(
        margin: EdgeInsets.only(left: 10),
        color: Colors.black87,
        height: double.infinity,
        child: InkWell(
          onTap: (){
            Navigator.pushNamed(context, "photoview_employee-page");

          },
          child: Image.asset("assets/absen.jpeg",
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,

          ),
        ),// tambahkan property berikut

      ),
    );
  }











@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAddressFromLatLng();
    _time = DateFormat('hh:mm:ss').format(DateTime.parse(widget.time));
  }

}
