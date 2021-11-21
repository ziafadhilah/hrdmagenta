import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrdmagenta/model/pdf.dart';
import 'package:hrdmagenta/model/invoice.dart';
import 'package:hrdmagenta/services/api_pdf.dart';
import 'package:hrdmagenta/services/pdf_pyslip_api.dart';

import 'package:pdf/widgets.dart' as pw;

import 'package:hrdmagenta/utalities/font.dart';
import 'package:intl/intl.dart';
import 'package:json_table/json_table.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class DetailPyslip extends StatefulWidget {
  DetailPyslip({
    this.totalDeduction,
    this.dataDeduction,
    this.dataincome,
    this.takeHomepay,
    this.totalIncome,
    this.period,
    this.name,
    this.employee_id,
    this.departement,
    this.lenghtWork,
    this.work_placement,
    this.effective_date,
    this.divisi,
    this.job_title,
    this.status_karyawan,
    this.pay_take_home



  });

  var dataincome,
      dataDeduction,
      totalIncome,
      totalDeduction,
      takeHomepay,
      name,
      employee_id,
      departement,
      lenghtWork,
      work_placement,
      effective_date,
      divisi,
      job_title,
      status_karyawan,
      pay_take_home,
      period;



  @override
  _DetailPyslipState createState() => _DetailPyslipState();
}

class _DetailPyslipState extends State<DetailPyslip> {
  final String jsonSample ='[{"id":1,"name":"Gaji Pokok","type":"Jumlah Tetap","pph21":0,"type_a1":"type_a1_1","is_active":1,"company_id":null,"added_by":null,"deleted_at":null,"created_at":"2021-04-14T04:16:53.000000Z","updated_at":"2021-04-14T04:16:53.000000Z","pivot":{"pay_slip_id":1,"salary_income_id":1},"value":"5000000"},{"id":2,"name":"Tunjangan Harian","type":"Jumlah Tetap","pph21":0,"type_a1":"type_a1_1","is_active":1,"company_id":null,"added_by":null,"deleted_at":null,"created_at":"2021-04-14T04:17:10.000000Z","updated_at":"2021-04-14T04:17:10.000000Z","pivot":{"pay_slip_id":1,"salary_income_id":2},"value":"2000000"},{"id":3,"name":"Tunjangan Jabatan","type":"Jumlah Tetap","pph21":0,"type_a1":"type_a1_1","is_active":1,"company_id":null,"added_by":null,"deleted_at":null,"created_at":"2021-04-14T04:17:27.000000Z","updated_at":"2021-04-14T04:17:27.000000Z","pivot":{"pay_slip_id":1,"salary_income_id":3},"value":"1000000"}]';


  final String jsonSamplededuction =
      '[{"name":"PPh21","email":"ram@gmail.com","age":0,"income":"10Rs","country":"India","area":"abc"},{"name":"","email":"shyam23@gmail.com",'
      '"age":0,"income":"30Rs","country":"India","area":"abc","day":"Monday","month":"april"},{"name":"","email":"john@gmail.com","age":0,"income":"15Rs","country":"India",'
      '"area":"abc","day":"Monday","month":"april"},{"name":"","email":"ram@gmail.com","age":0,"income":"10Rs","country":"India","area":"abc","day":"Monday","month":"april"},'
      '{"name":"","email":"shyam23@gmail.com","age":0,"income":"30Rs","country":"India","area":"abc","day":"Monday","month":"april"}]';



