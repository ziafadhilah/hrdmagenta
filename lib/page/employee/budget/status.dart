import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:hrdmagenta/page/employee/absence/photoview.dart';
import 'package:hrdmagenta/page/employee/budget/shimmer_effect.dart';
import 'package:hrdmagenta/services/api_clien.dart';
import 'package:hrdmagenta/utalities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class budget_status extends StatefulWidget {
  budget_status({this.type, this.event_id});

  var type, event_id;

  @override
  _budget_statusState createState() => _budget_statusState();
}

class _budget_statusState extends State<budget_status> {
  Map _budgeting;
  Map _transaction;
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _loading
            ? Center(
                child: ShimmerBudget(),
              )
            : ListView.builder(
                itemCount: _transaction['data']['transactions'].length == 0
                    ? 1
                    : _transaction['data']['transactions'].length,
                itemBuilder: (context, index) {
                  return _transaction['data']['transactions'].length == 0
                      ? _buildnodata()
                      : _buildTransaction(index);
                  ;
                }),

        //
      ),
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
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => detailBudget(
        //           usage_budget: "",
        //           requested_on: "2021-10-11",
        //           status: "pending",
        //           budget_usage_category: "",
        //           type: "",
        //           note: "",
        //         )));
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



  Widget _buildnodata() {
    return Container(
      height: MediaQuery.of(context).size.height / 2 + 160,
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
              "No transaction yet",
              style: TextStyle(color: Colors.black38, fontSize: 18),
            )),
          ],
        ),
      ),
    );
  }

  //ge data from api--------------------------------
  Future _dataBudgeting() async {
    try {
      setState(() {
        _loading = true;
      });
      http.Response response = await http.get(
          "$baset_url_event/api/projects/${widget.event_id}/budgets/${widget.type}");
      _transaction = jsonDecode(response.body);
      setState(() {
        _loading = false;
      });
    } catch (e) {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dataBudgeting();
  }
}




// Widget _buildTransaction(index) {
//   return InkWell(
//     onTap: () {
//       if (widget.status == "pending") {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => detailBudget(
//                   usage_budget: _budgeting['data']['cash_flow'][index]
//                   ['amount'],
//                   requested_on: _budgeting['data']['cash_flow'][index]
//                   ['date'],
//                   status: "${widget.status}",
//                   budget_usage_category: _budgeting['data']['cash_flow']
//                   [index]['budget_category']['name'],
//                   note:
//                   "${_budgeting['data']['cash_flow'][index]['note']}",
//                   requested_by:
//                   "${_budgeting['data']['cash_flow'][index]['requested_by']['first_name']} ${_budgeting['data']['cash_flow'][index]['requested_by']['last_name']}",
//                 )));
//       } else if (widget.status == "reject") {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => detailBudget(
//                   usage_budget: _budgeting['data']['cash_flow'][index]
//                   ['amount'],
//                   admin_by: _budgeting['data']['cash_flow'][index]
//                   ['rejected_by'],
//                   date_by: _budgeting['data']['cash_flow'][index]
//                   ['rejected_at'],
//                   status: widget.status,
//                   note_admin: _budgeting['data']['cash_flow'][index]
//                   ['rejection_note'],
//                   requested_on: _budgeting['data']['cash_flow'][index]
//                   ['date'],
//                   budget_usage_category: _budgeting['data']['cash_flow']
//                   [index]['budget_category']['name'],
//                   note:
//                   "${_budgeting['data']['cash_flow'][index]['note']}",
//                   requested_by:
//                   "${_budgeting['data']['cash_flow'][index]['requested_by']['first_name']} ${_budgeting['data']['cash_flow'][index]['requested_by']['last_name']}",
//                 )));
//       } else {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => detailBudget(
//                   usage_budget: _budgeting['data']['cash_flow'][index]
//                   ['amount'],
//                   requested_on: _budgeting['data']['cash_flow'][index]
//                   ['date'],
//                   admin_by: _budgeting['data']['cash_flow'][index]
//                   ['approved_by'],
//                   date_by: _budgeting['data']['cash_flow'][index]
//                   ['approved_at'],
//                   budget_usage_category: _budgeting['data']['cash_flow']
//                   [index]['budget_category']['name'],
//                   note:
//                   "${_budgeting['data']['cash_flow'][index]['note']}",
//                   status: widget.status,
//                   note_admin: _budgeting['data']['cash_flow'][index]
//                   ['rejection_note'],
//                   requested_by:
//                   "${_budgeting['data']['cash_flow'][index]['requested_by']['first_name']} ${_budgeting['data']['cash_flow'][index]['requested_by']['last_name']}",
//                 )));
//       }
//     },
//     child: Center(
//       child: Container(
//         margin: EdgeInsets.only(top: 10, left: 10, right: 10),
//         width: double.infinity,
//         child: Row(
//           children: <Widget>[
//             //Container icon
//             Container(
//               child: Icon(
//                 Icons.monetization_on_outlined,
//                 color: Colors.redAccent,
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 width: 340,
//                 height: 150,
//                 child: Card(
//                   child: Row(
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Container(
//                             margin: EdgeInsets.only(left: 10, top: 10),
//                             child: Text(
//                               "${_budgeting['data']['cash_flow'][index]['budget_category']['name']}",
//                               style: TextStyle(
//                                   fontSize: 16, fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           Container(
//                             margin: EdgeInsets.only(left: 10, top: 10),
//                             child: Text(
//                               "${_budgeting['data']['cash_flow'][index]['note']}",
//                               style: TextStyle(
//                                   fontSize: 16, color: Colors.black38),
//                             ),
//                           ),
//                           Container(
//                             margin: EdgeInsets.only(
//                                 left: 10, top: 20, bottom: 10),
//                             child: Text(
//                               "IDR ${_budgeting['data']['cash_flow'][index]['amount']}",
//                               style: TextStyle(
//                                   fontSize: 16, fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Expanded(
//                         child: Container(
//                           margin: EdgeInsets.only(right: 10),
//                           width: double.maxFinite,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: <Widget>[
//                               Container(
//                                   margin: EdgeInsets.only(right: 10),
//                                   child: Text(
//                                     "Expense",
//                                     style: TextStyle(
//                                         color: Colors.redAccent[100]),
//                                   )),
//                               Container(
//                                 width: 70,
//                                 height: 70,
//                                 color: Colors.black12,
//                               )
//                             ],
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     ),
//   );
// }
