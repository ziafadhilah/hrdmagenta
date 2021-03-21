import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrdmagenta/page/employee/absence/map_absence.dart';
import 'package:hrdmagenta/page/employee/absence/maprequest.dart';
import 'package:hrdmagenta/services/api_clien.dart';
import 'package:hrdmagenta/utalities/color.dart';
import 'package:hrdmagenta/utalities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
class detail_absence_admin extends StatefulWidget {
  detail_absence_admin({
    this.status,
    this.employee,
    this.date,
    this.time,
    this.latitude,
    this.image,
    this.type,
    this.longitude,
    this.note,
    this.approval_note,
    this.approved_by,
    this.approved_on,
    this.rejected_by,
    this.rejected_on,
    this.rejection_note,
    this.id




});

  var status,employee,type,date,time,
      latitude,longitude,image,approved_by,
      approved_on,rejected_by,rejected_on,note,rejection_note,approval_note,id;
  _detail_absence_adminState createState() => _detail_absence_adminState();
}

class _detail_absence_adminState extends State<detail_absence_admin> {
  var Cremark =new TextEditingController();
  var user_id;

  Widget _pic(){
    return Container(
      width: double.infinity,
      height: 300,
      color: Colors.red[200],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black87, //modify arrow color from here..
        ),

        backgroundColor: Colors.white,
        title: new Text("Absence Detail",
          style: TextStyle(color: Colors.black87),
        ),
      ),

