import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hrdmagenta/model/map.dart';
import 'package:hrdmagenta/utalities/color.dart';
import 'package:hrdmagenta/utalities/constants.dart';
import 'package:hrdmagenta/utalities/font.dart';

import 'package:permission_handler/permission_handler.dart';

class MapsProject extends StatefulWidget {
  @override
  _MapsProjectState createState() => _MapsProjectState();

  MapsProject(
      {
        this.longitude,
        this.latitude,
        this.projectNumber,
        this.venue

       });



  var
      latitude,
      venue,
      longitude,
      projectNumber;

}

class _MapsProjectState extends State<MapsProject> {
  GoogleMapController _controller;
  Position position;
  BitmapDescriptor companyIcon;
  Set<Circle> _circles = HashSet<Circle>();

  Widget _child = Center(
    child: Text('Loading...'),
  );
  BitmapDescriptor _sourceIcon;

  double _pinPillPosition = -100;

  PinData _currentPinData = PinData(
      pinPath: '',
      avatarPath: '',
      location: LatLng(0, 0),
      locationName: '',
      labelColor: Colors.grey);

  PinData _sourcePinInfo;

  // Future<void> getPermission() async {
  //   PermissionStatus permission = await PermissionHandl()
  //       .checkPermissionStatus(PermissionGroup.location);
  //
  //   if (permission == PermissionStatus.denied) {
  //     await PermissionHandler()
  //         .requestPermissions([PermissionGroup.locationAlways]);
  //   }
  //
  //   var geolocator = Geolocator();
  //
  //   GeolocationStatus geolocationStatus =
  //   await geolocator.checkGeolocationPermissionStatus();
  //
  //   switch (geolocationStatus) {
  //     case GeolocationStatus.denied:
  //       showToast('Access denied');
  //       break;
  //     case GeolocationStatus.disabled:
  //       showToast('Disabled');
  //       break;
  //     case GeolocationStatus.restricted:
  //       showToast('restricted');
  //       break;
  //     case GeolocationStatus.unknown:
  //       showToast('Unknown');
  //       break;
  //     case GeolocationStatus.granted:
  //       showToast('Accesss Granted');
  //       _getCurrentLocation();
  //   }
  // }

  void _getCurrentLocation() async {
    Position res = await Geolocator().getCurrentPosition();
    setState(() {
      position = res;
      _child = _mapWidget();
    });
  }

  Set<Marker> _createMarker() {
    return <Marker>[
      ///company marker
      ///user marker
      Marker(
          markerId: MarkerId('user'),
          position: LatLng(
              double.parse(widget.latitude), double.parse(widget.longitude)),
          ),
    ].toSet();
  }

  ///set raidus
  // Set<Circle> circles = Set.from([
  //   Circle(
  //       circleId: CircleId("1"),
  //       center: LatLng(-6.9529516, 107.6684227),
  //       radius: 20,
  //       strokeColor: baseColor1,
  //       fillColor: baseColor.withOpacity(0.25),
  //       strokeWidth: 1)
  // ]);

  void showToast(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,

        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void setSourceAndDestinationIcons() async {
    companyIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/home.png');
  }


  ///style map json
  void _setStyle(GoogleMapController controller) async {
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');

    controller.setMapStyle(value);
  }

  Widget _mapWidget() {
    return GoogleMap(
      mapType: MapType.normal,
      markers: _createMarker(),
      initialCameraPosition: CameraPosition(
          target: LatLng(
              double.parse(widget.latitude), double.parse(widget.longitude)),
          zoom: 16.0),
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
        // _setStyle(controller);

        // _setStyle(controller);
      },
      tiltGesturesEnabled: false,
      onTap: (LatLng location) {
        setState(() {
          _pinPillPosition = -100;
        });
      },
      onCameraMove: null,
      circles: _circles,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            _child,
            AnimatedPositioned(
              bottom: _pinPillPosition,
              right: 0,
              left: 0,
              duration: Duration(milliseconds: 200),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.all(20),
                  height: 70,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          blurRadius: 20,
                          offset: Offset.zero,
                          color: Colors.grey.withOpacity(0.5),
                        )
                      ]),
                ),
              ),
            ),
            new Positioned(
                top: MediaQuery.of(context).size.height * 0.6,
                child: new Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(40.0),
                          topRight: const Radius.circular(40.0),
                        )),
                    child: _info()))
          ],
        ));
  }

  Widget _info() {
    return Container(
      child: Container(
        child: Column(
          children: <Widget>[
            ///widget profile
            Container(
              child: Row(
                children: <Widget>[
                  // Container(
                  //   margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                  //   child: widget.profile_background == ""
                  //       ? CircleAvatar(
                  //       backgroundColor: Colors.transparent,
                  //       radius: 40,
                  //       child: widget.gender == "male"
                  //           ? employee_profile
                  //           : employee_profile)
                  //       : CircleAvatar(
                  //     radius: 40,
                  //     child: Icon(
                  //       Icons.person_pin,
                  //     ),
                  //   ),
                  // ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 50,right: 50,top: 50),
                          child: Text(
                            "${widget.projectNumber}",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        //detail acount
                      ],
                    ),
                  ) //Container
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 25, top: 20),
              //Row for time n location
              child: Row(
                children: <Widget>[
                  //container  icon location
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.location_on,
                            color: Colors.black12,
                            size: 30,
                          ),
                        ),
                        //container for name location
                        InkWell(
                          child: Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Alamat", style: subtitleMainMenu),
                                SizedBox(
                                  height: 10,
                                ),

                                Container(
                                  child: Text("${widget.venue}"),
                                )

                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

            ///widget location
          ],
        ),
      ),
    );
  }

  void _setCircles() {
    _circles.add(
      Circle(
          circleId: CircleId("0"),
          center: LatLng(double.parse(widget.longitude), double.parse(widget.longitude)),
          // center: LatLng(double.parse(widget.latmainoffice),
          //     double.parse(widget.longMainoffice)),
          radius: 20,
          strokeColor: baseColor1,
          fillColor: baseColor.withOpacity(0.25),
          strokeWidth: 1),
    );
  }

  @override
  void initState() {
 //   getPermission();
    // _setSourceIcon();
    super.initState();
    _setCircles();
  }
}
