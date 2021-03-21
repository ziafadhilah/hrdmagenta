import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hrdmagenta/page/opening/wellcome.dart';
import 'package:hrdmagenta/utalities/color.dart';
import 'package:hrdmagenta/utalities/constants.dart';


class SplassScreen extends StatefulWidget {
  @override
  _SplassScreenState createState() => _SplassScreenState();
}

class _SplassScreenState extends State<SplassScreen> {
  void initState(){
    startTimer();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        body:Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,

          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
               splassscreen,
                Text("Magenta HRD",
                style: TextStyle(
                  color: baseColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: "OpenSans"
                ),
                )

                // Text("tes")
              ],

            ),
          ),
        ),
      ),
    );
  }
  Future<Timer> startTimer() async {
    return Timer(Duration(seconds: 6), onDone);
  }
  void onDone() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>Wellcome()
    ));
  }

}
