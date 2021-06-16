import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:hrdmagenta/model/customer.dart';
import 'package:hrdmagenta/model/employee.dart';
import 'package:hrdmagenta/model/invoice.dart';
import 'package:hrdmagenta/model/supplier.dart';

import 'package:hrdmagenta/services/pdf_pyslip_api.dart';
import 'package:intl/intl.dart';
import 'package:json_table/json_table.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class PdfPyslipApi {
  static Future<File> generate(
      var income, var deduction,var totalIncome,totalDeduction,var totalTakeHomePay,var period, Invoice invoice) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildTitle(period),
        pw.Row(children: [
          pw.Container(
            child: ColumnLeft(invoice),
          ),
          pw.Container(
            margin: EdgeInsets.only(left: 30),
            child: ColumnRight(invoice),
          )
        ]),
        buildIncome(income),
        buildtotalincome(totalIncome),

        pw.SizedBox(height: 20),
        buildDeduction(deduction),
        buildtotaldeduction(totalDeduction, totalTakeHomePay),
      ],
      // footer: (context) => buildFooter(invoice),
    ));

    return PdfApi.saveDocument(name: 'pyslip.pdf', pdf: pdf);
  }

  static Widget buildTitle(var datetime) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${datetime}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildCustomerAddress(Customer customer) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(customer.name, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(customer.address),
        ],
      );

  static Widget namaEmployee(Customer customer) => Row(children: [
        Container(width: 70, child: Text("Nama")),
        Container(margin: pw.EdgeInsets.only(left: 10), child: Text(": ")),
        Container(child: Text(customer.name.toString()))
      ]);

  static Widget EmployeeID(Customer customer) => Row(children: [
        Container(width: 70, child: Text("Employee ID")),
        Container(margin: pw.EdgeInsets.only(left: 10), child: Text(": ")),
        Container(child: Text(customer.employee_id.toString()))
      ]);

  static Widget Bagina(Customer customer) => Row(children: [
        Container(width: 70, child: Text("penempatan")),
        Container(margin: pw.EdgeInsets.only(left: 10), child: Text(": ")),
        Container(child: Text(customer.work_placement.toString()))
      ]);

  static Widget JobTitle(Customer customer) => Row(children: [
        Container(width: 70, child: Text("Departement")),
        Container(margin: pw.EdgeInsets.only(left: 10), child: Text(": ")),
        Container(child: Text(customer.bagian.toString()))
      ]);

  static Widget StatusKaryawan(Customer customer) => Row(children: [
        Container(width: 120, child: Text("Status Karyawan")),
        Container(margin: pw.EdgeInsets.only(left: 5), child: Text(": ")),
        Container(child: Text(""))
      ]);

  static Widget StatusPTKP(Customer customer) => Row(children: [
        Container(width: 120, child: Text("Status PTKP")),
        Container(margin: pw.EdgeInsets.only(left: 5), child: Text(": ")),
        Container(child: Text(customer.status_ptkp.toString()))
      ]);

  static Widget TanggalBergabung(Customer customer) => Row(children: [
        Container(width: 120, child: Text("Tanggal Bergabung")),
        Container(margin: pw.EdgeInsets.only(left: 5), child: Text(":")),
        Container(child: Text(customer.tgl_bergabung.toString()))
      ]);

  static Widget LamaBekerja(Customer customer) => Row(children: [
        Container(width: 120, child: Text("Lama bekerja")),
        Container(margin: pw.EdgeInsets.only(left: 5), child: Text(":")),
        Container(child: Text(customer.lama_bekerja.toString()))
      ]);

  static Widget ColumnLeft(Invoice invoice) =>
      Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        namaEmployee(invoice.customer),
        pw.SizedBox(height: 5),
        EmployeeID(invoice.customer),
        pw.SizedBox(height: 5),
        Bagina(invoice.customer),
        pw.SizedBox(height: 5),
        JobTitle(invoice.customer),
        pw.SizedBox(height: 20),
      ]);

  static Widget ColumnRight(Invoice invoice) =>
      Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        StatusKaryawan(invoice.customer),
        pw.SizedBox(height: 5),
        StatusPTKP(invoice.customer),
        pw.SizedBox(height: 5),
        TanggalBergabung(invoice.customer),
        pw.SizedBox(height: 5),
        LamaBekerja(invoice.customer),
        pw.SizedBox(height: 20),
      ]);

  static Widget buildIncome(List invoice) {
    final headers = [
      'Income',
      'Ammount',
    ];
    final data = invoice.map((item) {
      return [
        item['name'],
        //Utils.formatDate(item.date),
        NumberFormat.currency(locale: 'id', decimalDigits: 0)
            .format(item['age'])
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
      },
    );
  }

  static Widget buildtotalincome(var totalIncome) {


    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [

          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Divider(),
                buildText(
                  title: 'Total Income',
                  titleStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  value: "${totalIncome}",
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }
  static Widget buildtotaldeduction(var totalDeduction,var takehomepay,) {


    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [

          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Divider(),
                buildText(
                  title: 'Total deduction',
                  titleStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  value: "${totalDeduction}",
                  unite: true,
                ),

                Divider(),
                buildText(
                  title: 'Take Home Pay',
                  titleStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  value: "${takehomepay}",
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildDeduction(List invoice) {
    final headers = [
      'Deduction',
      'Amount',
    ];
    final data = invoice.map((item) {
      return [
        item['name'],
        //Utils.formatDate(item.date),
        NumberFormat.currency(locale: 'id', decimalDigits: 0)
            .format(item['age'])
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
      },
    );
  }

  String numberCurrency(jsonObject) {
    String string = NumberFormat.currency(locale: 'id', decimalDigits: 0)
        .format(jsonObject);

    return string;
  }

  static buildText({
    String title,
    String value,
    double width = double.infinity,
    TextStyle titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
