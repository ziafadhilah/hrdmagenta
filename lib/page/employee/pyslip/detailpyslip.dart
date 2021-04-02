import 'package:flutter/material.dart';
import 'package:hrdmagenta/utalities/font.dart';

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
        iconTheme: IconThemeData(
          color: Colors.black87, //modify arrow color from here..
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Pyslip Detail",
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height+50,
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
                _builddeduction()
              ],
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
      child: Expanded(
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
                  style: TextStyle(fontFamily: 'SFReguler', fontSize: 15,fontWeight: FontWeight.bold),
                )),
                DataCell(Text(
                  'IDR',
                  style: TextStyle(fontFamily: 'SFReguler', fontSize: 15,fontWeight: FontWeight.bold),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget _builddeduction() {
    return Expanded(


      child: Container(
        width: MediaQuery.of(context).size.width-10,
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
                  style: TextStyle(fontFamily: 'SFReguler', fontSize: 15,fontWeight: FontWeight.bold),
                )),
                DataCell(Text(
                  'IDR 0434343242',
                  style: TextStyle(fontFamily: 'SFReguler', fontSize: 15,fontWeight: FontWeight.bold),
                )),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text(
                  'Take Home Pay',
                  style: TextStyle(fontFamily: 'SFReguler', fontSize: 15,fontWeight: FontWeight.bold),
                )),
                DataCell(Text(
                  'IDR 0',
                  style: TextStyle(fontFamily: 'SFReguler', fontSize: 15,fontWeight: FontWeight.bold),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
