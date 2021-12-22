import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local/api/getUser.dart';
import 'package:flutter_local/functions/UserData.dart';
import 'package:flutter_local/layouts/YoutubeVideoPlayer.dart';

class Payment extends StatefulWidget {
  String token;
  Payment(this.token);
  @override
  _PaymentState createState() => _PaymentState(token);
}

class _PaymentState extends State<Payment> {
  _PaymentState(this.token);
  String token ;
  String paymentStatus ="";
  bool paid = false;
  bool unpaid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
         title: Text('Payment'),
         backgroundColor:Color(0xff198d97),
    ),
     body: Container(
         child: Column(
            children: [
          Padding(
          padding: EdgeInsets.only(left: 10.0,top: 50.0),
           child: Text("Make a payment of 200",style: TextStyle(fontSize: 20),),
         ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0,top: 70.0),
                  child: Card(
                    color: Colors.white,
                     child: SizedBox(
                          width: 300,
                          height: 400,
                       child:Padding(
                         padding: EdgeInsets.only(top: 20.0),
                         child: Container(
                           height: 300,
                           width: 300,
                           child: Image(
                             image: AssetImage("assets/image/QRcode.jpg") ,
                           ),
                         ),
                       ),
             ),
              ),
                ),
           Padding(
             padding: EdgeInsets.only(right:90.0,left: 20.0),
             child: Container(
                 width: 180.0,
                 height: 50.0,
                 margin: EdgeInsets.only(left:90.0,top:30.0),
                 child: ElevatedButton(
                   child: Text('Done',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18),),
                   style: ElevatedButton.styleFrom(
                     primary: Colors.lightBlue,
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(20),
                     ),
                   ),
                   onPressed: () {
                    // _getPaymentStatus();
                 //  Navigator.push(context, MaterialPageRoute(
                   //     builder: (context) =>
                   //          YoutubeVideoPlayer(token)));
                   },
                 )
             ),
           ),
         ],
       ),
     ),
    );
  }

  _getPaymentStatus() {
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
         paymentStatus = data['paymentStatus'];
          if(paymentStatus== '1'){
            setState(() {
              paid = true;
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  YoutubeVideoPlayer(token)), (Route<dynamic> route) => false);
            });
          }else{
            setState(() {
              unpaid =true;
            });

          }
        });
      }
    });

  }
}
