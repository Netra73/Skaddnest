import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local/api/PostLogin.dart';
import 'package:flutter_local/api/getUser.dart';
import 'package:flutter_local/functions/UserData.dart';
import 'package:flutter_local/layouts/ForgotPassword.dart';
import 'package:flutter_local/layouts/Payment.dart';
import 'package:flutter_local/layouts/Profile.dart';
import 'package:flutter_local/layouts/SignUp.dart';
import 'package:flutter_local/layouts/YoutubeVideoPlayer.dart';
import 'package:flutter_local/models/LoginForm.dart';

class Login extends StatefulWidget {

  @override
  _Login createState() => _Login();

}
class _Login extends State<Login> {
  final _loginForm  = GlobalKey<FormState>();
  bool isError = false;
  String username="";
  String password="";
  bool wrngnumbError = false;
  bool wrngpaswdError = false;
  String errorMsg ="";
  bool autovalidate = false;
  bool isValid = false;
  LoginForm loginForm = LoginForm();
  String token ="";
  bool login = false;
  bool paid = false;
  bool unpaid = false;
  String paymentStatus="";

  _checkValidate() {
    isValid = _loginForm.currentState.validate();
    if (isValid) {
      _loginForm.currentState.save();
      _login();
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
  Widget build(BuildContext context) {
    return Scaffold(
      body:
    SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 80.0),
              child: Container(
                height: 240,
                width: 250,
                child: Image(
                  image: AssetImage("assets/image/logo.jpg") ,
                ),
              ),
            ),
            Form(
              autovalidate: autovalidate,
              key: _loginForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 2.0,left: 20.0,right: 20.0),
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
                        loginForm.username = value;
                      },
                      onChanged:(val){
                        setState(() {
                          wrngnumbError=false;
                        });
                      },
                      decoration: InputDecoration(
                          fillColor: Colors.red,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
                          hintText: "Email id / Mobile number",
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Color(0xff198d97)))
                      ),

                    ),
                  ),
                  if(wrngnumbError)
                    Padding(
                      padding: EdgeInsets.only(left:20.0),
                      child: Text(errorMsg,style: TextStyle(fontSize: 16,color: Colors.red),),
                    ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0,left: 20.0,right: 20.0),
                    child: TextFormField(
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter Password';
                        }
                        else{
                          return null;
                        }
                      },
                      onSaved: (value){
                        loginForm.password=value;
                      },

                      decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
                          hintText: 'Password',
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Color(0xff198d97)))
                      ),
                      onChanged:(val){
                        setState(() {
                          wrngpaswdError=false;
                        });
                      },
                    ),
                  ),
                  if(wrngpaswdError)
                    Padding(
                      padding: EdgeInsets.only(left:20.0),
                      child:Text(errorMsg,style: TextStyle(fontSize:16,color: Colors.red),),
                    ),
                  Container(
                      width: 180.0,
                      height: 50.0,
                      margin: EdgeInsets.only(left:100.0,top:30.0),
                      child: ElevatedButton(
                        child: Text('Login',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white),),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff198d97),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          /*  if(_loginForm.currentState.validate()){
                         _loginForm.currentState.save();
                         _login();
                         setState(() {
                           wrngpaswdError =false;
                           wrngnumbError=false;
                         });
                          }*/
                          _checkValidate();
                        },
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:50.0,left: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left:40.0),
                          child: Text("Not a member yet ? ",style: TextStyle(fontSize: 18),),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>  SignUp(),
                            ));
                          },
                          child: Text("Signup",style: TextStyle(fontSize: 18,color: Color(0xff198d97)),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),




  /* SingleChildScrollView(
        child: Container(
          color:Color(0xff198d97),
          width: 400,
          height: 900,
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 60.0,top: 150.0),
                  child: Row(
                    children: [
                      Icon(Icons.person, size: 30.0,color: Colors.white,),
                     Text(" Login to your account",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
                    ],
                  )
              ),
            Padding(
              padding: EdgeInsets.only(left: 10.0,top: 50.0),
              child: Card(
               shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(16.0),
               ),
                  color: Colors.white,
                  elevation: 10,
                   child: SizedBox(
                    width: 350,
                    height: 400,
                    child: Padding(
                     padding: EdgeInsets.only(top: 40.0),
                    child: Form(
                    autovalidate: autovalidate,
                    key: _loginForm,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 10.0,left: 20.0,right: 20.0),
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
                              loginForm.username = value;
                            },
                            onChanged:(val){
                              setState(() {
                                wrngnumbError=false;
                              });
                            },
                           decoration: InputDecoration(
                                fillColor: Colors.red,
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
                              hintText: "Email id / Mobile number",
                               focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Color(0xff198d97)))
                           ),
                            /*decoration: InputDecoration(
                                contentPadding:EdgeInsets.all(12),
                                border: OutlineInputBorder(borderRadius: const BorderRadius.all(
                                  const Radius.circular(0.0),),
                                  borderSide: new BorderSide(
                                    color: Colors.red,
                                    width: 5.0,
                                  ),),
                                //labelText: 'Mobile Number',labelStyle: (TextStyle(color: Colors.grey)),
                                hintText: 'Email id / Mobile number',
                                prefixIcon:Icon(Icons.email,size: 20,color: Colors.grey,),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Color(0xff198d97)))),*/

                          ),
                        ),
                        if(wrngnumbError)
                          Padding(
                            padding: EdgeInsets.only(left:20.0),
                            child: Text(errorMsg,style: TextStyle(fontSize: 16,color: Colors.red),),
                          ),
                        Padding(
                          padding: EdgeInsets.only(top: 15.0,left: 20.0,right: 20.0),
                          child: TextFormField(
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter Password';
                              }
                              else{
                                return null;
                              }
                            },
                            onSaved: (value){
                              loginForm.password=value;
                            },

                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
                              hintText: 'Password',
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Color(0xff198d97)))
                            ),
                           /* decoration: InputDecoration(
                                contentPadding:EdgeInsets.all(14),
                                border: OutlineInputBorder(borderRadius: const BorderRadius.all(
                                  const Radius.circular(0.0),),
                                  borderSide: new BorderSide(
                                    color: Colors.red,
                                    width: 5.0,
                                  ),),
                                //labelText: 'Mobile Number',labelStyle: (TextStyle(color: Colors.grey)),
                                hintText: 'Password',
                                prefixIcon:Icon(Icons.lock,size: 20,color: Colors.grey,),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Color(0xff198d97)))),*/

                            onChanged:(val){
                              setState(() {
                                wrngpaswdError=false;
                              });
                            },
                          ),
                        ),
                        if(wrngpaswdError)
                          Padding(
                            padding: EdgeInsets.only(left:20.0),
                            child:Text(errorMsg,style: TextStyle(fontSize:16,color: Colors.red),),
                          ),
                        Container(
                            width: 180.0,
                            height: 50.0,
                            margin: EdgeInsets.only(left:80.0,top:30.0),
                            child: ElevatedButton(
                              child: Text('Login',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white),),
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xff198d97),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {
                                /*  if(_loginForm.currentState.validate()){
                                 _loginForm.currentState.save();
                                 _login();
                                 setState(() {
                                   wrngpaswdError =false;
                                   wrngnumbError=false;
                                 });
                                  }*/
                                _checkValidate();
                                },
                            )
                        ),
                       /* Padding(
                          padding: EdgeInsets.only(top:30.0,left:100.0),
                          child: GestureDetector(
                              onTap: (){
                                Navigator.push(context,MaterialPageRoute(builder: (context)=>ForgotPassword()),
                                );
                              },
                              child: Text("Forgot Password ?",style: TextStyle(fontSize: 18,color: Colors.lightBlue),)
                          ),
                        ),*/
                        Padding(
                          padding: EdgeInsets.only(top:50.0,left: 30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left:40.0),
                                child: Text("Not a member yet ? ",style: TextStyle(fontSize: 18),),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>  SignUp(),
                                  ));
                                },
                                child: Text("Signup",style: TextStyle(fontSize: 18,color: Color(0xff198d97)),),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ),
            ),
            ],
          ),
        ),
      ),*/
    );
  }
  _login() {
    _showLoading();
    PostLogin(loginForm).then((value){
      Navigator.pop(context);
      var response = jsonDecode(value);
      if(response['status'] == 409){
        setState(() {
          errorMsg = response['message'];
          print(errorMsg);
          if(errorMsg== 'Wrong Mobile'){
            wrngnumbError= true;
          }else{
            wrngpaswdError =true;
          }
        });
      }
      if(response['status']==200){
        var data = response['data'];
        print(data);
        token = data['token'];
        String code = data['code'];
        setData("code", code).then((value){
          setData("token", jsonEncode(data)).then((value){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                YoutubeVideoPlayer(token)), (Route<dynamic> route) => false);
          });
        });
      }
    });

  }

}