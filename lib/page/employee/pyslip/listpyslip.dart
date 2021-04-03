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
            "Payslip",
            style: TextStyle(color: Colors.black87),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder:(contex,index){
                    return _buildNopyslip();

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
                                              Text("Payslip Employee",
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
  Widget _buildNopyslip() {
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

                  child: no_data_payslip,
                ),
                SizedBox(height: 20,),
                Text(
                  "No payslip yet",
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
