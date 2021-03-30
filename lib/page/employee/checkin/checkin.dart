import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hrdmagenta/page/employee/checkin/maps.dart';
import 'package:hrdmagenta/utalities/alert_dialog.dart';
import 'package:hrdmagenta/validasi/validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Checkin extends StatefulWidget {
  @override
  _CheckinState createState() => _CheckinState();
}

class _CheckinState extends State<Checkin> {
  ///variable
  File _image;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress;
  var Cremark = new TextEditingController();
  var time, _lat, _long, _employee_id, _check_in, _clock_in;
  String base64;
  Validasi validator = new Validasi();
  List typeList;
  String _type, _type_absent;

  ///widge widget
  //Widger photo default
  Widget _buildPhoto() {
    return Container(
      child: InkWell(
        onTap: () {
          aksesCamera();
        },
        child: Container(
          margin: EdgeInsets.only(top: 15),
          child: Image.asset("assets/photo.png",
              width: 200, height: 200, fit: BoxFit.fill),
        ),
      ),
    );
  }


  // -------end photo default-----
  //Widget text
  Widget _buildText() {
    return Container(
      child: Container(
        margin: EdgeInsets.all(15.0),
        child: Text(
          "Take Your Photo",
          style: TextStyle(fontSize: 30, color: Colors.black38),
        ),
      ),
    );
  }

  //build remark
  Widget _buildremark() {
    return Container(
      margin: EdgeInsets.only(left: 25, right: 20),
      child: TextFormField(
        controller: Cremark,
        cursorColor: Theme.of(context).cursorColor,
        maxLength: 100,
        decoration: InputDecoration(
          icon: Icon(
            Icons.lock,
            color: Colors.black12,
          ),
          labelText: 'Remark(Optional)',
          labelStyle: TextStyle(
            color: Colors.black38,
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black38,
          )),
        ),
      ),
    );
  }


  void _startJam() {
    Timer.periodic(new Duration(seconds: 1), (_) {
      var tgl = new DateTime.now();
      var formatedjam = new DateFormat.Hms().format(tgl);
      setState(() {
        time = formatedjam;
      });
    });
  }


  Widget _buildtime() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 20,
          margin: EdgeInsets.only(left: 25),
          child: TextFormField(
            cursorColor: Theme.of(context).cursorColor,
            decoration: InputDecoration(
              icon: Icon(
                Icons.timer,
                color: Colors.black12,
                size: 30,
              ),
              labelText: '$time',
              labelStyle: TextStyle(
                color: Colors.black38,
              ),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildtypeabsen() {
    return Container(
      margin: EdgeInsets.only(left: 25, right: 20),
      width: double.infinity,
      padding: const EdgeInsets.all(0.0),
      child: Row(
        children: [
          Container(
            child: Icon(
              Icons.merge_type,
              color: Colors.black12,
              size: 30,
            ),
          ),
          Container(
            width: 300,
            margin: EdgeInsets.only(left: 10),
            child: DropdownButton<String>(
              isExpanded: true,

              value: _type_absent,
              //elevation: 5,
              style: TextStyle(color: Colors.black),

              items: <String>[
                'In',
                'Sick',
                'Permission',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: Text(
                "In",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              onChanged: (String value) {
                setState(() {
                  _type_absent = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildLocation() {
    return Container(
      margin: EdgeInsets.only(left: 25),
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
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Maps(
                                  address: _currentAddress,
                                  longitude: _long,
                                  latitude: _lat,
                                )));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Location",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        if (_currentPosition != null && _currentAddress != null)
                          Text(
                            _currentAddress,
                            style: TextStyle(color: Colors.black38),
                          ),
                      ],
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

  //Widger photo
  Widget _buildfingerprint() {
    return InkWell(
      onTap: () {
        upload();
      },
      child: Container(
        width: 70,
        height: 70,
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Container(
            margin: EdgeInsets.all(15.0),
            child: Image.asset(
              "assets/fingerprint.png",
            ),
          ),
        ),
      ),
    );
  }

  ///main context
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black87, //modify arrow color from here..
        ),
        backgroundColor: Colors.white,
        title: new Text(
          "Check In",
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: _image == null
                      ? _buildPhoto()
                      : new Image.file(_image,
                          width: 200, height: 200, fit: BoxFit.fill),
                ),
                _buildText(),
                SizedBox(
                  height: 15,
                ),
                _buildtypeabsen(),
                SizedBox(
                  height: 15,
                ),
                _buildLocation(),
                SizedBox(
                  height: 10,
                ),
                _buildremark(),
                SizedBox(
                  height: 10,
                ),
                _buildtime(),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        _buildfingerprint(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future upload() async {
    if (_check_in == true) {
      alert_info(context, "You have been check in", "Back");
    } else {
      // if (_image==null){

      // }else{
      var date = DateFormat("yyyy:MM:dd").format(DateTime.now());
      validator.validation_checkin(
        context,
        base64.toString(),
        Cremark.text,
        _lat.toString().trim(),
        _long.toString().trim(),
        _employee_id,
        date.toString(),
        time.toString(),
      );
      //Toast.show("${_long.toString()}", context);

    }
  }

  ///fucntion
  //akses kamera
  aksesCamera() async {
    print('Picker is Called');
    File img = (await ImagePicker.pickImage(source: ImageSource.camera));
    if (img != null) {
      setState(() {
        _image = File(img.path);
        base64 = base64Encode(_image.readAsBytesSync());
      });
    }
  }

  //get curret locatin lat dan long
  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _lat = _currentPosition.latitude;
        _long = _currentPosition.longitude;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  //convert lat dan long to address
  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  _getDataPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _employee_id = sharedPreferences.getString("user_id");
      _check_in = sharedPreferences.getBool("check_in");
      _clock_in = sharedPreferences.getString("clock_in");
    });
  }



  @override
  void dispose() {
    super.dispose();
    //time.cancel();
  }


  @override
  void initState() {
    super.initState();
    _startJam();
    _getDataPref();
    _getCurrentLocation();

  //double distanceInMeters = Geolocator().distanceBetween(52.2165157, 6.9437819, 52.3546274, 4.8285838);

  }
}
