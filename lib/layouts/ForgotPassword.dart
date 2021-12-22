import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local/api/UserForgotPassword.dart';
import 'package:flutter_local/layouts/ForgotOtpVerification.dart';
import 'package:flutter_local/models/LoginForm.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _forgotpassform  = GlobalKey<FormState>();
  LoginForm loginForm = LoginForm();
  bool autovalidate = false;

  _checkValidate() {
  final  isValid = _forgotpassform.currentState.validate();
    if (isValid) {
      _forgotpassform.currentState.save();
      _login();

    } else {
      setState(() {
        autovalidate = true;
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password?'),
        backgroundColor: Colors.black54,
      ),
      body:  Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          autovalidate: autovalidate,
          key: _forgotpassform,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30.0,left: 10.0,right: 10.0),
              child: TextFormField(
                validator: (value){
                  if (value==null||value.isEmpty) {
                    return 'Enter Email id / Mobile number';
                  }
                  else{
                    return null;
                  }
                },
                onSaved: (value){
                  },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Email id / Mobile number",
                ),
              ),
            ),
            Container(
                width: 180.0,
                height: 50.0,
                margin: EdgeInsets.only(left:2.0,top:30.0),
                child: ElevatedButton(
                  child: Text('Submit',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18),),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black54,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    _checkValidate();
                    },
                )
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotOtpVerification()));
              },
              child: Padding(
                padding: EdgeInsets.only(top: 20.0),
                  child: Text("otp Page",style: TextStyle(fontSize: 18),),
              ),
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
  _login() {
    _showLoading();
    UserForgotPassword(loginForm).then((value) {
      Navigator.pop(context);
      var response = jsonDecode(value);
      print("response check");
      print(response);
      if (response['status'] == 422) {
        setState(() {

        });
      }
      if (response['status'] == 200) {
        var data = response['data'];
        String id = data['id'];
        int otp = data['otp'];
        print(otp);
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=>ForgotOtpVerification()
        ));
      }
    });
  }
}