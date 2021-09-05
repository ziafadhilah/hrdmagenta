import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrdmagenta/page/employee/budget/imagefile.dart';
import 'package:hrdmagenta/services/api_clien.dart';
import 'package:hrdmagenta/utalities/color.dart';
import 'package:hrdmagenta/utalities/constants.dart';
import 'package:hrdmagenta/validasi/validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class RepaymentBudget extends StatefulWidget {
  RepaymentBudget({this.event_id, this.project_number, this.amount});

  var event_id, project_number, amount;

  @override
  _RepaymentBudgetState createState() => new _RepaymentBudgetState();
}

class _RepaymentBudgetState extends State<RepaymentBudget> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  File imageFile;
  VoidCallback _showPersBottomSheetCallBack;
  static const _locale = 'id';
  var Cnote = new TextEditingController();
  var Cammount = new TextEditingController();
  var Cfile = new TextEditingController();
  var ControllerDate = new TextEditingController();

  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  DateTime date = DateTime.now();
  Validasi validator = Validasi();
  bool _loading = false;
  List typeList;
  String _type,base65;
  var user_id, project_number, datePicker;

  //------------bottom sheet--------
  void _modalSheetphotos() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Card(
            elevation: 1,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //project
                        Text(
                          "Take Your Transation",
                          style: TextStyle(
                              fontFamily: "OpenSans",
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        new Divider(
                          color: Colors.black38,
                        ),
                        Container(
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    _getFromCamera();
                                  },
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          child: CircleAvatar(
                                            child: camera,
                                            radius: 27,
                                            backgroundColor: btnColor1,
                                          ),
                                        ),
                                        Text(
                                          "Camera",
                                          style: TextStyle(
                                            color: Colors.black38,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    _getFromGallery();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 40),
                                    child: Column(
                                      children: [
                                        Container(
                                          child: CircleAvatar(
                                            child: gallery,
                                            radius: 27,
                                            backgroundColor: btnColor1,
                                          ),
                                        ),
                                        Text(
                                          "Gelery",
                                          style: TextStyle(
                                            color: Colors.black38,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildamount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Amount',
          style: TextStyle(color: Colors.black87),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          height: 60.0,
          child: TextFormField(
            enabled: false,
            controller: Cammount,
            onChanged: (string) {
              string = '${_formatNumber(string.replaceAll('.', ''))}';
              Cammount.value = TextEditingValue(
                text: string,
                selection: TextSelection.collapsed(offset: string.length),
              );
            },
            cursorColor: Colors.black38,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.monetization_on_outlined,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildnote() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Note',
          style: TextStyle(color: Colors.black87),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          height: 60.0,
          child: TextFormField(
            controller: Cnote,
            cursorColor: Colors.black38,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.description,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildtypeexpense() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Akun Transfer',
            style: TextStyle(color: Colors.black87),
          ),
          Container(
            width: double.infinity,
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  value: _type,
                  iconSize: 30,
                  icon: (null),
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                  hint: Text('Select Akun'),
                  onChanged: (String newValue) {
                    setState(() {
                      _type = newValue;

                      print(_type);
                    });
                  },
                  items: typeList?.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(
                              "${item['bank_name']} (${item['account_number']})"),
                          value: item['id'].toString(),
                        );
                      })?.toList() ??
                      [],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildfile() {
    return Container(
      child: InkWell(
        onTap: () {
          //_getFromGallery();
          //_modalSheetphotos();
          _getFromCamera();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Upload File',
              style: TextStyle(color: Colors.black87),
            ),
            SizedBox(height: 10.0),
            Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              height: 60.0,
              child: TextFormField(
                controller: Cfile,
                enabled: false,
                cursorColor: Colors.black38,
                keyboardType: TextInputType.name,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.file_copy,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitbtn() {
    return Container(
      width: double.infinity,
      height: 45,
      margin: EdgeInsets.symmetric(vertical: 30),
      child: new OutlineButton(
        onPressed: () {
          print('base 65 ${base65.toString()}');

          var ammount = (Cammount.text.replaceAll(new RegExp(r'[^\w\s]+'), ''));
          validator.validation_transaction(
              context,
              ammount,
              datePicker,
              Cnote.text.trim(),
              widget.event_id,
              _type,
              user_id,
              base65.toString(),
              widget.project_number,
              "",
              "",
              'repayment',
              "");
        },
        child: Text(
          'SUBMIT',
          style: TextStyle(color: Colors.black87),
        ),
      ),
    );
  }

  Widget _buildDate() {
    return InkWell(
      onTap: () {
        _chooseDate(context);
      },
      child: Container(
        child: TextFormField(
          cursorColor: Theme.of(context).cursorColor,
          enabled: false,
          controller: ControllerDate,
          decoration: InputDecoration(
            labelText: 'Tanggal Transfer',
            labelStyle: TextStyle(),
            suffixIcon: Icon(
              Icons.date_range,
            ),
          ),
        ),
      ),
    );
  }

  _chooseDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,

      initialDate: date, // Refer step 1
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != date)
      setState(() {
        date = picked;
        final DateFormat formatterSubmit = DateFormat('yyyy-MM-dd');
        final DateFormat formatterShow = DateFormat('dd/MM/yyyy');
        var datePickerShow = formatterShow.format(date);
        var datePickerSubmit = formatterSubmit.format(date);
        datePicker = datePickerSubmit;
        ControllerDate.text = "$datePickerShow";
      });
  }

//functions
  /// Get from gallery
  _getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        //Toast.show("$imageFile", context);
        Cfile.text = imageFile.toString();

        print('dd ${base64.toString()}');
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        base65 = base64Encode(imageFile.readAsBytesSync());

        Cfile.text = imageFile.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black87, //modify arrow color from here..
        ),
        backgroundColor: Colors.white,
        title: new Text(
          "Transaksi",
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: _loading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: new Container(
                  child: Container(
                    color: Colors.white,
                    child: Center(
                      child: new Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              color: Colors.white,
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: Column(
                                children: [
                                  _buildtypeexpense(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _buildamount(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _buildDate(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _buildnote(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _buildfile(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  //image picker
                                  Container(
                                    margin: EdgeInsets.only(top: 15),
                                    child: imageFile == null
                                        ? Container()
                                        : InkWell(
                                      onTap: () {
                                        //aksesCamera();
                                        Get.to(ImageFile(
                                          image: imageFile,
                                        ));
                                      },
                                      child: new Image.file(imageFile,
                                          width: 200,
                                          height: 200,
                                          fit: BoxFit.fill),
                                    ),
                                  ),

                                  SizedBox(
                                    height: 10,
                                  ),
                                  _buildSubmitbtn(),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  //ge data from api--------------------------------
  Future _data_expense() async {
    try {
      _loading = true;

      http.Response response = await http.get("$baset_url_event/api/accounts");
      var data = jsonDecode(response.body);
      setState(() {
        typeList = data['data'].where((value) => value['id'] != 108).toList();
        typeList = typeList.where((value) => value['id'] != 100).toList();
        typeList = typeList.where((value) => value['id'] != 101).toList();
        //  _AnimatedMovies = AllMovies.where((i) => i.isAnimated).toList();
        _loading = false;
      });
    } catch (e) {}
  }

  void getDatapref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = sharedPreferences.getString("user_id");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Cammount.text =
        "${_formatNumber(widget.amount.toString().replaceAll('.', ''))}";
    _data_expense();
    getDatapref();
  }
}
