import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local/models/LoginForm.dart';

class ForgotOtpVerification extends StatefulWidget {
  //String mobile,otp,userid;

 // ForgotOtpVerification(this.mobile, this.otp,this.userid);

  @override
  _ForgotOtpVerification createState() => _ForgotOtpVerification();
}

class _ForgotOtpVerification extends State<ForgotOtpVerification> {
  //String mobile,otp,userid;

  //_ForgotOtpVerification(this.mobile, this.otp,this.userid);

  final _otpForm  = GlobalKey<FormState>();
  String otpValue = "";
  bool invalid = false;
  LoginForm loginForm = LoginForm();
  bool inValid = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Container(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios,size: 25,color: Colors.black87,),
                  ),
                ),
              )
            ],
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 0.0,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30.0,),
              Center(
                child: Text("OTP Verification",style: TextStyle(fontSize: 25.0),),
              ),
              SizedBox(height: 50.0,),
              Center(
                child: Container(
                    child: Text("Enter One Time Password sent \n to +91 ",textAlign: TextAlign.center,)
                ),
              ),
              SizedBox(height: 50.0,),
              if(invalid)  Center(child: Text("Invalid OTP",style: TextStyle(fontSize: 14,color: Colors.red),),),
              if(invalid) SizedBox(height: 10.0,),
              Center(
                child: Container(
                  width: 200.0,
                  child: Form(
                    key: _otpForm,
                    child: Column(
                      children: [
                        TextFormField(
                          autofocus: true,
                          textAlign: TextAlign.center,
                          validator: (value){
                            //return validateName(value, "Enter OTP");
                          },
                          onSaved: (value){
                            otpValue = value;
                          },
                          style: TextStyle(
                              fontSize: 30.0,
                          ),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  borderSide: BorderSide(color: Colors.grey)
                              )
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Center(
                child:
                RaisedButton(
                  onPressed: (){
                    if(_otpForm.currentState.validate()){
                      _otpForm.currentState.save();
                    }
                  },
                  padding: EdgeInsets.fromLTRB(25, 12, 25, 12),
                  child: (Text('Submit',style: TextStyle(color: Colors.white,fontSize: 18),)),
                ),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                child: Text("Resend OTP"),
              )
            ],
          ),
        ),
      ),
    );
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
}
