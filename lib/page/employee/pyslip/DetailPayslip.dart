import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrdmagenta/model/customer.dart';
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
      period;

  @override
  _DetailPyslipState createState() => _DetailPyslipState();
}

class _DetailPyslipState extends State<DetailPyslip> {
  final String jsonSample =
      '[{"name":"Gaji Pokok","email":"ram@gmail.com","age":0,"income":"10Rs","country":"India","area":"abc"},{"name":"Jamsostek","email":"shyam23@gmail.com",'
      '"age":0,"income":"30Rs","country":"India","area":"abc","day":"Monday","month":"april"},{"name":"Tunjangan harian","email":"john@gmail.com","age":0,"income":"15Rs","country":"India",'
      '"area":"abc","day":"Monday","month":"april"},{"name":"Tunjangan Jabatan","email":"ram@gmail.com","age":0,"income":"10Rs","country":"India","area":"abc","day":"Monday","month":"april"},'
      '{"name":"Tunjangan Komunikasi","email":"shyam23@gmail.com","age":0,"income":"30Rs","country":"India","area":"abc","day":"Monday","month":"april"}]';


  final String jsonSamplededuction =
      '[{"name":"PPh21","email":"ram@gmail.com","age":0,"income":"10Rs","country":"India","area":"abc"},{"name":"","email":"shyam23@gmail.com",'
      '"age":0,"income":"30Rs","country":"India","area":"abc","day":"Monday","month":"april"},{"name":"","email":"john@gmail.com","age":0,"income":"15Rs","country":"India",'
      '"area":"abc","day":"Monday","month":"april"},{"name":"","email":"ram@gmail.com","age":0,"income":"10Rs","country":"India","area":"abc","day":"Monday","month":"april"},'
      '{"name":"","email":"shyam23@gmail.com","age":0,"income":"30Rs","country":"India","area":"abc","day":"Monday","month":"april"}]';



  bool toggle = true;

  double iconSize = 40;

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
                Icons.picture_as_pdf,
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
                      "2 maret 2021 - 2 April 2021",
                      style: titleMainMenu,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _buildDataPersonal(),
                  SizedBox(
                    height: 10,
                  ),
                  _buildIcome(),

                  _builddeduction(),
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
      child: GridView.count(
        // todo comment this out and check the result
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        primary: true,
        crossAxisCount: 2,
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    "Nama",
                    style: subtitleMainMenu,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Text(
                    "ID Karyawan",
                    style: subtitleMainMenu,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Text(
                    "Divisi ",
                    style: subtitleMainMenu,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Text(
                    "Departement",
                    style: subtitleMainMenu,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Text(
                    "Tanggal Bergabung",
                    style: subtitleMainMenu,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Text(
                    "Lama Bekerja",
                    style: subtitleMainMenu,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    ": Rifan hidayat",
                    style: subtitleMainMenu,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Text(
                    ": 11",
                    style: subtitleMainMenu,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Text(
                    ": Office ",
                    style: subtitleMainMenu,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Text(
                    ": Programer",
                    style: subtitleMainMenu,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Text(
                    ": 1 November 2020",
                    style: subtitleMainMenu,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Text(
                    ": 1 tahun",
                    style: subtitleMainMenu,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcome() {
    var income = jsonDecode(jsonSample);
    var deduction = jsonDecode(jsonSamplededuction);

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
                  alignment: value is int
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.5, color: Colors.grey.withOpacity(0.5))),
                  child: Text(
                    value,
                    textAlign: TextAlign.center,
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
                JsonTableColumn("age",
                    label: "Amount", valueBuilder: numberCurrency),
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
                                  .format(0),
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

  Widget _builddeduction() {

    var deduction = jsonDecode(jsonSamplededuction);

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        width: Get.mediaQuery.size.width,
        child: Column(
          children: [
            JsonTable(
              deduction,
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
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.5, color: Colors.grey.withOpacity(0.5))),
                  child: Text(
                    value,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .display1
                        .copyWith(fontSize: 14.0, color: Colors.grey[900]),
                  ),
                );
              },
              columns: [
                JsonTableColumn("name", label: "Dedcution"),
                JsonTableColumn("age",
                    label: "Amount", valueBuilder: numberCurrency),
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
                            'Total Deduction',
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
                                  .format(0),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        ]),
                  ]),
                  TableRow(children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Take Home Pay',
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
                                  .format(0),
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
    var income = jsonDecode(jsonSample);
    var deduction = jsonDecode(jsonSamplededuction);

    final invoice = Invoice(
      customer: Customer(
        name: "Rifan Hidayat",
        status_ptkp: "2131",
        lama_bekerja: "1 tahun",
        work_placement: "Event organizer",
        bagian: "Programer",
        employee_id: "EP-2321",
        tgl_bergabung: "22 november 2020",
        job_title: "stasda",
        status_karyawan: "Freelancer",
        address: 'Apple Street, Cupertino, CA 95014',
      ),
      items: [
        InvoiceItem(
            name: "Rifan Hidayat",
            age: "11",
            country: "Bandung",
            income: "11111",
            email: "roafsd",
            area: "bandung"),
        InvoiceItem(
            name: "Rifan Hidayat",
            age: "11",
            country: "Bandung",
            income: "11111",
            email: "roafsd",
            area: "bandung"),
        InvoiceItem(
            name: "Rifan Hidayat",
            age: "11",
            country: "Bandung",
            income: "11111",
            email: "roafsd",
            area: "bandung"),
        InvoiceItem(
            name: "Rifan Hidayat",
            age: "11",
            country: "Bandung",
            income: "11111",
            email: "roafsd",
            area: "bandung"),
      ],
      itemss: [
        DeductionItem(
          description: 'PPh21',
          unitPrice: "IDR 0",
        ),
        DeductionItem(
          description: '',
          unitPrice: "",
        ),
        DeductionItem(
          description: '',
          unitPrice: "",
        ),
        DeductionItem(
          description: '',
          unitPrice: "",
        ),
        DeductionItem(
          description: 'Total Deduction',
          unitPrice: "IDR 0",
        ),
        DeductionItem(
          description: 'Take Home Pay',
          unitPrice: "IDR 0",
        ),
      ],
    );

    final pdfFile = await PdfPyslipApi.generate(income, deduction, "0",
        '0', '0', '22 november 2020', invoice);


    PdfApi.openFile(pdfFile);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String numberCurrency(jsonObject) {
    String string = NumberFormat.currency(locale: 'id', decimalDigits: 0)
        .format(jsonObject);

    return string;
  }
}
