import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hrdmagenta/page/admin/l/budget/detail_budget_pending.dart';
import 'package:hrdmagenta/page/employee/budget/detail_budget.dart';
import 'package:hrdmagenta/page/employee/budget/shimmer_effect.dart';
import 'package:hrdmagenta/services/api_clien.dart';
import 'package:hrdmagenta/utalities/constants.dart';
import 'package:http/http.dart' as http;

class budget_status extends StatefulWidget {
  budget_status({this.status, this.event_id});

  var status, event_id;

  @override
  _budget_statusState createState() => _budget_statusState();
}

class _budget_statusState extends State<budget_status> {
  Map _budgeting;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _loading
            ? Center(
                child: ShimmerBudget(),
              )
            : ListView.builder(
                itemCount: _budgeting['data']['cash_flow'].length == 0
                    ? 1
                    : _budgeting['data']['cash_flow'].length,
                itemBuilder: (context, index) {
                  return _budgeting['data']['cash_flow'].length == 0
                      ? _buildnodata()
                      : _buildTransaction(index);
                  ;
                }),

        //
      ),
    );
  }

  Widget _buildTransaction(index) {
    return InkWell(
      onTap: () {
        if (widget.status == "pending") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => detailBudget(
                        usage_budget: _budgeting['data']['cash_flow'][index]
                            ['amount'],
                        requested_on: _budgeting['data']['cash_flow'][index]
                            ['date'],
                        status: "${widget.status}",
                        budget_usage_category: _budgeting['data']['cash_flow']
                            [index]['budget_category']['name'],
                        note:
                            "${_budgeting['data']['cash_flow'][index]['note']}",
                        requested_by:
                            "${_budgeting['data']['cash_flow'][index]['requested_by']['first_name']} ${_budgeting['data']['cash_flow'][index]['requested_by']['last_name']}",
                      )));
        } else if (widget.status == "reject") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => detailBudget(
                        usage_budget: _budgeting['data']['cash_flow'][index]
                            ['amount'],
                        admin_by: _budgeting['data']['cash_flow'][index]
                            ['rejected_by'],
                        date_by: _budgeting['data']['cash_flow'][index]
                            ['rejected_at'],
                        status: widget.status,
                        note_admin: _budgeting['data']['cash_flow'][index]
                            ['rejection_note'],
                        requested_on: _budgeting['data']['cash_flow'][index]
                            ['date'],
                        budget_usage_category: _budgeting['data']['cash_flow']
                            [index]['budget_category']['name'],
                        note:
                            "${_budgeting['data']['cash_flow'][index]['note']}",
                        requested_by:
                            "${_budgeting['data']['cash_flow'][index]['requested_by']['first_name']} ${_budgeting['data']['cash_flow'][index]['requested_by']['last_name']}",
                      )));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => detailBudget(
                        usage_budget: _budgeting['data']['cash_flow'][index]
                            ['amount'],
                        requested_on: _budgeting['data']['cash_flow'][index]
                            ['date'],
                        admin_by: _budgeting['data']['cash_flow'][index]
                            ['approved_by'],
                        date_by: _budgeting['data']['cash_flow'][index]
                            ['approved_at'],
                        budget_usage_category: _budgeting['data']['cash_flow']
                            [index]['budget_category']['name'],
                        note:
                            "${_budgeting['data']['cash_flow'][index]['note']}",
                        status: widget.status,
                        note_admin: _budgeting['data']['cash_flow'][index]
                            ['rejection_note'],
                        requested_by:
                            "${_budgeting['data']['cash_flow'][index]['requested_by']['first_name']} ${_budgeting['data']['cash_flow'][index]['requested_by']['last_name']}",
                      )));
        }
      },
      child: Center(
        child: Container(
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          width: double.infinity,
          child: Row(
            children: <Widget>[
              //Container icon
              Container(
                child: Icon(
                  Icons.monetization_on_outlined,
                  color: Colors.redAccent,
                ),
              ),
              Expanded(
                child: Container(
                  width: 340,
                  height: 150,
                  child: Card(
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 10, top: 10),
                              child: Text(
                                "${_budgeting['data']['cash_flow'][index]['budget_category']['name']}",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10, top: 10),
                              child: Text(
                                "${_budgeting['data']['cash_flow'][index]['note']}",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black38),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 10, top: 20, bottom: 10),
                              child: Text(
                                "IDR ${_budgeting['data']['cash_flow'][index]['amount']}",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
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
                                Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Text(
                                      "Expense",
                                      style: TextStyle(
                                          color: Colors.redAccent[100]),
                                    )),
                                Container(
                                  width: 70,
                                  height: 70,
                                  color: Colors.black12,
                                )
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
          "http://${base_url}/api/events/${widget.event_id}/budgets?type=expense&type=${widget.status}");
      _budgeting = jsonDecode(response.body);
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
