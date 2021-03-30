import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hrdmagenta/page/employee/absence/detail.dart';
import 'package:hrdmagenta/page/employee/absence/shimmer_effect.dart';
import 'package:hrdmagenta/services/api_clien.dart';
import 'package:hrdmagenta/utalities/color.dart';
import 'package:hrdmagenta/utalities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class absence_status extends StatefulWidget {
  absence_status({
    this.type

  });
  var type;
  @override
  _absence_statusState createState() => _absence_statusState();
}

class _absence_statusState extends State<absence_status> {
  var user_id;

  Map _absence;
  bool _loading=true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: _loading?Center(child: ShimmerAbsence(),):  ListView.builder(
          // itemCount: _budgeting['data']['cash_flow'].length,
            itemCount: _absence['data'].length==0?1:_absence['data'].length,
            itemBuilder:(context,index){

              return _absence['data'].length==0? _buildnodata(): _buildlistabsence(index);
            }),

        //
      ),
    );
  }

  Widget _buildlistabsence(index){
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 100,
          child: Card(
            elevation: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5,top: 10,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: <Widget>[
                          Flexible(
                            child: Container(

                              width: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  //container text
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(


                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10,left: 10),
                                      width: MediaQuery.of(context).size.width,

                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[

                                          Row(
                                            children: [
                                              Text("you ",style: TextStyle(
                                                  fontSize: 18,
                                                  color: textColor1
                                              ),),
                                              Text("Have been ${_absence['data'][index]['type']}",style: TextStyle(
                                                  fontSize: 15,color: Colors.black87
                                              )),

                                            ],
                                          ),
                                          Text("22 years ago",style: TextStyle(
                                              fontSize: 15,color: Colors.black26
                                          )

                                          ),

                                          InkWell(
                                            onTap: (){
                                              if (_absence['data'][index]['type']=="check in"){
                                                Navigator.push(context, MaterialPageRoute(
                                                    builder: (context) => detail_absence(
                                                      status: widget.type,
                                                      date: _absence['data'][index]['date'],
                                                      time: _absence['data'][index]['clock_in'],
                                                      image: _absence['data'][index]['image'],
                                                      latitude: _absence['data'][index]['clock_in_latitude'],
                                                      longitude: _absence['data'][index]['clock_in_longitude'],
                                                      type: _absence['data'][index]['type'],
                                                      rejected_by: _absence['data'][index]['rejected_by']==null?"null":"${_absence['data'][index]['rejected_by']['first_name']} ${_absence['data'][index]['rejected_by']['last_name']}",
                                                      approved_by: _absence['data'][index]['approved_by']==null?"null":"${_absence['data'][index]['approved_by']['first_name']} ${_absence['data'][index]['approved_by']['last_name']}",
                                                      rejected_on: _absence['data'][index]['rejected_at'],
                                                      rejection_note: _absence['data'][index]['rejection_note'],
                                                      approval_note: _absence['data'][index]['approval_note'],

                                                      approved_on: _absence['data'][index]['approved_at'],
                                                      note: _absence['data'][index]['note'],



                                                    )
                                                ));

                                              }else{
                                                Navigator.push(context, MaterialPageRoute(
                                                    builder: (context) => detail_absence(
                                                      status: widget.type,
                                                      date: _absence['data'][index]['date'],
                                                      time: _absence['data'][index]['clock_out'],
                                                      image: _absence['data'][index]['image'],
                                                      latitude: _absence['data'][index]['clock_out_latitude'],
                                                      longitude: _absence['data'][index]['clock_out_longitude'],
                                                      type: _absence['data'][index]['type'],
                                                      rejected_by: _absence['data'][index]['rejected_by']==null?"null":"${_absence['data'][index]['rejected_by']['first_name']} ${_absence['data'][index]['rejected_by']['last_name']}",
                                                      approved_by: _absence['data'][index]['approved_by']==null?"null":"${_absence['data'][index]['approved_by']['first_name']} ${_absence['data'][index]['approved_by']['last_name']}",
                                                      rejected_on: _absence['data'][index]['rejected_at'],
                                                      rejection_note: _absence['data'][index]['rejection_note'],
                                                      approval_note: _absence['data'][index]['approval_note'],

                                                      approved_on: _absence['data'][index]['approved_at'],
                                                      note: _absence['data'][index]['note'],

                                                    )
                                                ));

                                              }


                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(right: 5,bottom: 5,),
                                              width: double.infinity,

                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  Container(
                                                    child: Text("See Details",
                                                      style: TextStyle(
                                                          color: textColor1
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
                                  ),

                                ],

                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),

                ),


              ],
            ),

          ),
        ),

      ],


    );
  }

  Widget _buildnodata(){
    return Container(
      height: MediaQuery.of(context).size.height-150,

      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: no_data_project,
            ),
            SizedBox(height: 20,),
            Container(
                child: Text("No absence yet",
                  style: TextStyle(
                      color: Colors.black38,
                      fontSize: 18
                  ),

                )
            ),
          ],
        ),
      ),
    );
  }




  //ge data from api--------------------------------
  Future _dataAbsence(var user_id) async{
    try{
      setState(() {
        _loading=true;
      });
      http.Response response=await http.get("http://${base_url}/api/employees/$user_id/attendances?status=${widget.type}");
      _absence=jsonDecode(response.body);
      setState(() {
        _loading=false;
      });
    }catch(e){

    }

  }
  void getDatapref() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {

      user_id=sharedPreferences.getString("user_id");
      _dataAbsence(user_id);

    });



  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDatapref();

  }

}




