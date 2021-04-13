import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddAnnouncement extends StatefulWidget {
  @override
  _AddAnnouncementState createState() => _AddAnnouncementState();
}

class _AddAnnouncementState extends State<AddAnnouncement> {
  DateTime startdate = DateTime.now();
  DateTime enddate = DateTime.now();
  var Cstartdate = new TextEditingController();
  var Cenddate = new TextEditingController();

  // ZefyrController _controller;
  // FocusNode _focusNode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black87, //modify arrow color from here..
        ),
        backgroundColor: Colors.white,
        title: new Text(
          "Add Announcement",
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                _buildtitle(),
                _buildStartdate(),
                _buildEnddate(),
                _buildmessage(),
                _buildattachment()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildtitle() {
    return Container(
      child: TextFormField(
        initialValue: '',
        decoration: InputDecoration(
          labelText: 'Tittle',
        ),
      ),
    );
  }

  Widget _buildStartdate() {
    return InkWell(
      onTap: () {
        _selectStartDate(context);
      },
      child: Container(
        child: TextFormField(
          cursorColor: Theme.of(context).cursorColor,
          enabled: false,
          controller: Cstartdate,
          decoration: InputDecoration(
            labelText: 'Active Date',
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
      onTap: () {
        _selectEndtDate(context);
      },
      child: Container(
        child: TextFormField(
          cursorColor: Theme.of(context).cursorColor,
          enabled: false,
          controller: Cenddate,
          decoration: InputDecoration(
            labelText: 'Expired Date',
            labelStyle: TextStyle(),
            suffixIcon: Icon(
              Icons.date_range,
            ),
          ),
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
        startdate = picked;
        final DateFormat formatter = DateFormat('yyyy-MM-dd');
        var startdate1 = formatter.format(startdate);
        Cstartdate.text = "$startdate1";
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
        Cenddate.text = "$enddate1";
      });
  }

  // Widget _buildmessage() {
  //   return Container(
  //     child: ZefyrScaffold(
  //       child: ZefyrEditor(
  //         padding: EdgeInsets.all(16),
  //         controller: _controller,
  //         focusNode: _focusNode,
  //       ),
  //     )
  //   );
  // }
  Widget _buildmessage() {
    return Container(
      child: TextFormField(
        maxLines: null,
        keyboardType: TextInputType.multiline,
        initialValue: '',
        decoration: InputDecoration(
          labelText: 'Message',
        ),
      ),
    );
  }

  Widget _buildattachment() {
    return InkWell(
      onTap: () {
        _attechment();
      },
      child: Container(
        child: TextFormField(
          cursorColor: Theme.of(context).cursorColor,
          enabled: false,
          decoration: InputDecoration(
            labelText: 'attachment',
            labelStyle: TextStyle(),
            suffixIcon: Icon(
              Icons.file_copy,
            ),
          ),
        ),
      ),
    );
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   final document= _loadDocument();
  //   _controller=ZefyrController(document);
  //   _focusNode=FocusNode();
  // }
  // NotusDocument _loadDocument(){
  //   final Delta delta=Delta()..insert("INSER ");
  //   return NotusDocument.fromDelta(delta);
  //
  // }

  Future _attechment() async {
    //   FilePickerResul result = await FilePicker.platform.pickFiles();
    //
    //   if(result != null) {
    //     PlatformFile file = result.files.first;
    //
    //     print(file.name);
    //     print(file.bytes);
    //     print(file.size);
    //     print(file.extension);
    //     print(file.path);
    //   } else {
    //     // User canceled the picker
    //   }
    // }
  }
}
