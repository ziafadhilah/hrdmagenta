import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hrdmagenta/page/employee/pyslip/PPFView.dart';
import 'package:hrdmagenta/utalities/font.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class DetailPyslip extends StatefulWidget {
  @override
  _DetailPyslipState createState() => _DetailPyslipState();
}

class _DetailPyslipState extends State<DetailPyslip> {
  double iconSize = 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: InkWell(
              onTap: () async {
                writeOnPdf();
                await savePdf();

                Directory documentDirectory = await getApplicationDocumentsDirectory();

                String documentPath = documentDirectory.path;

                String fullPath = "$documentPath/example.pdf";

                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => PdfPreview(path: fullPath,)
                ));


              },
              child: Icon(
                Icons.picture_as_pdf,
                color: Colors.black45,
              ),
            ),

            onPressed: () {
              // do something
              Navigator.pushNamed(context, "pdf_employee-page");

            },
          )
        ],
        iconTheme: IconThemeData(
          color: Colors.black87, //modify arrow color from here..
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Payslip Detail",
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
                  SizedBox(
                    height: 10,
                  ),
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
                    "Bagian ",
                    style: subtitleMainMenu,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Text(
                    "Job Title",
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
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: DataTable(
        headingRowColor: MaterialStateColor.resolveWith(
            (states) => Colors.green.withOpacity(0.25)),
        columnSpacing: 150,
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'Income',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Amount',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
        rows: const <DataRow>[
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Gaji Pokok',
                  style: TextStyle(fontFamily: 'SFReguler', fontSize: 15))),
              DataCell(Text(
                'IDR ',
                style: TextStyle(fontFamily: 'SFReguler', fontSize: 15),
              )),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text(
                'Tunjangan Harian',
                style: TextStyle(fontFamily: 'SFReguler', fontSize: 15),
              )),
              DataCell(Text(
                'IDR',
                style: TextStyle(fontFamily: 'SFReguler', fontSize: 15),
              )),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text(
                'Tunjangan Jabatan',
                style: TextStyle(fontFamily: 'SFReguler', fontSize: 15),
              )),
              DataCell(Text(
                'IDR',
                style: TextStyle(fontFamily: 'SFReguler', fontSize: 15),
              )),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text(
                'Tunjangan Komunikasi',
                style: TextStyle(fontFamily: 'SFReguler', fontSize: 15),
              )),
              DataCell(Text(
                'IDR',
                style: TextStyle(fontFamily: 'SFReguler', fontSize: 15),
              )),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text(
                'Total Income',
                style: TextStyle(
                    fontFamily: 'SFReguler',
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )),
              DataCell(Text(
                'IDR',
                style: TextStyle(
                    fontFamily: 'SFReguler',
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _builddeduction() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: DataTable(
        headingRowColor: MaterialStateColor.resolveWith(
            (states) => Colors.green.withOpacity(0.25)),
        columnSpacing: 150,
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'Deduction',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          DataColumn(
            label: Text(
              'Amount',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
        rows: const <DataRow>[
          DataRow(
            cells: <DataCell>[
              DataCell(Text('PPh21',
                  style: TextStyle(fontFamily: 'SFReguler', fontSize: 15))),
              DataCell(Text(
                'IDR 0',
                style: TextStyle(fontFamily: 'SFReguler', fontSize: 15),
              )),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text(
                '',
                style: TextStyle(fontFamily: 'SFReguler', fontSize: 15),
              )),
              DataCell(Text(
                '',
                style: TextStyle(fontFamily: 'SFReguler', fontSize: 15),
              )),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text(
                '',
                style: TextStyle(fontFamily: 'SFReguler', fontSize: 15),
              )),
              DataCell(Text(
                '',
                style: TextStyle(fontFamily: 'SFReguler', fontSize: 15),
              )),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text(
                '',
                style: TextStyle(fontFamily: 'SFReguler', fontSize: 15),
              )),
              DataCell(Text(
                '',
                style: TextStyle(fontFamily: 'SFReguler', fontSize: 15),
              )),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text(
                'Total Deduction',
                style: TextStyle(
                    fontFamily: 'SFReguler',
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )),
              DataCell(Text(
                'IDR 0434343242',
                style: TextStyle(
                    fontFamily: 'SFReguler',
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text(
                'Take Home Pay',
                style: TextStyle(
                    fontFamily: 'SFReguler',
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )),
              DataCell(Text(
                'IDR 0',
                style: TextStyle(
                    fontFamily: 'SFReguler',
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )),
            ],
          ),
        ],
      ),
    );
  }

  final pdf = pw.Document();

  writeOnPdf(){
    pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a5,
          margin: pw.EdgeInsets.all(32),

          build: (pw.Context context){
            return <pw.Widget>  [
              pw.Header(
                  level: 0,
                  child: pw.Text("Easy Approach Document")
              ),

              pw.Paragraph(
                  text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."
              ),

              pw.Paragraph(
                  text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."
              ),

              pw.Header(
                  level: 1,
                  child: pw.Text("Second Heading")
              ),

              pw.Paragraph(
                  text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."
              ),

              pw.Paragraph(
                  text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."
              ),

              pw.Paragraph(
                  text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."
              ),
            ];
          },


        )
    );
  }
  Future savePdf() async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String documentPath = documentDirectory.path;

    File file = File("$documentPath/example.pdf");

    //file.writeAsBytesSync(pdf.save());
  }
}
