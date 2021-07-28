import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hrdmagenta/services/api_clien.dart';
import 'package:hrdmagenta/utalities/color.dart';
import 'package:hrdmagenta/utalities/constants.dart';
import 'package:hrdmagenta/validasi/validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart'  as http;


class EditExpense extends StatefulWidget {
  EditExpense({

    this.account_id,
    this.description,
    this.amount,
    this.transaction_id,
    this.project_number,
    this.date,
    this.event_id
  });
  var project_number,account_id,amount,description,transaction_id,date,event_id;
  @override
  _EditExpenseState createState() => new _EditExpenseState();
}

class _EditExpenseState extends State<EditExpense> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  File imageFile;
  VoidCallback _showPersBottomSheetCallBack;
  static const _locale='id';
  var Cnote=new TextEditingController();
  var Cammount=new TextEditingController();
  var Cfile=new TextEditingController();
  var ControllerDate=new TextEditingController();
  String _formatNumber(String s) => NumberFormat.decimalPattern(_locale).format(int.parse(s));

  Validasi validator=Validasi();
  bool _loading=false;
  List typeList;
  String _type;
  var user_id,project_number,datePicker;

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
                        Text("Take Your Transation",
                          style: TextStyle(fontFamily: "OpenSans",
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold

                          ),
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
                                  onTap:(){
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
                                        Text("Camera",
                                          style: TextStyle(
                                            color: Colors.black38,

                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                InkWell(
                                  onTap: (){
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
                                        Text("Gelery",
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
          style: TextStyle(
              color: Colors.black87
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          height: 60.0,
          child:TextFormField(
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
          style: TextStyle(
              color: Colors.black87
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          height: 60.0,
          child:TextFormField(
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
            style: TextStyle(
                color: Colors.black87
            ),
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
                      child: new Text("${item['bank_name']} (${item['account_number']})"),
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
        onTap: (){
          //_getFromGallery();
          //_modalSheetphotos();
          _getFromCamera();

        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Upload File',
              style: TextStyle(
                  color: Colors.black87
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              height: 60.0,
              child:TextFormField(
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
      child: new  OutlineButton(
        onPressed: () {

          var ammount=(Cammount.text.replaceAll(new RegExp(r'[^\w\s]+'),''));
          validator.validation_transaction(context, ammount, datePicker, Cnote.text.trim(), widget.event_id,_type, user_id, "",widget.project_number,widget.transaction_id,'update');

          },
        child: Text('SUBMIT',
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
    var date=DateTime.parse("${widget.date}");
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
        datePicker=datePickerSubmit;
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
        Cfile.text=imageFile.toString();
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

        Cfile.text=imageFile.toString();

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
        title: new Text("Transaksi",
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: _loading==true?Center(child: CircularProgressIndicator(),):SingleChildScrollView(
          child: new Container(
            child: Container(
              color: Colors.white,
              child: Center(
                child: new Column(
                  children: <Widget>[

                    SizedBox(height: 10,),
                    Container(
                        color: Colors.white,
                        margin: EdgeInsets.only(left: 20,right: 20),
                        child: Column(
                          children: [
                            _buildtypeexpense(),
                            SizedBox(height: 10,),
                            _buildamount(),
                            SizedBox(height: 10,),
                            _buildDate(),

                            SizedBox(height: 10,),
                            _buildnote(),

                            SizedBox(height: 10,),
                            _buildfile(),

                            SizedBox(height: 10,),
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
  Future _data_expense() async{
    try{
      _loading=true;

      http.Response response=await http.get("$baset_url_event/api/accounts");
      var data=jsonDecode(response.body);
      setState(() {
        typeList = data['data'];
        _loading=false;
      });

    }catch(e){

    }

  }
  void getDatapref() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      user_id=sharedPreferences.getString("user_id");
    });
  }
  @override
  void initState() {
    Cnote.text=widget.description;
    ControllerDate.text=DateFormat('dd/MM/yyyy').format(DateTime.parse("${widget.date}")).toString();
    datePicker=DateFormat('yyyy-MM-dd').format(DateTime.parse("${widget.date}")).toString();
    Cammount.text=widget.amount;
    _type=widget.account_id;
    // TODO: implement initState
    super.initState();
    _data_expense();
    getDatapref();
  }

}