
import 'package:flutter/material.dart';
import 'package:hrdmagenta/utalities/color.dart';
class Notifpage extends StatefulWidget {
  @override
  _NotifPaggeState createState() => _NotifPaggeState();
}

class _NotifPaggeState extends State<Notifpage> {
  Widget _buildnotif(){
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
                      padding: const EdgeInsets.only(left: 5,top: 10,),
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
                                    child: Container(

                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                        children: <Widget>[
                                          CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 30,
                                            child: Icon(
                                              Icons.person,
                                              color: Colors.black12,
                                              size: 40,
                                            ),
                                          ),
                                          //



                                        ],
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10,left: 10),
                                      width: MediaQuery.of(context).size.width,

                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[

                                          Row(
                                            children: [
                                              Text("Eza",style: TextStyle(
                                                fontSize: 18,
                                                color: baseColor
                                              ),),
                                              Text("  Approve your absence",style: TextStyle(
                                                fontSize: 15,color: Colors.black87
                                              )),

                                            ],
                                          ),
                                          Text("22 years ago",style: TextStyle(
                                            fontSize: 15,color: Colors.black26
                                          )

                                          ),
                                          new Divider(
                                            color: Colors.white,
                                          ),





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

  Widget _buildnotif1(){
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
                      padding: const EdgeInsets.only(left: 5,top: 10,),
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
                                    child: Container(

                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                        children: <Widget>[
                                          CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 30,
                                            child: Icon(
                                              Icons.person,
                                              color: Colors.black12,
                                              size: 40,
                                            ),
                                          ),
                                          //



                                        ],
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10,left: 10),
                                      width: MediaQuery.of(context).size.width,

                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[

                                          Row(
                                            children: [
                                              Text("Rifan",style: TextStyle(
                                                  fontSize: 18,
                                                  color: baseColor
                                              ),),
                                              Text("  Reject your absence",style: TextStyle(
                                                  fontSize: 15,color: Colors.black87
                                              )),

                                            ],
                                          ),
                                          Text("22 years ago",style: TextStyle(
                                              fontSize: 15,color: Colors.black26
                                          )

                                          ),
                                          new Divider(
                                            color: Colors.white,
                                          ),





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


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(

          backgroundColor: Colors.white,

          title: Center(
            child: new Text("Notifications",
              style: TextStyle(color: Colors.black87),

            ),
          ),
        ),
        body:Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              _buildnotif(),
              _buildnotif1()
              // Text("tes")
            ],

          ),
        ),
      ),
    );
  }
}
