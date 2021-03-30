import 'dart:convert';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hrdmagenta/model/notifacations.dart';
import 'package:hrdmagenta/page/employee/absence/tabmenu_absence.dart';
import 'package:hrdmagenta/page/employee/absence/tabmenu_absence_status.dart';
import 'package:hrdmagenta/page/employee/checkin/checkin.dart';
import 'package:hrdmagenta/page/employee/checkout/checkout.dart';
import 'package:hrdmagenta/page/employee/project/tabmenu_project.dart';
import 'package:hrdmagenta/services/api_clien.dart';
import 'package:hrdmagenta/utalities/color.dart';
import 'package:hrdmagenta/utalities/constants.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class HomeEmployee extends StatefulWidget{

  @override
  _HomeEmployeeState createState() => _HomeEmployeeState();
}

enum statusLogin { signIn, notSignIn }
class _HomeEmployeeState extends State<HomeEmployee>{

  final GlobalKey<ScaffoldState> scaffoldState =
  new GlobalKey<ScaffoldState>();

  final FirebaseMessaging _firebaseMessaging=FirebaseMessaging();
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
final List<Notif> ListNotif=[];
  Map _projects;
  bool _loading=true;
  var user_id;





  Widget _buildMenucheckin(){
    return Column(
      children: <Widget>[

        new Container(
          width: 70,
          height: 70,
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Checkin()
              ));

            },
            child: Card(
              elevation: 1,
              shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                margin:EdgeInsets.all(15.0),
                child: checkin
              ),

            ),
          ),
        ),
        Text("Check In",
          style: TextStyle(
              color: Colors.black38,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
              fontSize: 15
          ),
        )

      ]
    );

  }



  Widget _buildMenucheckout(){
    return Column(
        children: <Widget>[

          new Container(
            width: 70,
            height: 70,
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Checkout()
                ));

              },
              child: Card(
                elevation: 1,
                shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  margin:EdgeInsets.all(15.0),
                  child: checkout
                ),

              ),
            ),
          ),
          Text("Check Out",
            style: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
                fontSize: 15
            ),
          )

        ]
    );

  }

  Widget _buildMenuaabsence(){
    return Column(
        children: <Widget>[

          new Container(
            width: 70,
            height: 70,
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => TabsMenuAbsencestatus()
                ));
              },


              child: Card(
                elevation: 1,
                shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                    margin:EdgeInsets.all(15.0),
                    child: absent
                ),

              ),
            ),
          ),


          Text("Absence",
            style: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
                fontSize: 15
            ),
          )

        ]
    );

  }

  Widget _buildMenuproject(){
    return Column(
        children: <Widget>[

          new Container(
            width: 70,
            height: 70,
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>Tabsproject()
                ));

              },
              child: Card(
                elevation: 1,
                shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                    margin:EdgeInsets.all(15.0),
                    child: project
                ),

              ),
            ),
          ),
          Text("Project",
            style: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
                fontSize: 15
            ),
          )

        ]
    );

  }


  Widget _buildMenuoffwork(){
    return Column(
        children: <Widget>[

          new Container(
            width: 70,
            height: 70,
            child: InkWell(
              onTap: () {


              },
              child: Card(
                elevation: 1,
                shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                    margin:EdgeInsets.all(15.0),
                    child: offwork
                ),

              ),
            ),
          ),
          Text("Off Work",
            style: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
                fontSize: 15
            ),
          )

        ]
    );
  }

  Widget _buildmenupyslip(){
    return Column(
        children: <Widget>[

          new Container(
            width: 70,
            height: 70,
            child: InkWell(
              onTap: () {


              },
              child: Card(
                elevation: 1,
                shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                    margin:EdgeInsets.all(15.0),
                    child: pyslip
                ),

              ),
            ),
          ),
          Text("pyslip",
            style: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
                fontSize: 15
            ),
          )

        ]
    );
  }




Widget _buildproject(){
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height/3.5,
    child: Container(
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            child: _loading?Center(child: CircularProgressIndicator(),): ListView.builder(
                itemCount: _projects['data'].length,
                scrollDirection: Axis.horizontal,
                itemBuilder:(context,indext){

                  return _buildProgress(indext);
                }),
            //   child: _buildNoproject(),
          ),

        ],

      ),

    ),
  );
}


  Widget _buildMainMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Container(
          width: double.infinity,
          child: Container(
            margin: EdgeInsets.only(top: 15,bottom: 15),

            child: Column(


              children: <Widget>[
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[

                          _buildMenucheckin(),
                          _buildMenucheckout(),
                          _buildMenuproject(),

                        ],
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[

                            _buildMenuaabsence(),
                            _buildMenuoffwork(),
                            _buildmenupyslip()

                          ],
                        )
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ),
        )
      ],
    );
  }

