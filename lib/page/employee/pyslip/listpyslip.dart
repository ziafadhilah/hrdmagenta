import 'package:flutter/material.dart';
import 'package:hrdmagenta/page/admin/l/absence/detail.dart';
import 'package:hrdmagenta/page/employee/pyslip/detailpyslip.dart';
import 'package:hrdmagenta/utalities/color.dart';
import 'package:hrdmagenta/utalities/constants.dart';
import 'package:hrdmagenta/utalities/font.dart';

class PyslipListPage extends StatefulWidget {
  @override
  _PyslipListPageState createState() => _PyslipListPageState();
}

class _PyslipListPageState extends State<PyslipListPage> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black87, //modify arrow color from here..
          ),
          backgroundColor: Colors.white,
          title: Text(
            "Pyslip",
            style: TextStyle(color: Colors.black87),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: 100,
                  itemBuilder:(contex,index){
                    return _buildpyslip(index);

                  }

                ),
              )
             // _buildpyslip(),

              // Text("tes")
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildpyslip(index) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPyslip()));
      },
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 100,
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
                                            child: pyslip_letter,
                                          ),
                                          //
                                        ],
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10, left: 10),
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Text("Pyslip Employee",
                                                  style: subtitleMainMenu),
                                            ],
                                          ),
                                          Text("Rifan Hidayat",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black26)),
                                          Text(
                                              "pay period from 01/03/2014 to 31/03/2014",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black26)),
                                          new Divider(
                                            color: Colors.black38,
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
        ],
      ),
    );
  }
}
