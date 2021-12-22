import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local/Validations.dart';
import 'package:flutter_local/api/UserUpdate.dart';
import 'package:flutter_local/api/getUser.dart';
import 'package:flutter_local/layouts/Profile.dart';
import 'package:flutter_local/layouts/YoutubeVideoPlayer.dart';
import 'package:flutter_local/models/User.dart';
import 'package:flutter_local/models/UserForm.dart';


class EditProfile extends StatefulWidget {
  String token;
  EditProfile(this.token);
  @override
  _EditProfileState createState() => _EditProfileState(token);

}

class _EditProfileState extends State<EditProfile> {
  _EditProfileState(this.token);
  String token ;
  User user = User();
  UserForm userForm= UserForm();
  final _signupForm  = GlobalKey<FormState>();

  final controller = TextEditingController();

  final _editprofileform  = GlobalKey<FormState>();
  bool autovalidate = false;

  String errorMsg ="";
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
  String paymentStatus ="";
  String paymentAmount ="";
  String paymentMethod ="";
  String paymentId ="";
  String paymentDate ="";
  bool mblError= false;
  bool emailError=false;

  _checkValidate() {
   final isValid = _editprofileform.currentState.validate();
    if (isValid) {
      _editprofileform.currentState.save();
      _EditProfile();

    } else {
      setState(() {
        autovalidate = true;
      });
    }

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
    _getUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
         title: Text('Edit Profile'),
    backgroundColor:Color(0xff198d97),
    ),
      body:  SingleChildScrollView(
        child: FutureBuilder(
          builder: (context,snapshot) {
          return Container(
           padding: EdgeInsets.all(20.0),
            child: Form(
              autovalidate: autovalidate,
              key: _editprofileform,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 2.0,left: 25.0,right: 20.0),
                    child: Text("Name :",style: TextStyle(color:Color(0xff198d97)),),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0,left: 20.0,right: 20.0),
                    child: TextFormField(
                      controller: TextEditingController(text: user.name),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        else{
                          return null;
                        }
                      },
                       onSaved: (value){
                       user.name = value;
                       userForm.name = value;
                       },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
                        hintText: "Name",
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Color(0xff198d97)))
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0,left: 25.0,right: 20.0),
                    child: Text("Mobile Number :",style: TextStyle(color:Color(0xff198d97)),),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0,left: 20.0,right: 20.0),
                   child: TextFormField(
                      controller: TextEditingController(text: user.mobile),
                      validator: (value){
                        return mobileRequired(value, "Enter valid mobile number");
                      },
                      onSaved: (value){
                        user.mobile = value;
                        userForm.mobile = value;
                      },
                     decoration: InputDecoration(
                         border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
                         hintText: "Mobile Number",
                         focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Color(0xff198d97)))

                     ),
                      keyboardType: TextInputType.phone,
                    ),

                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 10.0,left: 25.0,right: 20.0),
                    child: Text("Email Id :",style: TextStyle(color:Color(0xff198d97)),),
                  ),

                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.0,left: 20.0,right: 20.0),
                      child: TextFormField(
                        controller: TextEditingController(text: user.email),
                        validator: (value){
                          return emailRequired(value, "Enter valid email id");
                        },
                        onSaved: (value){
                          user.email = value;
                          userForm.email = value;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
                            hintText: "Email Id",
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Color(0xff198d97)))

                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),


                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0,left: 25.0,right: 20.0),
                    child: Text(" UPI :",style: TextStyle(color:Color(0xff198d97)),),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 10.0,left: 20.0,right: 20.0),
                    child: TextFormField(
                      controller: TextEditingController(text: user.upi),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        else{
                          return null;
                        }
                      },

                      onSaved: (value){
                    user.upi = value;
                    userForm.upi = value;

                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
                        hintText: "UPI",
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Color(0xff198d97)))

                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0,left: 25.0,right: 20.0),
                    child: Text("Bank Name :",style: TextStyle(color:Color(0xff198d97)),),
                  ),

                  Padding(
                        padding: EdgeInsets.only(top: 10.0,left: 20.0,right: 20.0),
                         child: TextFormField(
                       controller: TextEditingController(text: user.bankName),
                           validator: (value) {
                             if (value == null || value.isEmpty) {
                               return 'Required';
                             }
                             else{
                               return null;
                             }
                           },

                           onSaved: (value){
                       user.bankName = value;
                       userForm.bankName = value;

                           },
                       decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
                        hintText: "Bank Name",
                           focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Color(0xff198d97)))

                       ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0,left: 25.0,right: 20.0),
                    child: Text("Bank Account Name :",style: TextStyle(color:Color(0xff198d97)),),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0,left: 20.0,right: 20.0),
                         child: TextFormField(
                      controller: TextEditingController(text: user.bankAccName),
                           validator: (value) {
                             if (value == null || value.isEmpty) {
                               return 'Required';
                             }
                             else{
                               return null;
                             }
                           },

                           onSaved: (value){
                        user.bankAccName = value;
                        userForm.bankAccName = value;

                           },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
                        hintText: "Bank Account Name",
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Color(0xff198d97)))

                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0,left: 25.0,right: 20.0),
                    child: Text("Bank Account Number :",style: TextStyle(color:Color(0xff198d97)),),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 10.0,left: 20.0,right: 20.0),
                         child: TextFormField(
                      controller: TextEditingController(text: user.bankAccNumber),
                           validator: (value) {
                             if (value == null || value.isEmpty) {
                               return 'Required';
                             }
                             else{
                               return null;
                             }
                           },

                           onSaved: (value){
                        user.bankAccNumber = value;
                        userForm.bankAccNumber = value;

                           },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
                        hintText: "Bank Account Number",
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Color(0xff198d97)))

                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0,left: 25.0,right: 20.0),
                    child: Text("Bank Branch :",style: TextStyle(color:Color(0xff198d97)),),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 10.0,left: 20.0,right: 20.0),
                         child: TextFormField(
                      controller: TextEditingController(text: user.bankBranch),
                           validator: (value) {
                             if (value == null || value.isEmpty) {
                               return 'Required';
                             }
                             else{
                               return null;
                             }
                           },

                           onSaved: (value){
                       user.bankBranch = value;
                       userForm.bankBranch = value;

                           },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
                        hintText: "Bank Branch",
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Color(0xff198d97)))

                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0,left: 25.0,right: 20.0),
                    child: Text("Bank IFSC Code :",style: TextStyle(color:Color(0xff198d97)),),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 10.0,left: 20.0,right: 20.0),
                         child: TextFormField(
                      controller: TextEditingController(text: user.bankIfsc),
                           validator: (value) {
                             if (value == null || value.isEmpty) {
                               return 'Required';
                             }
                             else{
                               return null;
                             }
                           },

                           onSaved: (value){
                           user.bankIfsc = value;
                           userForm.bankIfsc = value;

                           },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
                        hintText: "Bank IFSC",
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Color(0xff198d97)))

                      ),
                    ),
                  ),
                  Container(
                      width: 180.0,
                      height: 50.0,
                      margin: EdgeInsets.only(left:100.0,top:30.0),
                      child: ElevatedButton(
                        child: Text('Update',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18),),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff198d97),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                       /* onPressed: () {
                          _checkValidate();
                        },*/
                        onPressed: (){
                          if(_editprofileform.currentState.validate()){
                            _editprofileform.currentState.save();
                               _checkValidate();

                          }

                        },
                      ),
                  ),
                ],
              ),
            ),
          );
       },
        ),
      ),
    );
  }
  _getUser() {
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
          //user.id = data['id'];
         user.name = data['name'];
         // user.code = data['code'];
          user.mobile = data['mobile'];
          user.email = data['email'];
          user.upi = data['upi'];
         user. bankName = data['bankName'];
          user.bankAccName = data['bankAccName'];
         user. bankAccNumber = data['bankAccNumber'];
         user. bankBranch = data['bankBranch'];
          user.bankIfsc = data['bankIfsc'];
        });

      }
    });

  }
  _EditProfile() {
    _showLoading();
    UserUpdate(userForm,token).then((value){
      Navigator.pop(context);
      var response = jsonDecode(value);
      print (response);
      if(response['status'] == 409){
        setState(() {

        });
      }
      if(response['status']==200){
        var data = response['data'];
      Navigator.pop(context);
      }
    });

  }

}
