// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:hrdmagenta/page/employee/pyslip/DetailPayslip.dart';
// import 'package:hrdmagenta/services/api_clien.dart';
// import 'package:hrdmagenta/shared_preferenced/sessionmanage.dart';
// import 'package:hrdmagenta/utalities/constants.dart';
// import 'package:hrdmagenta/utalities/font.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// class PyslipListPage extends StatefulWidget {
//   PyslipListPage({
//     this.type
// });
//   var type;
//
//   @override
//   _PyslipListPageState createState() => _PyslipListPageState();
// }
//
// class _PyslipListPageState extends State<PyslipListPage> {
//   Map _payslips;
//   bool _loading=true;
//   var user_id,selisih;
//
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//
//         body: _loading == true
//             ? Center(
//                 child: CircularProgressIndicator(),
//               )
//             : Container(
//                 color: Colors.white,
//                 child: Column(
//                   children: <Widget>[
//                     Expanded(
//                       child: ListView.builder(
//                           itemCount: _payslips['data'].length.toString()=="0"?1:_payslips['data'].length,
//                           itemBuilder: (contex, index) {
//                             return _payslips['data'].length.toString()=="0"?_buildNopyslip():_buildpyslip(index);
//                             //return _buildpyslip(index);
//                           }),
//                     )
//                     // _buildpyslip(),
//
//                     // Text("tes")
//                   ],
//                 ),
//               ),
//       ),
//     );
//   }
//
//   Widget _buildpyslip(index) {
//     DateTime tanggalMulai = DateTime.parse("${_payslips['data'][index]['employee']['careers'][0]['effective_date']}");
//     DateTime tanggalAkhir = DateTime.now();
//     final datestart = DateTime(tanggalMulai.year, tanggalMulai.month, tanggalMulai.day);
//     final dateend = DateTime(tanggalAkhir.year, tanggalAkhir.month, tanggalAkhir.day);
//
//       selisih = dateend.difference(datestart).inDays;
//
//     return InkWell(
//
//       onTap: () {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) =>
//             DetailPyslip(
//               dataincome: _payslips['data'][index]['income'],
//               name: "${_payslips['data'][index]['employee']['first_name']} ${_payslips['data'][index]['employee']['last_name']}",
//               effective_date: "${_payslips['data'][index]['employee']['careers'][0]['effective_date']}",
//               departement: "${_payslips['data'][index]['employee']['careers'][0]['department']['name']}",
//               work_placement: "${_payslips['data'][index]['employee']['work_placement']}",
//               employee_id: "${_payslips['data'][index]['employee']['employee_id']}",
//               lenghtWork: "${selisih.toString()} Hari",
//               period:  _payslips['data'][index]['name'],
//               dataDeduction: _payslips['data'][index]['deduction'],
//               totalDeduction: _payslips['data'][index]['total_deductions'].toString(),
//               totalIncome: _payslips['data'][index]['total_incomes'].toString(),
//               divisi: _payslips['data'][index]['employee']['careers'][0]['designation']['name'],
//               job_title: "",
//               status_karyawan: _payslips['data'][index]['employee']['careers'][0]['employee_status'],
//               pay_take_home: (_payslips['data'][index]['total_incomes']-_payslips['data'][index]['total_deductions']).toString(),
//
//               )));
//       },
//       child: Stack(
//         children: <Widget>[
//           Container(
//             width: double.infinity,
//             height: 120,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 Flexible(
//                   child: Container(
//                     width: double.infinity,
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                         left: 5,
//
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: <Widget>[
//                           Flexible(
//                             child: Container(
//                               width: double.infinity,
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   //container text
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Container(
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceEvenly,
//                                         children: <Widget>[
//                                           CircleAvatar(
//                                             backgroundColor: Colors.white,
//                                             radius: 30,
//                                             child: pyslip_letter,
//                                           ),
//                                           //
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   Flexible(
//                                     child: Container(
//                                       margin:
//                                           EdgeInsets.only(top: 10, left: 10),
//                                       width: MediaQuery.of(context).size.width,
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: <Widget>[
//                                           Row(
//                                             children: [
//                                               Text("Payslip karyawan",
//                                                   style: subtitleMainMenu),
//                                             ],
//                                           ),
//                                           // Text("Rifan Hidayat",
//                                           //     style: TextStyle(
//                                           //         fontSize: 15,
//                                           //         color: Colors.black26)),
//                                           Text(
//                                               "${_payslips['data'][index]['name']}",
//                                               style: TextStyle(
//                                                   fontSize: 13,
//                                                   color: Colors.black26)),
//                                           new Divider(
//                                             color: Colors.black38,
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildNopyslip() {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height * 0.8,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   child: no_data_payslip,
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                   "belum ada payslip",
//                   style: subtitleMainMenu,
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future getDatapref() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     setState(() {
//      user_id = sharedPreferences.getString("user_id");
//
//     });
//     setState(() {
//       dataPayslip(user_id.toString());
//     });
//
//   }
//
//   Future dataPayslip(var user_id) async {
//     try {
//       setState(() {
//         _loading = true;
//       });
//       http.Response response = await http.get("$base_url/api/employees/$user_id/payslips?type=${widget.type}");
//       _payslips = jsonDecode(response.body);
//
//       print(widget.type);
//       setState(() {
//         _loading = false;
//       });
//     } catch (e) {}
//   }
//
//   @override
//   void initState() {
//
//     // TODO: implement initState
//     super.initState();
//   getDatapref();
//   }
// }
