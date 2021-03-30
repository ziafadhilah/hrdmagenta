import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hrdmagenta/model/map.dart';
import 'package:hrdmagenta/utalities/color.dart';
import 'package:hrdmagenta/utalities/thema.dart';
import 'package:permission_handler/permission_handler.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();

  Maps({this.address, this.longitude, this.latitude});

  var address, latitude, longitude;
}

class _MapsState extends State<Maps> {
  GoogleMapController _controller;
  Position position;

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

  Future<void> getPermission() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);

    if (permission == PermissionStatus.denied) {
      await PermissionHandler()
          .requestPermissions([PermissionGroup.locationAlways]);
    }

    var geolocator = Geolocator();

    GeolocationStatus geolocationStatus =
        await geolocator.checkGeolocationPermissionStatus();

    switch (geolocationStatus) {
      case GeolocationStatus.denied:
        showToast('Access denied');
        break;
      case GeolocationStatus.disabled:
        showToast('Disabled');
        break;
      case GeolocationStatus.restricted:
        showToast('restricted');
        break;
      case GeolocationStatus.unknown:
        showToast('Unknown');
        break;
      case GeolocationStatus.granted:
        showToast('Accesss Granted');
        _getCurrentLocation();
    }
  }

  void _getCurrentLocation() async {
    Position res = await Geolocator().getCurrentPosition();
    setState(() {
      position = res;
      _child = _mapWidget();
    });
  }

  // void _setStyle(GoogleMapController controller) async {
  //   String value = await DefaultAssetBundle.of(context)
  //       .loadString('assets/map.json');
  //
  //   controller.setMapStyle(value);
  // }

  Set<Marker> _createMarker() {
    return <Marker>[
      Marker(
          markerId: MarkerId('home'),
          position: LatLng(-6.9032739, 107.5731172),
          icon: _sourceIcon,
          onTap: () {
            setState(() {
              _currentPinData = _sourcePinInfo;
              _pinPillPosition = 0;
            });
          })
    ].toSet();
  }

  Set<Circle> circles = Set.from([
    Circle(
        circleId: CircleId("1"),
        center: LatLng(-6.2081067, 106.7812203),
        radius: 4000,
        strokeColor: baseColor1,
        strokeWidth: 1)
  ]);

  void showToast(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  void initState() {
    getPermission();
    // _setSourceIcon();
    super.initState();
  }

  Widget _mapWidget() {
    return GoogleMap(
      mapType: MapType.normal,
      markers: _createMarker(),
      initialCameraPosition:
          CameraPosition(target: LatLng(-6.9032739, 107.5731172), zoom: 8.0),
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
        // _setStyle(controller);
        _setMapPins();
      },
      tiltGesturesEnabled: false,
      onTap: (LatLng location) {
        setState(() {
          _pinPillPosition = -100;
        });
      },
      onCameraMove: null,
      circles: circles,
    );
  }

  void _setMapPins() {
    _sourcePinInfo = PinData(
        locationName: "My Location",
        location: LatLng(-6.9032739, 107.5731172),
        //photo profile user
        avatarPath: "assets/driver.jpg",
        labelColor: Colors.blue);
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
        )
      ],
    ));
  }
}
