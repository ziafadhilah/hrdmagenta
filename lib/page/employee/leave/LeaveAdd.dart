import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LeaveAdd extends StatefulWidget {
  @override
  _LeaveAddState createState() => _LeaveAddState();
}

class _LeaveAddState extends State<LeaveAdd> {
  DateTime startdate = DateTime.now();
  DateTime enddate = DateTime.now();
  var Cstartdate=new TextEditingController();
  var Cenddate=new TextEditingController();
  var now;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black87, //modify arrow color from here..
        ),
        backgroundColor: Colors.white,
        title: new Text(
          "Add Leave",
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              _buildtglPengajuan(),
              _buildJatacuti(),
              _builJumlahambil(),
              _buildStartdate(),
              _buildEnddate(),
              _buildJmlPengambilan(),
              _buildketerangan()
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildtglPengajuan() {
    return Container(
      child: TextFormField(
        enabled: false,
        initialValue: '${now}',
        decoration: InputDecoration(
          labelText: 'tanggal Pengajuan',
        ),
      ),
    );
  }

  Widget _buildJatacuti() {
    return Container(
      child: TextFormField(
        initialValue: '0',
        decoration: InputDecoration(
          labelText: 'Jata Cuti',
        ),
      ),
    );
  }

  Widget _builJumlahambil() {
    return Container(
      child: TextFormField(
        initialValue: '0',
        decoration: InputDecoration(
          labelText: 'Jumlah Telah Diambil',
        ),
      ),
    );
  }

  Widget _buildStartdate() {
    return InkWell(
      onTap: (){
        _selectStartDate(context);

      },
      child: Container(
        child: TextFormField(
          cursorColor: Theme.of(context).cursorColor,

          enabled: false,
          controller: Cstartdate,
          decoration: InputDecoration(
            labelText: 'Start Date',
            labelStyle: TextStyle(),
            helperText: 'Helper text',
            suffixIcon: Icon(
              Icons.date_range,
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildEnddate() {
    return InkWell(
      onTap: (){
        _selectEndtDate(context);

      },
      child: Container(
        child: TextFormField(
          cursorColor: Theme.of(context).cursorColor,

          enabled: false,
          controller: Cenddate,
          decoration: InputDecoration(
            labelText: 'End Date',
            labelStyle: TextStyle(),

            suffixIcon: Icon(
              Icons.date_range,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildJmlPengambilan() {
    return Container(
      child: TextFormField(
        initialValue: '0',
        decoration: InputDecoration(
          labelText: 'Jumlah Pengambilan',
        ),
      ),
    );
  }
  Widget _buildketerangan() {
    return Container(
      child: TextFormField(
        initialValue: '',
        decoration: InputDecoration(
          labelText: 'Keterangan',
        ),
      ),
    );
  }

  _selectStartDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: startdate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != startdate)
      setState(() {
        startdate= picked;
        final DateFormat formatter = DateFormat('yyyy-MM-dd');
        var startdate1 = formatter.format(startdate);
        Cstartdate.text="$startdate1";
      });
  }
  _selectEndtDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: enddate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != enddate)
      setState(() {
        enddate = picked;
        final DateFormat formatter = DateFormat('yyyy-MM-dd');
        var enddate1 = formatter.format(enddate);
        Cenddate.text="$enddate1";
      });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final DateTime n = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    now = formatter.format(n);

  }
}