      body :Container(
        margin: EdgeInsets.only(left: 15,right: 15,top: 15),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Flexible(
              child: Text("Submitted on 11 january 2021 16:34",
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 15
                ),
              ),
            ),

            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //row  1
                  Container(
                    width: MediaQuery.of(context).size.width/2,


                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //statu absence
                        Container(
                          child: Text("Status",
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 16
                          ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          child: widget.status=="pending"? Text("PENDING",
                            style: TextStyle(
                                color: Colors.amber,

                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            ),
                          ):widget.status=="rejected"?Text("REJECTED",
                            style: TextStyle(
                                color: Colors.red,

                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            ),
                          ):Text("APPROVED",
                            style: TextStyle(
                                color: Colors.green,

                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        //Type
                        Container(
                          child: Text("Type",
                            style: TextStyle(
                                color: Colors.black38,
                                fontSize: 16
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          child: Text("${widget.type}",
                            style: TextStyle(
                                color: Colors.black87,

                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),

                        //statu absence
                        Container(
                          child: Text("Photos",
                            style: TextStyle(
                                color: Colors.black38,
                                fontSize: 16
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          width: 100,
                          height: 100,

                          child: Image.network("${widget.image}",
                          width: 100,
                            height: 150,
                            fit: BoxFit.fill,
                            color: Colors.black,
                          )
                        ),
                        SizedBox(height: 20,),

                      ],
                    ),
                  ),
                  Flexible(
                    child: Container(
                      width: double.maxFinite,

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //statu absence
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text("Date",
                                  style: TextStyle(
                                      color: Colors.black38,
                                      fontSize: 16
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),

                          Container(
                            child: Text("${widget.date}",
                              style: TextStyle(
                                  color: Colors.black87,

                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          //Type
                          Container(
                            child: Text("Time",
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 16
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            child: Text("${widget.time}",
                              style: TextStyle(
                                  color: Colors.black87,

                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),

                          //statu absence
                          Container(
                            child: Text("Location",
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 16
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => Map_absence(latitude: widget.latitude,longitude: widget.longitude,)
                                  ));

                                },
                                child: Container(
                                    width: 100,
                                    height: 100,

                                    child: google_maps
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20,),



                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 50,),
            Container(
              child: widget.status=="rejected"?
              Container(child: _rejectdetail(),):
              widget.status=="approved"?
              Container(child: _approvedetail(),): widget.status=="pending"?
                  Container(child: _buildbtpending(),):Container()


            ),

          ],
        ),

      ),
    );


  }
  Widget _buildbtn(var status){
    return Container(

      child: new RaisedButton(

        textColor: Colors.white,
        color: btnColor1,

        onPressed: (){
         Services service=new Services();
         if (status=="Reject"){
           //Toast.show("reject ${Cremark.text}", context);


           service.approveAbsence(context, widget.id, user_id,"reject", "rejected_by", Cremark.text, "rejection_note");


         }else{
          // Toast.show("approve ${user_id}", context);
           service.approveAbsence(context, widget.id, user_id, "approve", "approved_by", Cremark.text, "approval_note");


         }


        },
        child: new Text("Submit"),
      ),
    );
  }

  Widget _buildremark() {
    return Container(
      margin: EdgeInsets.only(left: 25,right: 20),
      child: TextFormField(

        controller: Cremark,

        cursorColor: Theme.of(context).cursorColor,
        maxLength: 100,
        decoration: InputDecoration(

          labelText: 'Remark(Opsitional)',
          labelStyle: TextStyle(
            color: Colors.black38,
          ),

          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black38,

              )
          ),
        ),
      ),
    );
  }

  Widget _buildbtpending(){
    return Container(

      width: double.infinity,

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,

        children: <Widget>[
          Container(
            child: RaisedButton(
              elevation: 1.0,
              onPressed: () {
                _bottom_sheet('Reject');

              },
              padding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              color: Colors.red,
              child: Text(
                'Reject',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30),
            child: RaisedButton(
              elevation: 1.0,
              onPressed: () {
                _bottom_sheet("approve");

              },
              padding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              color: Colors.green,
              child: Text(
                'Approve',
                style: TextStyle(
                  color: Colors.white,

                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          )

        ],
      ),

    );

  }

  //------------bottom sheet--------
  void _bottom_sheet(var action) {
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
                        Text("$action",
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                _buildremark(),
                                _buildbtn(action)


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



  Widget _rejectdetail(){
    return Container(
      color: Colors.red[100],
      width: double.infinity,
      child: Container(

        margin: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //row  1
            Container(
              width: MediaQuery.of(context).size.width/2,


              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //statu absence
                  Container(
                    child: Text("Rejected By",
                      style: TextStyle(
                          color: Colors.black38,
                          fontSize: 16
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    child: Text("${widget.rejected_by}",
                      style: TextStyle(
                          color: Colors.black87,

                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  //Type
                  Container(
                    child: Text("Note",
                      style: TextStyle(
                          color: Colors.black38,
                          fontSize: 16
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    child: widget.rejection_note==null?Text("-"): Text("${widget.rejection_note}",
                      style: TextStyle(
                          color: Colors.black87,

                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      ),
                    ),
                  ),




                ],
              ),
            ),
            Flexible(
              child: Container(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    //statu absence
                    Container(
                      child: Text("Rejected Date",
                        style: TextStyle(
                            color: Colors.black38,
                            fontSize: 16
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      child: Text("${widget.rejected_on}",
                        style: TextStyle(
                            color: Colors.black87,

                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        ),
                      ),
                    ),
                    SizedBox(height: 55,)





                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _approvedetail(){
    return Container(
      color: Colors.green[100],
      width: double.infinity,
      child: Container(

        margin: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //row  1
            Container(
              width: MediaQuery.of(context).size.width/2,


              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //statu absence
                  Container(
                    child: Text("Approved By",
                      style: TextStyle(
                          color: Colors.black38,
                          fontSize: 16
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    child: Text("${widget.approved_by}",
                      style: TextStyle(
                          color: Colors.black87,

                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  //Type
                  Container(
                    child:Text("Note",
                      style: TextStyle(
                          color: Colors.black38,
                          fontSize: 16
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    child: widget.approval_note==null?Text("-"): Text("${widget.approval_note}",
                      style: TextStyle(
                          color: Colors.black87,

                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      ),
                    ),
                  ),




                ],
              ),
            ),
            Flexible(
              child: Container(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    //statu absence
                    Container(
                      child: Text("Approved Date",
                        style: TextStyle(
                            color: Colors.black38,
                            fontSize: 16
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      child: Text("${widget.approved_on}",
                        style: TextStyle(
                            color: Colors.black87,

                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        ),
                      ),
                    ),
                    SizedBox(height: 55,)





                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void getDatapref() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {


      user_id=sharedPreferences.getString("user_id");

    });



  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDatapref();

  }

}
