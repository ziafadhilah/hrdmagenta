import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrdmagenta/services/api_clien.dart';
import 'package:hrdmagenta/shared_preferenced/sessionmanage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ListLoanEmployeePage extends StatefulWidget {
  @override
  _ListLoanEmployeePageState createState() => _ListLoanEmployeePageState();
}

class _ListLoanEmployeePageState extends State<ListLoanEmployeePage> {
  bool _isLoading=true;
  Map _loans;
  var user_id,loan_total,laon_remaining,loan_payment;
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
        width: Get.mediaQuery.size.width,
        height: Get.mediaQuery.size.height,
        child: SingleChildScrollView(
          child: _isLoading==true?Container(height:
          Get.mediaQuery.size.height, child: Center(child:
          CircularProgressIndicator(),)):Container(
            child: Column(

              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 5,right: 5),
                  width: Get.mediaQuery.size.width,

                  child: Card(
                    elevation: 1,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start ,
                        children: <Widget>[
                          Container(
                            child: Text("Total kasbon",style: TextStyle(
                                color: Colors.black87,fontFamily: "SFReguler",fontSize: 15),),
                          ),
                          Container(
                            child: Text("${loan_total}",style: TextStyle(
                                color: Colors.black45,fontFamily: "SFReguler",fontSize: 13),),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            child: Text("Total Pembayaran",style: TextStyle(
                                color: Colors.black87,fontFamily: "SFReguler",fontSize: 15),),
                          ),
                          Container(
                            child: Text("${loan_payment}",style: TextStyle(
                                color: Colors.black45,fontFamily: "SFReguler",fontSize: 13),),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            child: Text("Sisa Kasbon",style: TextStyle(
                                color: Colors.black87,fontFamily: "SFReguler",fontSize: 15),),
                          ),
                          Container(
                            child: Text("${laon_remaining}",style: TextStyle(
                                color: Colors.black45,fontFamily: "SFReguler",fontSize: 13),),
                          ),
                          SizedBox(height: 10,),
                        ],
                      ),

                    ),
                  ),

                ),
                Container(

                  width: Get.mediaQuery.size.width,
                  height: Get.mediaQuery.size.height-100,
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        child: ListView.builder(itemBuilder:(context,index){
                          return loansDetail(index);
                        },
                          itemCount: _loans['data']['loans'].length<=0?1:_loans['data']['loans'].length,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),

          ),
        ),
      ),
    );
  }

  Widget loansDetail(index){
    var ammount =NumberFormat.currency(decimalDigits: 0,  locale: "id").format(_loans['data']['loans'][index]['amount']);
    var type=_loans['data']['loans'][index]['type'];
    return Container(
      margin: EdgeInsets.only(left: 5,right: 5,top: 10),
      width: Get.mediaQuery.size.width,


      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Container(child: type=='loan'? Text("Peminjaman",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,fontFamily: "SFReguler"),):Text("Pembayaran",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,fontFamily: "SFReguler"),)),
          Container(
            height: 120,
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
                    SizedBox(height: 10,),
                    Container(
                      width: Get.mediaQuery.size.width,
                     child: Text("${DateFormat("dd/MM/yyyy").format(DateTime.parse(_loans['data']['loans'][index]['date'])).toString()}",textAlign: TextAlign.right,style: TextStyle(fontFamily: "SFReguler",fontSize: 15,color: Colors.black45),),
                    ),
                    Container(
                      width: Get.mediaQuery.size.width,
                      child: Text("${_loans['data']['loans'][index]['description']}",style: TextStyle(fontFamily: "SFReguler",fontSize: 15),),
                    ),
                    Container(

                      child: _loans['data']['loans'][index]['type']=='loan'?
                      Text("${ammount}",style: TextStyle(fontFamily: "SFReguler",fontSize: 15,color: Colors.red),):
                      Text("${ammount}",style: TextStyle(fontFamily: "SFReguler",fontSize: 15,color: Colors.green),),
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
  getDataPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = sharedPreferences.getString("user_id");
      loans(user_id);

    });
  }
  Future loans(var user_id) async{

      try {
        setState(() {
          _isLoading = true;
        });

        http.Response response =
        await http.get("$base_url/api/employees/1/loans");
        _loans = jsonDecode(response.body);
        loan_total=NumberFormat.currency(decimalDigits: 0,  locale: "id").format(_loans['data']['total_loans']);
        laon_remaining=NumberFormat.currency(decimalDigits: 0,  locale: "id").format(_loans['data']['remaining_loans']);
        loan_payment=NumberFormat.currency(decimalDigits: 0,  locale: "id").format(_loans['data']['total_payments']);

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