  bool toggle = true;
  double iconSize = 40;
  var totalIncome=0;
  var totalDeduction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: InkWell(
              onTap: () async {
                _PayslipPdf();
              },
              child: Icon(
                Icons.download_outlined,
                color: Colors.black45,
              ),
            ),
            onPressed: () {
              // do something
              //Navigator.pushNamed(context, "pdf_employee-page");
              //savePdf();
            },
          )
        ],
        iconTheme: IconThemeData(
          color: Colors.black87, //modify arrow color from here..
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Detail Payslip",
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 10),
                    child: Text(
                      "${widget.period}",
                      style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,fontFamily: "SFReguler",fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _buildDataPersonal(),
                  SizedBox(
                    height: 10,
                  ),
                  //_buildIcome(),

                //  _builddeduction(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDataPersonal() {
    return Container(
      width: double.infinity,
      height: 150,
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(children: <Widget>[

        Container(child: Row(
          children: <Widget>[
            Container(
              width:Get.mediaQuery.size.width/3,
              child: Text("Nama",style: subtitleMainMenu,),
            ),

            Expanded(
              child: Text(":${widget.name}" ,style: subtitleMainMenu,),
            )
          ],
        ),),
        SizedBox(height: 5,),
        Container(child: Row(
          children: <Widget>[
            Container(
              width:Get.mediaQuery.size.width/3,

              child: Text("Employee ID",style: subtitleMainMenu,),
            ),

            Expanded(
              child: Text(":${widget.employee_id}" ,style: subtitleMainMenu,),
            )
          ],
        ),),
        SizedBox(height: 5,),
        Container(child: Row(
          children: <Widget>[
            Container(
              width:Get.mediaQuery.size.width/3,

              child: Text("Divisi ",style: subtitleMainMenu,),
            ),

            Expanded(
              child: Text(":${widget.divisi}" ,style: subtitleMainMenu,),
            )
          ],
        ),),
        SizedBox(height: 5,),
        Container(child: Row(
          children: <Widget>[
            Container(
              width:Get.mediaQuery.size.width/3,

              child: Text("Departemen ",style: subtitleMainMenu,),
            ),

            Expanded(
              child: Text(":${widget.departement}" ,style: subtitleMainMenu,),
            )
          ],
        ),),

        SizedBox(height: 5,),
        Container(child: Row(
          children: <Widget>[
            Container(
              width:Get.mediaQuery.size.width/3,

              child: Text("Bagian ",style: subtitleMainMenu,),
            ),

            Expanded(
              child: Text(":${widget.job_title}" ,style: subtitleMainMenu,),
            )
          ],
        ),),
        SizedBox(height: 5,),
        Container(child: Row(
          children: <Widget>[
            Container(
              width:Get.mediaQuery.size.width/3,

              child: Text("Status Karyawan ",style: subtitleMainMenu,),
            ),

            Expanded(
              child: Text(":${widget.status_karyawan}" ,style: subtitleMainMenu,),
            )
          ],
        ),),
      ],),
      // child: GridView.count(
      //   // todo comment this out and check the result
      //   physics: ClampingScrollPhysics(),
      //   shrinkWrap: true,
      //   primary: true,
      //   crossAxisCount: 2,
      //    children: <Widget>[
      //
      //   //   Container(
      //   //     child: Column(
      //   //       crossAxisAlignment: CrossAxisAlignment.start,
      //   //       children: <Widget>[
      //   //         Container(
      //   //           child: Text(
      //   //             "Nama",
      //   //             style: subtitleMainMenu,
      //   //           ),
      //   //         ),
      //   //         SizedBox(
      //   //           height: 5,
      //   //         ),
      //   //         Container(
      //   //           child: Text(
      //   //             "ID Karyawan",
      //   //             style: subtitleMainMenu,
      //   //           ),
      //   //         ),
      //   //         SizedBox(
      //   //           height: 5,
      //   //         ),
      //   //         Container(
      //   //           child: Text(
      //   //             "Divisi ",
      //   //             style: subtitleMainMenu,
      //   //           ),
      //   //         ),
      //   //         SizedBox(
      //   //           height: 5,
      //   //         ),
      //   //         Container(
      //   //           child: Text(
      //   //             "Departemen",
      //   //             style: subtitleMainMenu,
      //   //           ),
      //   //         ),
      //   //         SizedBox(
      //   //           height: 5,
      //   //         ),
      //   //         Container(
      //   //           child: Text(
      //   //             "Tanggal Bergabung",
      //   //             style: subtitleMainMenu,
      //   //           ),
      //   //         ),
      //   //         SizedBox(
      //   //           height: 5,
      //   //         ),
      //   //         Container(
      //   //           child: Text(
      //   //             "Lama Bekerja",
      //   //             style: subtitleMainMenu,
      //   //           ),
      //   //         ),
      //   //         SizedBox(
      //   //           height: 5,
      //   //         ),
      //   //       ],
      //   //     ),
      //   //   ),
      //   //   Container(
      //   //     child: Column(
      //   //       crossAxisAlignment: CrossAxisAlignment.start,
      //   //       children: <Widget>[
      //   //         Container(
      //   //           child: Text(
      //   //             ": ${widget.name}",
      //   //             style: subtitleMainMenu,
      //   //           ),
      //   //         ),
      //   //         SizedBox(
      //   //           height: 5,
      //   //         ),
      //   //         Container(
      //   //           child: Text(
      //   //             ": ${widget.employee_id}",
      //   //             style: subtitleMainMenu,
      //   //           ),
      //   //         ),
      //   //         SizedBox(
      //   //           height: 5,
      //   //         ),
      //   //         Container(
      //   //           child: Text(
      //   //             ": ${widget.work_placement} ",
      //   //             style: subtitleMainMenu,
      //   //           ),
      //   //         ),
      //   //         SizedBox(
      //   //           height: 5,
      //   //         ),
      //   //         Container(
      //   //           child: Text(
      //   //             ": ${widget.departement}",
      //   //             style: subtitleMainMenu,
      //   //           ),
      //   //         ),
      //   //         SizedBox(
      //   //           height: 5,
      //   //         ),
      //   //         Container(
      //   //           child: Text(
      //   //             ": ${widget.effective_date}",
      //   //             style: subtitleMainMenu,
      //   //           ),
      //   //         ),
      //   //         SizedBox(
      //   //           height: 5,
      //   //         ),
      //   //         Container(
      //   //           child: Text(
      //   //             ":${widget.lenghtWork}",
      //   //             style: subtitleMainMenu,
      //   //           ),
      //   //         ),
      //   //         SizedBox(
      //   //           height: 5,
      //   //         ),
      //   //       ],
      //   //     ),
      //   //   ),
      //   ],
      // ),
    );
  }
  //
  Widget _buildIcome() {
     var income = jsonDecode(jsonSample);
    // var deduction = jsonDecode(jsonSamplededuction);
    totalIncome=0;

    return SingleChildScrollView(

      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        width: Get.mediaQuery.size.width,
        child: Column(
          children: [
            JsonTable(
              income,
              allowRowHighlight: true,
              rowHighlightColor: Colors.yellow[500].withOpacity(0.7),
              tableHeaderBuilder: (String header) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5), color: Colors.grey[300]),
                  child: Text(
                    header,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.display1.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.0,
                        color: Colors.black),
                  ),
                );
              },
              tableCellBuilder: (value) {

                return Container(
                  width: Get.mediaQuery.size.width / 2 - 20,
                  height: 50,
                  alignment: value is int
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.5, color: Colors.grey.withOpacity(0.5))),
                  child: Text(
                    value,
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .display1
                        .copyWith(fontSize: 14.0, color: Colors.grey[900]),
                  ),
                );
              },
              columns: [

                JsonTableColumn(

                  "name",
                  label: "Income",
                ),
                JsonTableColumn('value',
                    label: "Amount", valueBuilder: numberCurrency),
                // JsonTableColumn("value",
                //     label: "Amount",),

              ],
              onRowSelect: (index, map) {

              },
            ),
            Container(
              color: Colors.grey[300],
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Table(
                border: TableBorder.all(),
                children: [
                  TableRow(children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total income',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            child: Text(
                              NumberFormat.currency(
                                      locale: 'id', decimalDigits: 0)
                                  .format(int.parse(widget.totalIncome)),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        ]),
                  ]),
                ],
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
          ],
        ),
      ),
    );
  }
  //
  // Widget _builddeduction() {
  //   var income = jsonDecode(widget.dataDeduction);
  //
  //
  //   return SingleChildScrollView(
  //     child: Container(
  //       margin: EdgeInsets.only(left: 10, right: 10),
  //       width: Get.mediaQuery.size.width,
  //       child: Column(
  //         children: [
  //           JsonTable(
  //             income,
  //             allowRowHighlight: true,
  //             rowHighlightColor: Colors.yellow[500].withOpacity(0.7),
  //             tableHeaderBuilder: (String header) {
  //               return Container(
  //                 padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
  //                 decoration: BoxDecoration(
  //                     border: Border.all(width: 0.5), color: Colors.grey[300]),
  //                 child: Text(
  //                   header,
  //                   textAlign: TextAlign.center,
  //                   style: Theme.of(context).textTheme.display1.copyWith(
  //                       fontWeight: FontWeight.w700,
  //                       fontSize: 14.0,
  //                       color: Colors.black),
  //                 ),
  //               );
  //             },
  //             tableCellBuilder: (value) {
  //
  //               return Container(
  //                 width: Get.mediaQuery.size.width / 2 - 20,
  //                 height: 50,
  //                 alignment: value is int
  //                     ? Alignment.centerRight
  //                     : Alignment.centerLeft,
  //                 padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
  //                 decoration: BoxDecoration(
  //                     border: Border.all(
  //                         width: 0.5, color: Colors.grey.withOpacity(0.5))),
  //                 child: Text(
  //                   value.toString(),
  //                   textAlign: TextAlign.left,
  //                   style: Theme.of(context)
  //                       .textTheme
  //                       .display1
  //                       .copyWith(fontSize: 14.0, color: Colors.grey[900]),
  //                 ),
  //               );
  //             },
  //             columns: [
  //
  //               JsonTableColumn(
  //                 "name",
  //                 label: "Deduction",
  //               ),
  //               JsonTableColumn('value',
  //                   label: "Amount",valueBuilder: currencyDeduction),
  //               // JsonTableColumn("value",
  //               //     label: "Amount",),
  //
  //             ],
  //             onRowSelect: (index, map) {
  //
  //             },
  //           ),
  //           Container(
  //             color: Colors.grey[300],
  //             margin: EdgeInsets.only(left: 10, right: 10),
  //             child: Table(
  //               border: TableBorder.all(),
  //               children: [
  //                 TableRow(children: [
  //                   Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           'Total Deduction',
  //                           style: TextStyle(fontWeight: FontWeight.bold),
  //                         )
  //                       ]),
  //                   Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Container(
  //                           margin: EdgeInsets.only(left: 5),
  //                           child: Text(
  //                             NumberFormat.currency(
  //                                 locale: 'id', decimalDigits: 0)
  //                                 .format(int.parse(widget.totalDeduction)),
  //                             style: TextStyle(fontWeight: FontWeight.bold),
  //                           ),
  //                         )
  //                       ]),
  //                 ]),
  //               ],
  //             ),
  //           ),
  //           Container(
  //             color: Colors.grey[300],
  //             margin: EdgeInsets.only(left: 10, right: 10),
  //             child: Table(
  //               border: TableBorder.all(),
  //               children: [
  //                 TableRow(children: [
  //                   Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           'Pay Take Home',
  //                           style: TextStyle(fontWeight: FontWeight.bold),
  //                         )
  //                       ]),
  //                   Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Container(
  //                           margin: EdgeInsets.only(left: 5),
  //                           child: Text(
  //                             NumberFormat.currency(
  //                                 locale: 'id', decimalDigits: 0)
  //                                 .format(int.parse(widget.totalIncome)-int.parse(widget.totalDeduction)),
  //                             style: TextStyle(fontWeight: FontWeight.bold),
  //                           ),
  //                         )
  //                       ]),
  //                 ]),
  //               ],
  //             ),
  //           ),
  //           SizedBox(
  //             height: 40.0,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }


  final pdf = pw.Document();

  writeOnPdf() {
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a5,
      margin: pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Header(level: 0, child: pw.Text("Easy Approach Document")),
          pw.Paragraph(
              text:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
          pw.Paragraph(
              text:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
          pw.Header(level: 1, child: pw.Text("Second Heading")),
          pw.Paragraph(
              text:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
          pw.Paragraph(
              text:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
          pw.Paragraph(
              text:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
        ];
      },
    ));
  }

  void _PayslipPdf() async {
    final date = DateTime.now();
    var income = jsonDecode(widget.dataincome);
    var deduction = jsonDecode(widget.dataDeduction);

    final invoice = Invoice(
      pdf: Pdf(
        employee_id: widget.employee_id,
        status_karyawan: widget.status_karyawan,
        name: widget.name,
        departement: widget.departement,
        division: widget.divisi,
        job_title: widget.job_title
      
      ),
  
    );

    final pdfFile = await PdfPyslipApi.generate(income,
        deduction,
        NumberFormat.currency(decimalDigits: 0,  locale: "id").format((int.parse(widget.totalIncome))),
        NumberFormat.currency(decimalDigits: 0,  locale: "id").format((int.parse(widget.totalDeduction))),
        NumberFormat.currency(decimalDigits: 0,  locale: "id").format((int.parse(widget.pay_take_home))),
        '${widget.period}',
        invoice);


    PdfApi.openFile(pdfFile);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }
   String numberCurrency(jsonObject) {

    var string =NumberFormat.currency(decimalDigits: 0,  locale: "id").format(int.parse(jsonObject.toString()));

    return string;

  }
  String currencyDeduction(jsonObject) {
    var string =NumberFormat.currency(decimalDigits: 0,  locale: "id").format(int.parse(jsonObject.toString()));


    return string;

  }


}
