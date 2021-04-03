import 'package:flutter/material.dart';
import 'package:hrdmagenta/utalities/color.dart';
import 'package:hrdmagenta/utalities/constants.dart';
import 'package:hrdmagenta/utalities/font.dart';

class Notifpage extends StatefulWidget {
  @override
  _NotifPaggeState createState() => _NotifPaggeState();
}

class _NotifPaggeState extends State<Notifpage> {
  bool _loading = true;
  Map _notif;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
            child: new Text(
              "Notifications",
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Expanded(
                child: _loading == false
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        // itemCount: _budgeting['data']['cash_flow'].length,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return _buildNonotif();
                        }),
                //   child: _buildNoproject(),
              ),
              // Text("tes")
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildnotif(index) {
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
                      padding: const EdgeInsets.only(
                        left: 5,
                        top: 10,
                      ),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
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
                                      margin:
                                          EdgeInsets.only(top: 10, left: 10),
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Text(
                                                "Rifan",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: baseColor),
                                              ),
                                              Text(
                                                "  Reject your absence",
                                                style: subtitleMainMenu,
                                              ),
                                            ],
                                          ),
                                          Text("22 years ago",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black26)),
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

  Widget _buildNonotif() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: no_data_notification,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "No notification yet",
                  style: subtitleMainMenu,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
