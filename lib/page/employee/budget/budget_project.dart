import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hrdmagenta/page/employee/budget/edit.dart';
import 'package:hrdmagenta/page/employee/budget/expense.dart';
import 'package:hrdmagenta/page/employee/budget/image.dart';
import 'package:hrdmagenta/page/employee/budget/repayment.dart';
import 'package:hrdmagenta/page/employee/budget/shimmer_effect.dart';
import 'package:hrdmagenta/page/employee/budget/tabmenu_budget.dart';
import 'package:hrdmagenta/services/api_clien.dart';
import 'package:hrdmagenta/utalities/color.dart';
import 'package:hrdmagenta/utalities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class budgetproject extends StatefulWidget {
  budgetproject({
    this.projectNumber,
    this.budgetStartDate,
    this.budgetEndDate,
    this.statusMember,
    this.projectId,
  });

  var projectNumber, budgetStartDate, projectId, budgetEndDate, statusMember;

  @override
  _budgetprojectState createState() => new _budgetprojectState();
}

class _budgetprojectState extends State<budgetproject> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  Services services = new Services();
  Map _transaction;
  bool _loading = true;
  var _remaining;
  var total_in, total_out, balance, remaining_balance = 0;
  var projectNumber, budgetStartDate, budgetEndDate;

  var _visible = false;

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
                  Visibility(
                    visible: _visible,
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                              child: Icon(
                            Icons.warning_amber_outlined,
                            color: Colors.amber,
                            size: 20,
                          )),
                          Container(
                            width: Get.mediaQuery.size.width - 50,
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              "Diluar efektif budget ${remaining_balance > 0 ? ""
                                  "" : ""} ",
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontFamily: "SFReguler"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${widget.projectNumber == null ? projectNumber : widget.projectNumber}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "OpenSans"),
                  ),
                  Container(
                    height: 55,
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: Text(
                              "Active on ${budgetStartDate == null ? "" : DateFormat('dd/MM/yyyy').format(DateTime.parse("${budgetStartDate}"))} ",
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
                                  "Expired on ${budgetEndDate == null ? "" : DateFormat('dd/MM/yyyy').format(DateTime.parse("${budgetEndDate}"))} ",
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
          height: _visible == true ? 230 : 210,
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
                          width: Get.mediaQuery.size.width / 3 - 20,
                          margin: EdgeInsets.only(top: 10, bottom: 10, left: 5),
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
                                    : Text(
                                        "${total_in}",
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
                          width: Get.mediaQuery.size.width / 3 - 20,
                          margin: EdgeInsets.only(top: 10, bottom: 10),
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
                                    : Text(
                                        "${total_out}",
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
                            width: Get.mediaQuery.size.width / 3 - 20,
                            margin: EdgeInsets.only(top: 10, bottom: 10),
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
                                  margin: EdgeInsets.only(top: 20, right: 5),
                                  child: _loading == true
                                      ? Text("")
                                      : Text(
                                          "${balance}",
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),
                                        ),
                                ),
                                (remaining_balance > 0
                                    ? Container(
                                        margin: EdgeInsets.only(right: 5),
                                        child: widget.statusMember == 'pic'
                                            ? ElevatedButton(
                                                onPressed: () {
                                                  updateRepayment();

                                                },
                                                child: Text(
                                                  'Pelunasan',
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                ),
                                              )
                                            : Container(),
                                      )
                                    : Container())
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
    var description =
        _transaction['data']['transactions'][index]['description'];
    var date = DateFormat("dd/MM/yyyy").format(DateTime.parse(
        "${_transaction['data']['transactions'][index]['date']}"));
    var amount = NumberFormat.currency(decimalDigits: 0, locale: "id")
        .format(_transaction['data']['transactions'][index]['amount']);

    var image = '${_transaction['data']['transactions'][index]['image']}';
    var type = _transaction['data']['transactions'][index]['type'];
    var id = _transaction['data']['transactions'][index]['id'];
    var status = _transaction['data']['transactions'][index]['status'];

    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        width: double.infinity,
        height: 200,
        child: Row(
          children: <Widget>[
            //Container icon
            Container(
              child: _transaction['data']['transactions'][index]['type'] == "in"
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
                  child: Column(
                    children: [
                      Container(
                        height: 40,
                        child: Container(
                          width: Get.mediaQuery.size.width,
                          child: Row(
                            children: [
                              status == "pending"
                                  ? Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Text(
                                        "Pelunasan",
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 15,
                                            fontFamily: "SFBlack"),
                                      ),
                                    )
                                  : Container(),
                              Expanded(
                                child: Container(
                                  width: double.maxFinite,
                                  child: Align(
                                    child: type == 'in'
                                        ? Container()
                                        : Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              //btn edit transaction
                                              _visible == false
                                                  ? (Container(
                                                      child: new FlatButton(
                                                          minWidth: 1,
                                                          color:
                                                              Colors.grey[100],
                                                          onPressed: () {
                                                            updateeditBudget(
                                                                widget
                                                                    .projectNumber,
                                                                id.toString(),
                                                                _transaction['data']['transactions']
                                                                            [index]
                                                                        [
                                                                        'amount']
                                                                    .toString(),
                                                                _transaction['data']
                                                                            ['transactions']
                                                                        [index][
                                                                    'description'],
                                                                _transaction['data']
                                                                            ['transactions']
                                                                        [index]
                                                                    ['date'],
                                                                _transaction['data']
                                                                            ['transactions']
                                                                        [index][
                                                                    'account_id'],
                                                                widget
                                                                    .projectId,
                                                                status);
                                                            // Get.to(EditExpense(
                                                            //   project_number: widget
                                                            //       .projectNumber,
                                                            //   transaction_id:
                                                            //       id.toString(),
                                                            //   amount: _transaction['data']
                                                            //                   [
                                                            //                   'transactions']
                                                            //               [
                                                            //               index]
                                                            //           ['amount']
                                                            //       .toString(),
                                                            //   description: _transaction[
                                                            //               'data']
                                                            //           [
                                                            //           'transactions'][index]
                                                            //       [
                                                            //       'description'],
                                                            //   date: _transaction[
                                                            //               'data']
                                                            //           [
                                                            //           'transactions']
                                                            //       [
                                                            //       index]['date'],
                                                            //   account_id: _transaction['data']
                                                            //                   [
                                                            //                   'transactions']
                                                            //               [
                                                            //               index]
                                                            //           [
                                                            //           'account_id']
                                                            //       .toString(),
                                                            //   event_id: widget
                                                            //       .projectId,
                                                            //   enabled: status ==
                                                            //           "pending"
                                                            //       ? false
                                                            //       : true,
                                                            //   status: status,
                                                            //   path: _transaction[
                                                            //               'data']
                                                            //           [
                                                            //           'transactions']
                                                            //       [
                                                            //       index]['image'],
                                                            // ));
                                                          },
                                                          child: Icon(
                                                            Icons.edit_outlined,
                                                            size: 20,
                                                          )),
                                                    ))
                                                  : (status == "pending"
                                                      ? Container(
                                                          child: new FlatButton(
                                                              minWidth: 1,
                                                              color: Colors
                                                                  .grey[100],
                                                              onPressed: () {},
                                                              child: Icon(
                                                                Icons
                                                                    .edit_outlined,
                                                                size: 20,
                                                              )),
                                                        )
                                                      : Container()),

                                              SizedBox(
                                                height: 10,
                                              ),
                                              _visible == false
                                                  ? Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10, right: 10),
                                                      child: new FlatButton(
                                                          minWidth: 1,
                                                          color:
                                                              Colors.grey[100],
                                                          onPressed: () {
                                                            Alert(
                                                              context: context,
                                                              type: AlertType
                                                                  .warning,
                                                              title:
                                                                  "Apa anda yakin?",
                                                              desc:
                                                                  "Data transaksi ini akan dihapus",
                                                              buttons: [
                                                                DialogButton(
                                                                  child: Text(
                                                                    "Iya",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            20),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    var id = _transaction['data']
                                                                            [
                                                                            'transactions']
                                                                        [
                                                                        index]['id'];
                                                                    print(
                                                                        "${id}");
                                                                    services
                                                                        .deleteTransactionBudget(
                                                                            context,
                                                                            id,
                                                                            widget
                                                                                .projectNumber)
                                                                        .then(
                                                                            (value) {
                                                                      _dataBudgeting();
                                                                      // _transaction['data']['transactions'].removeWhere((item) => item.id == id);
                                                                    });
                                                                  },
                                                                  color:
                                                                      btnColor1,
                                                                ),
                                                                DialogButton(
                                                                  child: Text(
                                                                    "Batalkan",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            20),
                                                                  ),
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context),
                                                                  color: Colors
                                                                      .grey,
                                                                )
                                                              ],
                                                            ).show();
                                                          },
                                                          child: Icon(
                                                            Icons
                                                                .restore_from_trash_outlined,
                                                            size: 20,
                                                          )),
                                                    )
                                                  : (status == "pending"
                                                      ? Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  right: 10),
                                                          child: new FlatButton(
                                                              minWidth: 1,
                                                              color: Colors
                                                                  .grey[100],
                                                              onPressed: () {
                                                                Alert(
                                                                  context:
                                                                      context,
                                                                  type: AlertType
                                                                      .warning,
                                                                  title:
                                                                      "Apa anda yakin?",
                                                                  desc:
                                                                      "Data transaksi ini akan dihapus",
                                                                  buttons: [
                                                                    DialogButton(
                                                                      child:
                                                                          Text(
                                                                        "Iya",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize: 20),
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        var id =
                                                                            _transaction['data']['transactions'][index]['id'];
                                                                        print(
                                                                            "${id}");
                                                                        services
                                                                            .deleteTransactionBudget(
                                                                                context,
                                                                                id,
                                                                                widget.projectNumber)
                                                                            .then((value) {
                                                                          _dataBudgeting();
                                                                          // _transaction['data']['transactions'].removeWhere((item) => item.id == id);
                                                                        });
                                                                      },
                                                                      color:
                                                                          btnColor1,
                                                                    ),
                                                                    DialogButton(
                                                                      child:
                                                                          Text(
                                                                        "Batalkan",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize: 20),
                                                                      ),
                                                                      onPressed:
                                                                          () =>
                                                                              Navigator.pop(context),
                                                                      color: Colors
                                                                          .grey,
                                                                    )
                                                                  ],
                                                                ).show();
                                                              },
                                                              child: Icon(
                                                                Icons
                                                                    .restore_from_trash_outlined,
                                                                size: 20,
                                                              )),
                                                        )
                                                      : Container()),
                                            ],
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.black45,
                        width: Get.mediaQuery.size.width - 35,
                        height: 1,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 10, top: 0),
                                child: Text(
                                  "${date}",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black38),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: Get.mediaQuery.size.width - 140,
                                margin: EdgeInsets.only(left: 10, top: 0),
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: type == "in"
                                          ? Colors.green
                                          : Colors.red),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              status == "pending"
                                  ? Container(
                                      margin: EdgeInsets.only(left: 10),
                                      width: Get.mediaQuery.size.width - 140,
                                      child: Row(
                                        children: [
                                          Container(
                                            child: Icon(
                                              Icons.info_outline,
                                              color: Colors.lightBlue,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 10, top: 0),
                                            child: Text(
                                              "Menunggu persetujuan",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.lightBlue),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : status=="rejected"?
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                width: Get.mediaQuery.size.width - 150,
                                child: Row(
                                  children: [
                                    Container(
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 10, top: 0),
                                      child: Text(
                                        "Pengajuan ditolak",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.redAccent),
                                      ),
                                    ),
                                  ],
                                ),
                              ):
                              Container(),
                            ],
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              width: double.maxFinite,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  SizedBox(
                                    height: 15,
                                  ),

                                  Hero(
                                      tag: "image_transaksi",
                                      child: Container(
                                          margin: EdgeInsets.only(left: 10),
                                          color: Colors.black87,
                                          height: 100,
                                          width: 100,
                                          child: image == null
                                              ? Center(
                                                  child: Text("No Image",
                                                      style: TextStyle(
                                                          color: Colors.white))):image =="null"
                                              ? Center(
                                              child: Text("No Image",
                                                  style: TextStyle(
                                                      color: Colors.white)))
                                              : image == ""
                                                  ? Center(
                                                      child: Text(
                                                      "No Image",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ))
                                                  : InkWell(
                                                      onTap: () {
                                                        Get.to(ImageTransaction(
                                                          image: image,
                                                          title: description,
                                                        ));
                                                      },
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            "${image_ur}/eo/transactions/${image}",
                                                        fit: BoxFit.fill,
                                                        placeholder: (context,
                                                                url) =>
                                                            Center(
                                                                child:
                                                                    new CircularProgressIndicator()),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            new Icon(
                                                                Icons.error),
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
                    ],
                  ),
                ),
              ),
            )
          ],
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
      floatingActionButton: widget.statusMember == 'pic'
          ? (_visible == false
              ? (remaining_balance!=0?FloatingActionButton(
                  heroTag: "btn_expense",
                  onPressed: () {
                    _ExpenseBudget();
                  },
                  child: Icon(Icons.add),
                  backgroundColor: btnColor1,
                ):null)
              : null)
          : Container(),
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
                                    : _transaction['data']['transactions']
                                        .length,
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



  void _checkActiveBudget() {
    var now = DateTime.now();

    DateTime budgetStartDate = DateTime.parse("${widget.budgetStartDate}");
    DateTime budgetEndDate = DateTime.parse("${widget.budgetEndDate}");

    if (budgetStartDate.isBefore(now) && budgetEndDate.isAfter(now)) {
      setState(() {
        //between
        _visible = false;
      });
    } else {
      setState(() {
        _visible = true;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _ExpenseBudget() async {
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => expandbudget(
                  event_id: widget.projectId.toString(),
                  project_number: widget.projectNumber.toString(),
                )));

    if (result == "update") {
      Refreshbudget();
    }
  }

  void updateeditBudget(var projectNumber, transactionId, amount, description,
      date, accountId, eventId, status) async {
    var result = await Get.to(EditExpense(
      project_number: projectNumber,
      transaction_id: transactionId,
      amount: amount,
      description: description,
      date: date,
      account_id: accountId.toString(),
      event_id: eventId,
      enabled: status == "pending" ? false : true,
      status: status,
    ));

    if (result == "update") {
      Refreshbudget();
    }
  }

  void updateRepayment() async {
    var result = await Get.to(RepaymentBudget(
      event_id: widget.projectId,
      project_number:
      widget.projectNumber,
      amount: remaining_balance,
    ));

    if (result == "update") {
      Refreshbudget();
    }
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
      total_in = NumberFormat.currency(decimalDigits: 0, locale: "id")
          .format(_transaction['data']['total_in']);
      total_out = NumberFormat.currency(decimalDigits: 0, locale: "id")
          .format(_transaction['data']['total_out']);
      balance = NumberFormat.currency(decimalDigits: 0, locale: "id")
          .format(_transaction['data']['balance']);
      remaining_balance = _transaction['data']['balance'];
      _checkActiveBudget();
      projectNumber = _transaction['data']['project_number'];
      budgetStartDate = _transaction['data']['budget_start_date'];
      budgetEndDate = _transaction['data']['budget_end_date'];

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
