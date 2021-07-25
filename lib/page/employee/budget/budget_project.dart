import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrdmagenta/page/employee/absence/photoview.dart';
import 'package:hrdmagenta/page/employee/budget/detail_budget.dart';
import 'package:hrdmagenta/page/employee/budget/expense.dart';
import 'package:hrdmagenta/page/employee/budget/shimmer_effect.dart';
import 'package:hrdmagenta/page/employee/budget/tabmenu_budget.dart';
import 'package:hrdmagenta/services/api_clien.dart';
import 'package:hrdmagenta/utalities/color.dart';
import 'package:hrdmagenta/utalities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class budgetproject extends StatefulWidget {
  budgetproject(
      {
    this.projectNumber,
        this.budgetStartDate,
        this.budgetEndDate,
        this.projectId


      });

  var projectNumber,
      budgetStartDate,
      projectId,
      budgetEndDate;

  @override
  _budgetprojectState createState() => new _budgetprojectState();
}

class _budgetprojectState extends State<budgetproject> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  Map _transaction;
  bool _loading = true;
  var _remaining;
  var total_in,total_out,balance;


//widget------------------
  Widget _buildbidget() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 220,
          child: Container(
            margin: EdgeInsets.only(bottom: 60),
            width: double.infinity,
            height: 150,
            color: baseColor,
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${widget.projectNumber}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "OpenSans"),
                  ),
                  Container(
                    height: 75,
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: Text(
                              "Active on ${DateFormat('dd/MM/yyyy').format(DateTime.parse("${widget.budgetStartDate}"))} ",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: 130,
                            margin: EdgeInsets.only(bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Expired on ${DateFormat('dd/MM/yyyy').format(DateTime.parse("${widget.budgetEndDate}"))} ",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
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
            ),
          ),
        ),
        //container detail budget
        Container(
          margin: EdgeInsets.only(left: 5, right: 5),
          width: double.infinity,
          height: 220,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              //card for remaining dan starting budget
              Container(
                child: Card(
                  child: Container(
                    width: double.infinity,
                    height: 130,
                    child: Row(

                      children: <Widget>[
                        Container(

                          width: Get.mediaQuery.size.width/3 -20,

                          margin: EdgeInsets.only(top: 10,bottom: 10,left: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(


                                child: Text(
                                  "Total In",
                                  style: TextStyle(
                                      color: Colors.black38, fontSize: 16),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: _loading == true
                                    ? Text("")
                                    : Text( "${total_in}",
                                  // "IDR ${_transaction['data']['total_in'] - _transaction['data']['total_out']}",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            child: VerticalDivider(
                              color: Colors.black38,
                            )),
                        //Container
                        Container(


                          width: Get.mediaQuery.size.width/3 -20,
                          margin: EdgeInsets.only(top: 10,bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "Total Out",
                                  style: TextStyle(
                                      color: Colors.black38, fontSize: 16),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: _loading == true
                                    ? Text("")
                                    : Text(     "${total_out}",
                                        // "IDR ${_transaction['data']['total_in'] - _transaction['data']['total_out']}",
                                        style: TextStyle(

                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                      ),
                              )
                            ],
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            child: VerticalDivider(
                              color: Colors.black38,
                            )),

                        //Container
                        Expanded(
                          child: Container(

                            width: Get.mediaQuery.size.width/3 -20,


                            margin: EdgeInsets.only(top: 10,bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "saldo",
                                    style: TextStyle(
                                        color: Colors.black38, fontSize: 16),
                                  ),
                                ),
                                Container(

                                  margin: EdgeInsets.only(top: 20,right: 5),
                                  child: _loading == true
                                      ? Text("")
                                      : Text(
                                          "${balance}",
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),
                                        ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildTransaction(index) {
    var typeExpense="Transportasi";
    var description=_transaction['data']['transactions'][index]['description'];
    var date=DateFormat("dd/MM/yyyy").format(DateTime.parse("${_transaction['data']['transactions'][index]['date']}"));
    var amount= NumberFormat.currency(decimalDigits: 0,  locale: "id").format(_transaction['data']['transactions'][index]['amount']);

    var image=_transaction['data']['transactions'][index]['image'];
    var type=_transaction['data']['transactions'][index]['type'];
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => detailBudget(
                      usage_budget: "",
                      requested_on: "2021-10-11",
                      status: "pending",
                      budget_usage_category: "",
                      type: "",
                      note: "",
                    )));
      },
      child: Center(
        child: Container(
          margin: EdgeInsets.only(top: 10),
          width: double.infinity,
          height: 150,
          child: Row(
            children: <Widget>[
              //Container icon
              Container(
                child:
                    _transaction['data']['transactions'][index]['type'] == "in"
                        ? Icon(
                            Icons.monetization_on_outlined,
                            color: Colors.green,
                          )
                        : Icon(
                            Icons.monetization_on_outlined,
                            color: Colors.redAccent,
                          ),
              ),
              Expanded(
                child: Container(
                  width: 200,
                  child: Card(
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 10, top: 10),
                              child: Text(
                                typeExpense,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: Get.mediaQuery.size.width-140,
                              margin: EdgeInsets.only(left: 10, top: 10),
                              child: Text(
                                "${description}",

                                style: TextStyle(
                                    fontSize: 16, color: Colors.black38),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 10, top: 10, bottom: 10),
                              child: Text(
                                "${amount}",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold,color: type=="in"?Colors.green:Colors.red),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            width: double.maxFinite,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                // Container(
                                Container(
                                  child: Text(
                                    "${date}",
                                    style: TextStyle(
                                        fontSize: 16,color: Colors.black38),
                                  ),
                                ),
                          SizedBox(height: 10,),

                          Hero(
                              tag: "avatar-1",
                              child: Container(

                                  margin: EdgeInsets.only(left: 10),
                                  color: Colors.black87,
                                  height: 100,
                                  width: 100,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PhotoViewPage(
                                              //image: widget.image,
                                            )),
                                      );
                                    },
                                    child: image == null
                                        ? Image.asset(
                                      "assets/absen.jpeg",
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.fill,
                                    )
                                        : CachedNetworkImage(
                                      imageUrl:  "${image_ur}/${image}",
                                      fit: BoxFit.fill,
                                      placeholder: (context, url) =>
                                          Center(child: new CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                      new Icon(Icons.error),
                                    ),
                                  )))

                                // Container(
                                //   width: 100,
                                //   height: 100,
                                //   color: Colors.black12,
                                // )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

//main context----------------------------------
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: baseColor,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Constants.choicesM.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
        title: new Text(
          "",
          style: TextStyle(color: Colors.black87),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => expandbudget(
                        event_id: widget.projectId.toString(),
                      )));
        },
        child: Icon(Icons.add),
        backgroundColor: btnColor1,
      ),
      body: RefreshIndicator(
        child: new Container(
          child: Container(
            child: Container(
              child: Center(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      _buildbidget(),
                      Expanded(
                        child: _loading
                            ? Center(
                                child: ShimmerBudget(),
                              )
                            : ListView.builder(
                                // itemCount: _budgeting['data']['cash_flow'].length,
                                itemCount: _transaction['data']['transactions']
                                            .length ==
                                        0
                                    ? 0
                                    : _transaction['data']['transactions'].length,
                                itemBuilder: (context, index) {
                                  return _transaction['data']['transactions']
                                              .length ==
                                          0
                                      ? _buildnodata()
                                      : _buildTransaction(index);
                                }),
                      ),

                      //list transation
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        onRefresh: _dataBudgeting,
      ),
    );
  }

  //function
  void choiceAction(String choice) {
    if (choice == Constants.Buget) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Tabsappbudget(
                    event_id: widget.projectId,
                  )));
    }
  }

  Widget _buildnodata() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: no_data_transacation,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                child: Text(
              "Belum ada transaksi",
              style: TextStyle(color: Colors.black38, fontSize: 18),
            )),
          ],
        ),
      ),
    );
  }

  void Refreshbudget() {
    setState(() {
      _dataBudgeting();
    });
  }

  //ge data from api--------------------------------
  Future _dataBudgeting() async {
    try {
      setState(() {
        _loading = true;
      });
      http.Response response = await http
          .get("$baset_url_event/api/projects/${widget.projectId}/budgets");
      _transaction = jsonDecode(response.body);
      total_in=NumberFormat.currency(decimalDigits: 0,  locale: "id").format(_transaction['data']['total_in']);
      total_out=NumberFormat.currency(decimalDigits: 0,  locale: "id").format(_transaction['data']['total_out']);
      balance=NumberFormat.currency(decimalDigits: 0,  locale: "id").format(_transaction['data']['balance']);

      print(_transaction);

      setState(() {
        _loading = false;
      });
    } catch (e) {}
  }

  //inilisasi state
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dataBudgeting();

  }
}
