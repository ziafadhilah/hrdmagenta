import 'package:flutter/material.dart';
import 'package:hrdmagenta/page/admin/l/home/navbar.dart';

import 'package:hrdmagenta/page/employee/Home/navbar.dart';
import 'package:hrdmagenta/utalities/color.dart';
import 'package:hrdmagenta/utalities/constants.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Wellcome extends StatefulWidget{

  @override
  _WellcomeState createState() => _WellcomeState();
}

enum statusLogin { signInemployee, notSignIn,signInadmin }
class _WellcomeState extends State<Wellcome> {
  statusLogin _loginStatus = statusLogin.notSignIn;


  Widget _buildImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
       wellcome

      ],
    );
  }

  Widget _buildText() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10,),
          Text("WELLCOME",
            textAlign: TextAlign.left,
            style: TextStyle(

                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
                fontSize: 25
            ),

          ),
          SizedBox(height: 5,),
          Text("To Magenta HRD",
            textAlign: TextAlign.left,
            style: TextStyle(

                color: baseColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
                fontSize: 15
            ),

          )

        ],
      ),
    );
  }


  Widget _buoldbtnadmin() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: .0),
      width: double.infinity,
      // child: RaisedButton(
      //   onPressed: () {},
      //   child: Text('Enabled Button', style: TextStyle(fontSize: 20)),
      // ),

      child: RaisedButton(

        onPressed: () {
          // Navigator.push(context, MaterialPageRoute(
          //     builder: (context) => LoginAdmin()
          // ));
          Navigator.pushNamed(context, "login_admin-page");
        },
        padding: EdgeInsets.all(12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.0),
        ),
        color: btnColor1,

        child: Text(
          'Login as Admin',
          textAlign: TextAlign.left,
          style: TextStyle(

            color: Colors.white,

            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buoldbtemployee() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
        child:OutlineButton(
          padding: EdgeInsets.all(12.0),
          onPressed: () {
                // Navigator.push(context, MaterialPageRoute(
                //     builder: (context) => LoginEmployee()
                // ));
            Navigator.pushNamed(context, "login_employee-page");
          },
          child: Text(
            "Login as Employee",
            style: TextStyle(color: btnColor1),
          ),
        )

    );
  }


  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case statusLogin.notSignIn:
        return Scaffold(
          body: Container(
            color: Colors.white,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Stack(

                children: <Widget>[
                  _buildText(),
                  Container(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildImage(),
                    ],
                  )),
                  Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _buoldbtnadmin(),
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.only(bottom: 35),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _buoldbtemployee(),
                        ],
                      )),


                ],
              ),
            ),
          ),

        );
        break;
      case statusLogin.signInemployee:
        return NavBarEmployee();
        break;
      case statusLogin.signInadmin:
        return NavBarAdmin();
        break;
    }
  }
  getDataPref() async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      int nvalue = sharedPreferences.getInt("value");
      _loginStatus = nvalue == 1 ? statusLogin.signInemployee : nvalue==2? statusLogin.signInadmin:statusLogin.notSignIn;
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataPref();
  }


}