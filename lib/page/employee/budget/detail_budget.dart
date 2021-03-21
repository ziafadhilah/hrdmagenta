import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
class detailBudget extends StatefulWidget {
  detailBudget({
    this.usage_budget,this.remaining,this.requested_by,
    this.requested_on,this.budget_usage_category,
    this.note,this.image,this.date_by,this.admin_by,this.status,this.note_admin,this.type

});
  var usage_budget,requested_date,remaining,requested_by,requested_on,budget_usage_category,note,image,admin_by,date_by,status,note_admin,type;

  @override
  _detailBudgetState createState() => _detailBudgetState();
}

class _detailBudgetState extends State<detailBudget> {
  var requested_date,requested_time;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(

       child:Image.network(
              "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/ReceiptSwiss.jpg/180px-ReceiptSwiss.jpg",
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,

          ),
        ),
        Scaffold(

            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text("Usage"),
              backgroundColor: Colors.black12,
              elevation: 0.0,
            ),

            body: SingleChildScrollView(

                child:Container(
                  color: Colors.transparent,

                  margin: EdgeInsets.only(top: 300),

                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          side: BorderSide(width: 5, color: Colors.white)),
                      child: Container(
                        margin: EdgeInsets.only(top: 50,left: 20,right: 20,bottom: 20),
                        child: Column(
                          children: <Widget>[
                            ///Container bugget usage
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: Text("Usage Budget",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 15
                                      ),

                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: double.maxFinite,

                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text("IDR ${widget.usage_budget}",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 18
                                          ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),

                            ///remaining
                            //Container bugget usage
                            Container(
                              child: Row(
                                children: <Widget>[
                                  // Container(
                                  //   child: Text("Remaining",
                                  //     style: TextStyle(
                                  //         color: Colors.black87,
                                  //         fontSize: 15
                                  //     ),
                                  //
                                  //   ),
                                  // ),
                                  // Flexible(
                                  //   child: Container(
                                  //     width: double.maxFinite,
                                  //
                                  //     child: Column(
                                  //       crossAxisAlignment: CrossAxisAlignment.end,
                                  //       children: [
                                  //         Text("IDR 200.000",
                                  //           style: TextStyle(
                                  //               color: Colors.green,
                                  //               fontSize: 18
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                            new Divider(
                              color: Colors.black38,
                            ),


                            ///requuested on
                            SizedBox(height: 20,),

                            //remaining
                            //Container bugget usage
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: Text("Date",
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 15
                                      ),

                                    ),
                                  ),

                                  Flexible(
                                    child: Container(
                                      width: double.maxFinite,

                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: 100,

                                            child: Text("${requested_date}",
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 15
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                            Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    child: Text("Time",
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 15
                                      ),

                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: double.maxFinite,


                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: 100
                                            ,

                                            child: Text("${requested_time}",
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 15
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            ///usage category
                            SizedBox(height: 10,),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: Text("Type",
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 15
                                      ),

                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: double.maxFinite,

                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text("${widget.type}",
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 15
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),

                            //remaining
                            //Container bugget usage
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: Text("Budget usage Category",
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 15
                                      ),

                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: double.maxFinite,

                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text("${widget.budget_usage_category}",
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 15
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            ///Description
                            SizedBox(height: 10,),
                            //Container bugget usage
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: Text("Note",
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 15
                                      ),

                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: double.maxFinite,

                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            child: widget.note==null?Text("-",style: TextStyle(color: Colors.black),): Text("${widget.note}",
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 15
                                              ),

                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 20,),
                           _buildpending()

                          ],
                        ),
                      ),
                    )
                )

            ))
      ],
    );
  }
  Widget _builapprove(){
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      width: double.maxFinite,
      color: Colors.green,


      child: Column(
        children: <Widget>[
          Container(
            width: double.maxFinite,
            height: 50,
            color: Colors.green[100],
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle,
                    color: Colors.green,



                  ),

                  SizedBox(
                    height: 20,
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        "APPROVED",
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold
                        ),

                      ),

                    ),
                  ),

                ],
              ),
            ),
          ),
          ///Approve By
          SizedBox(height: 20,),
          //Container bugget usage
          Container(
            margin: EdgeInsets.all(5),
            child: Row(
              children: <Widget>[
                Container(
                  child: Text("Approved by",
                    style: TextStyle(

                        color: Colors.white,
                        fontSize: 15
                    ),

                  ),
                ),
                Flexible(
                  child: Container(
                    width: double.maxFinite,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("${widget.admin_by}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 5,),
          Container(
            margin: EdgeInsets.all(5),
            child: Row(
              children: <Widget>[
                Container(
                  child: Text("Approved on",
                    style: TextStyle(

                        color: Colors.white,
                        fontSize: 15
                    ),

                  ),
                ),
                Flexible(
                  child: Container(
                    width: double.maxFinite,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("${widget.date_by}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 5,),
          Container(
            margin: EdgeInsets.all(5),
            child: Row(
              children: <Widget>[
                Container(
                  child: Text("Remarks",
                    style: TextStyle(

                        color: Colors.white,
                        fontSize: 15
                    ),

                  ),
                ),
                Flexible(
                  child: Container(
                    width: double.maxFinite,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          child: widget.note_admin==null?Text("-",style: TextStyle(color: Colors.white),): Text("${widget.note_admin}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 5,),





        ],

      ),

    );

  }
  Widget _buildreject(){
    return Container(

      width: double.maxFinite,
      color: Colors.red,

      child: Column(

        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 30),
            width: double.maxFinite,
            height: 50,
            color: Colors.red[100],
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_circle,
                    color: Colors.red,



                  ),

                  SizedBox(
                    height: 20,
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        "REJECTED",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold
                        ),

                      ),

                    ),
                  ),

                ],
              ),
            ),
          ),
          ///Approve By

          //Container bugget usage
          Container(
            margin: EdgeInsets.all(5),
            child: Row(
              children: <Widget>[
                SizedBox(height: 20,),
                Container(

                  child: Text("Rejected by",
                    style: TextStyle(

                        color: Colors.white,
                        fontSize: 15
                    ),

                  ),
                ),
                Flexible(
                  child: Container(
                    width: double.maxFinite,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("${widget.admin_by}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 5,),
          Container(
            margin: EdgeInsets.all(5),
            child: Row(
              children: <Widget>[
                Container(
                  child: Text("Rejected on",
                    style: TextStyle(

                        color: Colors.white,
                        fontSize: 15
                    ),

                  ),
                ),
                Flexible(
                  child: Container(
                    width: double.maxFinite,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("${widget.date_by}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 5,),
          Container(
            margin: EdgeInsets.all(5),
            child: Row(
              children: <Widget>[
                Container(
                  child: Text("Remarks",
                    style: TextStyle(

                        color: Colors.white,
                        fontSize: 15
                    ),

                  ),
                ),
                Flexible(
                  child: Container(
                    width: double.maxFinite,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          child: widget.note_admin==null?Text("-",style: TextStyle(color: Colors.white),): Text("${widget.note_admin}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 5,),




        ],

      ),

    );

  }
  Widget _buildpending(){
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      width: double.maxFinite,
      height: 200,





    );

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    requested_date = DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.requested_on));
    requested_time = DateFormat('hh:mm:ss').format(DateTime.parse(widget.requested_on));

  }


}
