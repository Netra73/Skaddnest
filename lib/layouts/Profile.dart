import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local/api/getUser.dart';
import 'package:flutter_local/functions/UserData.dart';
import 'package:flutter_local/layouts/EditProfile.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class Profile extends StatefulWidget {
  String token;

  Profile(this.token);
   @override
  _Profile createState() => _Profile(token);

}
class _Profile extends State<Profile> {
  _Profile(this.token);
  String token ;
  String name="";
  String mobile="";
  String email="";
  String code="";
  String  id="";
  String  upi="";
  String  bankName="";
  String  bankAccName="";
  String  bankAccNumber="";
  String  bankBranch="";
  String  bankIfsc="";
  String  paymentAmount="";
  String  paymentMethod="";
  String  paymentDate="";
  String  paidDate="";
  bool menuExpanded = false;
  bool login = false;
  bool loading = false;
  bool paymentnull = false;
  bool paid = false;
  bool response = false;
  bool noresponse = false;
bool bankdetails= false;
bool nodetails = false;

  _logout(){
    removeData("token").then((value){
      setState(() {
            menuExpanded = false;
            login = false;
          });
        });

  }
  _showLoading() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  child: CircularProgressIndicator(),
                  height: 40.0,
                  width: 40.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
// _getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  return  Scaffold(
    appBar: AppBar(
      title: Text('My Account',style: TextStyle(fontWeight: FontWeight.bold),),
      backgroundColor: Color(0xff198d97),
    ),
      body: SingleChildScrollView(
        child: Container(
          child: FutureBuilder(
                   future:getUser(token),
                  builder: (context,snapshot) {
                     if (snapshot.hasData) {
                      var data = jsonDecode(snapshot.data);
                        if(data["status"]==200){
                          response=true;
                          var udata = data["data"];
                          id = udata['id'];
                          name = udata['name'];
                          code = udata['code'];
                          mobile = udata['mobile'];
                          email = udata['email'];


                         /* upi = udata['upi'];
                          bankName = udata['bankName'];
                          bankAccName = udata['bankAccName'];
                          bankAccNumber = udata['bankAccNumber'];
                          bankBranch = udata['bankBranch'];
                          bankIfsc = udata['bankIfsc'];*/

                          if(udata['upi']=='' && udata['bankName']==''&& udata['bankAccName']==''&&
                              udata['bankAccNumber']==''&& udata['bankBranch']==''&& udata['bankIfsc']==''){
                            nodetails= true;
                          }else{
                            bankdetails= true;
                            upi = udata['upi'];
                            bankName = udata['bankName'];
                            bankAccName = udata['bankAccName'];
                            bankAccNumber = udata['bankAccNumber'];
                            bankBranch = udata['bankBranch'];
                            bankIfsc = udata['bankIfsc'];
                          }



                         // paymentAmount = udata['paymentAmount'];
                          //paymentMethod = udata['paymentMethod'];
                          //paymentDate = udata['paymentDate'];

                          if(udata['paymentAmount']==''&& udata['paymentMethod']==''&&udata['paymentDate']== ''){
                            paymentnull = true;
                          }else{
                            paymentAmount = udata['paymentAmount'];
                            paymentMethod = udata['paymentMethod'];
                            paid = true;
                            paymentDate = udata['paymentDate'];
                            var dateTime = DateTime.parse(paymentDate);
                            //paidDate = DateFormat('yyyy/MM/dd  hh:mm a').format(dateTime);
                            paidDate = "${dateTime.day}/${dateTime.month}/${dateTime.year}";

                          }



                         /* if(udata['paymentDate']== ''){
                            paymentnull = true;
                            print(paymentnull);
                          }else{
                            paid = true;
                           paymentDate = udata['paymentDate'];
                          var dateTime = DateTime.parse(paymentDate);
                            //paidDate = DateFormat('yyyy/MM/dd  hh:mm a').format(dateTime);
                            paidDate = "${dateTime.day}/${dateTime.month}/${dateTime.year}";
                          }*/

                          //var dateTime = DateTime.parse(paymentDate);
                         //paidDate = "${dateTime.day}-${dateTime.month}-${dateTime.year}";

                        }else{
                          noresponse= true;
                        }
                      return Column(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            color: Colors.white,
                            elevation: 10,
                              margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom:30.0, top: 20.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 20.0, left: 20.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.person, size: 20.0,),
                                        Container(
                                            margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                            child: Text(name, style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 20.0, left: 20.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.phone_android, size: 20.0),
                                        Container(
                                            margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                            child: Text(mobile, style: TextStyle(fontSize: 18),)
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 20.0, left: 20.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.email, size: 20.0),
                                        Container(
                                            margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                            child: Text(email, style: TextStyle(fontSize: 18),)
                                        )
                                      ],
                                    ),
                                  ),
                                 if(bankdetails) Column(
                                    children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 20.0, left: 20.0),
                                    child: Row(
                                      children: [
                                        //  Icon(Icons.qr_code, size: 20.0),
                                        Container(
                                            margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
                                            child: Text("UPI : " + upi, style: TextStyle(fontSize: 18),)
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 20.0, left: 20.0),
                                    child: Row(
                                      children: [
                                        //  Icon(Icons.qr_code, size: 20.0),
                                        Container(
                                            margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
                                            child: Text("Bank Name : " + bankName,
                                              style: TextStyle(fontSize: 18),)
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 20.0, left: 20.0),
                                    child: Row(
                                      children: [
                                        //  Icon(Icons.qr_code, size: 20.0),
                                        Container(
                                            margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
                                            child: Text(
                                              "A/c Name : " + bankAccName,
                                              style: TextStyle(fontSize: 18),)
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 20.0, left: 20.0),
                                    child: Row(
                                      children: [
                                        //  Icon(Icons.qr_code, size: 20.0),
                                        Container(
                                            margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
                                            child: Text(
                                              "A/c Number : " + bankAccNumber,
                                              style: TextStyle(fontSize: 18),)
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 20.0, left: 20.0),
                                    child: Row(
                                      children: [
                                        //  Icon(Icons.qr_code, size: 20.0),
                                        Container(
                                            margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
                                            child: Text("Bank Branch : " + bankBranch,
                                              style: TextStyle(fontSize: 18),)
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 20.0, left: 20.0),
                                    child: Row(
                                      children: [
                                        //  Icon(Icons.qr_code, size: 20.0),
                                        Container(
                                            margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
                                            child: Text("IFSC : " + bankIfsc,
                                              style: TextStyle(fontSize: 18),)
                                        )
                                      ],
                                    ),
                                  ),
                                    ],
                                  ),
                                /*  Padding(
                                    padding: EdgeInsets.only(top: 20.0, left: 20.0),
                                    child: Row(
                                      children: [
                                        //  Icon(Icons.qr_code, size: 20.0),
                                        Container(
                                            margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
                                            child: Text("PaymentAmount : "+paymentAmount,
                                              style: TextStyle(fontSize: 18),)
                                        )
                                      ],
                                    ),
                                  ),
                                      Padding(
                                       padding: EdgeInsets.only(top: 20.0, left: 20.0),
                                       child: Row(
                                         children: [
                                        //  Icon(Icons.qr_code, size: 20.0),
                                        Container(
                                            margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
                                            child: Text("PaymentMethod : "+paymentMethod,
                                              style: TextStyle(fontSize: 18),)
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 20.0, left: 20.0),
                                       child: Row(
                                      children: [
                                        //  Icon(Icons.qr_code, size: 20.0),
                                         if(paymentnull) Container(
                                            margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
                                            child: Text("PaymentDate : ",
                                              style: TextStyle(fontSize: 18),)
                                        ),
                                        if(paid)Container(
                                            margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
                                            child: Text("PaymentDate : "+paidDate,
                                              style: TextStyle(fontSize: 18),)
                                        )
                                      ],
                                    ),
                                  ),*/

                                  Container(
                                      width: 180.0,
                                      height: 40.0,
                                      margin: EdgeInsets.only(left: 1.0, top: 20.0,bottom: 20.0),
                                      child: ElevatedButton(
                                        child: Text('Edit Profile', style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),),
                                          style: ElevatedButton.styleFrom(
                                          primary: Color(0xff198d97),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                        ),
                                        onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(
                                          builder: (context) =>
                                             EditProfile(token))).then((value){
                                                setState(() {

                                                });
                                             });

                                        },
                                      )
                                  ),

                                ],
                              ),
                            ),
                          if(paid)   Column(
                            children: [
                           Container(
                              child: Padding(
                                padding: EdgeInsets.only(top:2.0,bottom: 10.0),
                                  child: Text("Payment Details",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                              ),
                            ),

                           Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            color: Colors.white,
                            elevation: 10,
                            margin: EdgeInsets.only(
                                left: 20.0, right: 20.0, bottom: 50.0, top:2.0),
                            child: Column(
                              children: [

                                Padding(
                                    padding: EdgeInsets.only(top: 20.0, left: 20.0),
                                    child: Row(
                                      children: [
                                        //  Icon(Icons.qr_code, size: 20.0),
                                        Container(
                                            margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
                                            child: Text("Amount Paid :"+paymentAmount,
                                              style: TextStyle(fontSize: 18),)
                                        )
                                      ],
                                    ),
                                  ),
                                      Padding(
                                       padding: EdgeInsets.only(top: 20.0, left: 20.0),
                                       child: Row(
                                         children: [
                                        //  Icon(Icons.qr_code, size: 20.0),
                                        Container(
                                            margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
                                            child: Text("Method : "+paymentMethod,
                                              style: TextStyle(fontSize: 18),)
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 20.0, left: 20.0,bottom: 20.0),
                                       child: Row(
                                      children: [
                                        //  Icon(Icons.qr_code, size: 20.0),
                                        /* if(paymentnull) Container(
                                            margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
                                            child: Text("Date : ",
                                              style: TextStyle(fontSize: 18),)
                                        ),*/
                                        if(paid)Container(
                                            margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
                                            child: Text("Date : "+paidDate,
                                              style: TextStyle(fontSize: 18),)
                                        )
                                      ],
                                    ),
                                  ),


                              ],
                            ),
                          ),
                    ]
                    ),
                          if(noresponse)Container(
                            child: Text("No Response From server",style: TextStyle(fontSize: 18),),
                          ),
                        ],
                      );
                    }

                     return SpinKitCircle(
                       color: Color(0xff198d97),
                       size: 50,
                     );
                    /* Container(
                       color: Colors.white.withOpacity(0.3),
                       width: MediaQuery.of(context).size.width,//70.0,
                       height: MediaQuery.of(context).size.height, //70.0,
                       child: new Padding(
                           padding: const EdgeInsets.all(5.0),
                           child: new Center(child: new CircularProgressIndicator())),
                     );*/
                  }
        ),
        ),
      ),
    );
  }



 /*_getUserDetails() {
    getUser(token).then((value){
      var response = jsonDecode(value);

      if(response['status'] == 409){
        setState(() {
        });
      }
      if(response['status']==200){
        setState(() {
          var data = response['data'];
          print(data);
            id = data['id'];
           name = data['name'];
           code = data['code'];
           mobile = data['mobile'];
           email = data['email'];
          upi = data['upi'];
          bankName = data['bankName'];
          bankAccName = data['bankAccName'];
          bankAccNumber = data['bankAccNumber'];
          bankBranch = data['bankBranch'];
          bankIfsc = data['bankIfsc'];

          loading = true;
        });
      }
    });

  }*/

}