Widget _buildInformation(){
  return Container(
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 270,
          child: Card(
            elevation:1,
            child: Container(
              margin: EdgeInsets.only(top: 15,bottom: 15),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[


                      ],
                    ),
                  ),


                ],
              ),
            ),

          ),
        ),
      ],
    ),
  );

}
  Widget _buildProgress(index){
    return Center(
      child: Container(

        height: MediaQuery.of(context).size.width/2,
        width: MediaQuery.of(context).size.width/2,
        child: Card(
          child: Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  SizedBox(height: 5,),
                  Text("${_projects['data'][index]['title']}",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,

                    ),

                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Container(

                        child: Expanded(
                          flex: 1,
                          child: new CircularPercentIndicator(
                            radius: 100.0,
                            lineWidth: 7.0,
                            animation: true,
                            percent: _projects['data'][index]['progress'] /100,
                            center: new Text(
                              "${_projects['data'][index]['progress']}%",
                              style:
                              new TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0),
                            ),
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: baseColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

        ),




      ),
    );
  }

  //ge data from api--------------------------------
  Future dataProject(user_id) async{
    try{
      setState(() {
        _loading=true;
      });
      http.Response response=await http.get("http://${base_url}/api/employees/$user_id/events?status=approved");
      _projects=jsonDecode(response.body);

      setState(() {
        _loading=false;
      });
    }catch(e){

    }
  }


  Widget _buildNoproject(){
    return Container(
      color: Colors.redAccent,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/3.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.icecream

          ),
          SizedBox(height: 20,),
          Text("No Available project in progress")
        ],
      ),

    );
  }




  @override
  Widget build(BuildContext context) {

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Center(
              child: new Text("Home",

                style: TextStyle(color: Colors.black87),

              ),
            ),

          ),
          key: scaffoldState,
          body: RefreshIndicator(
            child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Colors.white
                    ),
                    Container(
                      height: double.infinity,
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(0),
                              child: Center(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                        height: 250,
                                        child: Carousel(
                                          autoplay: true,
                                          indicatorBgPadding: 8,
                                          images: [
                                            NetworkImage("https://vip.keluargaallah.com/assets/uploads/projects/56/Project-header---EO.jpg"),
                                            NetworkImage("https://www.ruangkerja.id/hs-fs/hubfs/membangun%20perusahaan.jpg?width=600&name=membangun%20perusahaan.jpg"),
                                            NetworkImage("https://pintek.id/blog/wp-content/uploads/2020/12/perusahaan-startup-1024x683.jpg"),
                                            NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdARQSAn3H0I4m52-7Co7fLa6Eff0mPgumPg&usqp=CAU"),
                                            NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQtZSosUkHA8evWPkN_nNOzKaUt1woUQse-A&usqp=CAU"),
                                          ],
                                        )
                                    )

                                  ],
                                ),
                              ),


                            ),


                            SizedBox(height: 15,),
                            Container(
                              margin: EdgeInsets.only(left: 10,top: 5),
                              child: Text("Main Menu",
                                  textAlign: TextAlign.left,
                                  style: titleStyle

                              ),
                            ),
                            _buildMainMenu(),


                            SizedBox(height: 15,),
                            Container(
                              margin: EdgeInsets.only(left: 10,top: 5),
                              child: Text("Project",
                                  textAlign: TextAlign.left,
                                  style: titleStyle

                              ),
                            ),
                            _buildproject(),
                           // _buildgrafik(),

                            SizedBox(height: 15,),
                            Container(
                              margin: EdgeInsets.only(left: 10,top: 5),
                              child: Text("Information",
                                  textAlign: TextAlign.left,
                                  style: titleStyle

                              ),
                            ),
                            _buildInformation(),

                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            onRefresh: getDatapref,
          ),

        );
    }
    //notification
  showNotifcation(String title,String body) async{
    var android =new AndroidNotificationDetails('chanel id','chanel name', 'CHANEL DESCRIPTION');
    var ios=new IOSNotificationDetails();
    var platform=new NotificationDetails(android: android,iOS: ios);

    await flutterLocalNotificationsPlugin.show(0, '$title', '$body', platform,payload: "tes");
  }
  Future onSelectNotification(String payload) {
    debugPrint("payload : $payload");
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: new Text('Notification'),
        content: new Text('$payload'),
      ),
    );
  }

  Future getDatapref() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {


      user_id=sharedPreferences.getString("user_id");


    });
    setState(() {
      dataProject(user_id);
    });





  }


  //inialisasi state

  void initState() {
    getDatapref();


    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        final notif = message['notification'];
        setState(() {
          ListNotif.add(Notif(
            title:notif['title'],body:notif['body']
          ));

        });
        setState(() {
          showNotifcation(notif['title'], notif['body']);
        });
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

        final notification = message['data'];
        setState(() {
          ListNotif.add(Notif(
            title: '${notification['title']}',
            body: '${notification['body']}',
          ));
        });
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    super.initState();
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var androidd = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSs = new IOSInitializationSettings();
    var initSetttings = new InitializationSettings(android: androidd,iOS: iOSs);
    flutterLocalNotificationsPlugin.initialize(initSetttings, onSelectNotification: onSelectNotification);


  }



  }




