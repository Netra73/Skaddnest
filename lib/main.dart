import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local/api/PostLogin.dart';
import 'package:flutter_local/api/getUser.dart';
import 'package:flutter_local/functions/UserData.dart';
import 'package:flutter_local/layouts/EditProfile.dart';
import 'package:flutter_local/layouts/ForgotPassword.dart';
import 'package:flutter_local/layouts/GetStarted.dart';
import 'package:flutter_local/layouts/Login.dart';
import 'package:flutter_local/layouts/Payment.dart';
import 'package:flutter_local/layouts/Profile.dart';
import 'package:flutter_local/layouts/SignUp.dart';
import 'package:flutter_local/layouts/YoutubeVideoPlayer.dart';
import 'package:flutter_local/models/LoginForm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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
  String _token = "";
  String paymentStatus ="";

  @override
  void initState() {
       checkData("token").then((value) {
         getData("token").then((value) {
           if (value != null) {
             var data = jsonDecode(value);
             _token = data['token'];
           }
         });

         if (value) {
           setState(() {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                YoutubeVideoPlayer(_token)), (Route<dynamic> route) => false);
          });
         }
         else {
           setState(() {
             Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                     GetStarted()), (Route<dynamic> route) => false);
           });
         }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      width: 120.0,
      color: Colors.white,

        child: Padding(
            padding: EdgeInsets.only(left:20.0,right: 20.0),
            child: Image(
              image: AssetImage("assets/image/logo.jpg") ,
            ),
          )
    );
  }
}
