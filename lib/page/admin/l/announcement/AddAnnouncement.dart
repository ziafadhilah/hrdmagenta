import 'dart:io';

import 'package:flutter/services.dart';

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
  var cfile = new TextEditingController();
  TextEditingController _controller = new TextEditingController();
  String _fileName = '...';
  String _path = '...';
  String _extension;
  bool _hasValidMime = false;
  //FileType _pickingType;
  File file1;

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
          "Buat pengumuman",
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
          labelText: 'Judul',

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
            labelText: 'Tanggal active',
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
            labelText: 'Tanggal Expired ',
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
          labelText: 'Pesan pengumuman',
        ),
      ),
    );
  }

  Widget _buildattachment() {
    return InkWell(
      onTap: () {
        _openFileExplorer();
      },
      child: Container(
        child: TextFormField(
          controller: cfile,
          cursorColor: Theme.of(context).cursorColor,
          enabled: false,
          decoration: InputDecoration(
            labelText: 'Lampiran',
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
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
  }


  void _openFileExplorer() async {
    // if (_pickingType != FileTyp.custom || _hasValidMime) {
    //
    //   try {
    //
    //     _path = await FilePicker.getFilePath(type:FileType.any);
    //   } on PlatformException catch (e) {
    //     print("Unsupported operation" + e.toString());
    //   }
    //
    //   if (!mounted) return;
    //
    //   setState(() {
    //     _fileName = _path != null ? _path.split('/').last : '...';
    //     cfile.text=_path;
    //   });
    // }
  }
}
