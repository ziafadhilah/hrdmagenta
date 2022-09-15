import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrdmagenta/services/api_clien.dart';
import 'package:hrdmagenta/shared_preferenced/sessionmanage.dart';
import 'package:hrdmagenta/utalities/constants.dart';
import 'package:hrdmagenta/utalities/font.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListLoanEmployeePage extends StatefulWidget {
  @override
  _ListLoanEmployeePageState createState() => _ListLoanEmployeePageState();
}

class _ListLoanEmployeePageState extends State<ListLoanEmployeePage> {
  String currencyFormat(String s) =>
      NumberFormat.decimalPattern("id").format(int.parse(s));
  bool _isLoading = true;
  Map _loans;
  var user_id, loan_total, laon_remaining, loan_payment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black87, //modify arrow color from here..
        ),
        backgroundColor: Colors.white,
        title: new Text(
          "Kasbon",
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: Container(
        color: Colors.white,
        width: Get.mediaQuery.size.width,
        height: Get.mediaQuery.size.height,
        child: SingleChildScrollView(
          child: _isLoading == true
              ? Container(
                  height: Get.mediaQuery.size.height,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ))
              : Container(

                  child: _loans['data']['loans'].length > 0
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    width: Get.mediaQuery.size.width / 3,
                                    height: 80,
                                    child: Card(
                                      child: Container(
                                        margin: EdgeInsets.all(5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                child: Text(
                                              "Total Kasbon",
                                              style: TextStyle(
                                                  fontFamily: "SFReguler",
                                                  fontSize: 13),
                                            )),
                                            Container(
                                                child: Text(
                                              "${loan_total}",
                                              style: TextStyle(
                                                  fontFamily: "Ultralight",
                                                  fontSize: 13),
                                            )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: Get.mediaQuery.size.width / 3,
                                    height: 80,
                                    child: Card(
                                      child: Container(
                                        margin: EdgeInsets.all(5),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                child: Text(
                                                  "Total Pembayaran",
                                                  style: TextStyle(
                                                      fontFamily: "SFReguler",
                                                      fontSize: 13),
                                                )),
                                            Container(
                                                child: Text(
                                                  "${loan_total}",
                                                  style: TextStyle(
                                                      fontFamily: "Ultralight",
                                                      fontSize: 13),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: Get.mediaQuery.size.width / 3,
                                    height: 80,
                                    child: Card(
                                      child: Container(
                                        margin: EdgeInsets.all(5),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                child: Text(
                                                  "Sisa Kasbon",
                                                  style: TextStyle(
                                                      fontFamily: "SFReguler",
                                                      fontSize: 13),
                                                )),
                                            Container(
                                                child: Text(
                                                  "${loan_total}",
                                                  style: TextStyle(
                                                      fontFamily: "Ultralight",
                                                      fontSize: 13),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Container(
                            //   margin: EdgeInsets.only(left: 5, right: 5),
                            //   width: Get.mediaQuery.size.width,
                            //   child: Card(
                            //     elevation: 1,
                            //     child: Container(
                            //       child: Column(
                            //         crossAxisAlignment:
                            //             CrossAxisAlignment.start,
                            //         children: <Widget>[
                            //           Container(
                            //             child: Text(
                            //               "Total kasbon",
                            //               style: TextStyle(
                            //                   color: Colors.black87,
                            //                   fontFamily: "SFReguler",
                            //                   fontSize: 15),
                            //             ),
                            //           ),
                            //           Container(
                            //             child: Text(
                            //               "${loan_total}",
                            //               style: TextStyle(
                            //                   color: Colors.black45,
                            //                   fontFamily: "SFReguler",
                            //                   fontSize: 13),
                            //             ),
                            //           ),
                            //           SizedBox(
                            //             height: 10,
                            //           ),
                            //           Container(
                            //             child: Text(
                            //               "Total Pembayaran",
                            //               style: TextStyle(
                            //                   color: Colors.black87,
                            //                   fontFamily: "SFReguler",
                            //                   fontSize: 15),
                            //             ),
                            //           ),
                            //           Container(
                            //             child: Text(
                            //               "${loan_payment}",
                            //               style: TextStyle(
                            //                   color: Colors.black45,
                            //                   fontFamily: "SFReguler",
                            //                   fontSize: 13),
                            //             ),
                            //           ),
                            //           SizedBox(
                            //             height: 10,
                            //           ),
                            //           Container(
                            //             child: Text(
                            //               "Sisa Kasbon",
                            //               style: TextStyle(
                            //                   color: Colors.black87,
                            //                   fontFamily: "SFReguler",
                            //                   fontSize: 15),
                            //             ),
                            //           ),
                            //           Container(
                            //             child: Text(
                            //               "${laon_remaining}",
                            //               style: TextStyle(
                            //                   color: Colors.black45,
                            //                   fontFamily: "SFReguler",
                            //                   fontSize: 13),
                            //             ),
                            //           ),
                            //           SizedBox(
                            //             height: 10,
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            //),
                            Container(
                              width: Get.mediaQuery.size.width,
                              height: Get.mediaQuery.size.height - 150,
                              child: Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      itemBuilder: (context, index) {
                                        return loansDetail(index);
                                      },
                                      itemCount:
                                          _loans['data']['loans'].length < 0
                                              ? 0
                                              : _loans['data']['loans'].length,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height - 150,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: no_data_project,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                    child: Text(
                                  "Belum ada kasbon",
                                  style: subtitleMainMenu,
                                )),
                              ],
                            ),
                          ),
                        )),
        ),
      ),
    );
  }

  Widget loansDetail(index) {
    //var ammount =NumberFormat.currency(decimalDigits: 0,  locale: "id").format(_loans['data']['loans'][index]['amount'].toString());
    var ammount =
        '${currencyFormat(_loans['data']['loans'][index]['amount'].toString().replaceAll('.', ''))}';
    var type = _loans['data']['loans'][index]['type'];
    return Container(

      width: Get.mediaQuery.size.width,
      child: Card(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                      child: type == 'loan'
                          ? Text(
                              "Peminjaman",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "SFReguler"),
                            )
                          : Text(
                              "Pembayaran",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "SFReguler"),
                            )),
                  Expanded(

                    child: Container(
                      width: double.maxFinite,
                      alignment: Alignment.centerRight,
                      child: Text(
                        "${DateFormat("dd/MM/yyyy").format(DateTime.parse(_loans['data']['loans'][index]['date'])).toString()}",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontFamily: "SFReguler",
                            fontSize: 15,
                            color: Colors.black45),
                      ),
                    ),
                  )
                ],
              ),
              Divider(height: 1,color: Colors.black,),
              SizedBox(height: 5,),
              Container(
                height: 80,
                color: Colors.white,
                child: Card(
                  color: Colors.white,
                  elevation: 0,
                  child: Container(
                    margin: EdgeInsets.all(5),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: _loans['data']['loans'][index]['type'] == 'loan'
                              ? Text(
                            "${ammount}",
                            style: TextStyle(
                                fontFamily: "SFReguler",
                                fontSize: 15,
                                color: Colors.red),
                          )
                              : Text(
                            "${ammount}",
                            style: TextStyle(
                                fontFamily: "SFReguler",
                                fontSize: 15,
                                color: Colors.green),
                          ),
                        ),
                        Container(
                          width: Get.mediaQuery.size.width,
                          child: Text(
                            "${_loans['data']['loans'][index]['description']}",
                            style: TextStyle(fontFamily: "SFReguler", fontSize: 15,color: Colors.black45),
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
    );
  }

  getDataPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = sharedPreferences.getString("user_id");
      loans(user_id);
    });
  }

  Future loans(var user_id) async {
    try {
      setState(() {
        _isLoading = true;
      });

      http.Response response =
          await http.get(Uri.parse("$base_url/api/employees/${user_id}/loans"));

      _loans = jsonDecode(response.body);
      print(_loans['data']['loans'].length);
      loan_total = NumberFormat.currency(decimalDigits: 0, locale: "id")
          .format(_loans['data']['total_loans']);
      laon_remaining = NumberFormat.currency(decimalDigits: 0, locale: "id")
          .format(_loans['data']['remaining_loans']);
      loan_payment = NumberFormat.currency(decimalDigits: 0, locale: "id")
          .format(_loans['data']['total_payments']);

      print(_loans);
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataPref();
  }
}
