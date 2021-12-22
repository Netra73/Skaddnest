import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_local/config.dart';
import 'package:flutter_local/main.dart';
import 'package:flutter_local/models/LoginForm.dart';
import 'package:flutter_local/models/SignUpForm.dart';
import 'package:flutter_local/models/UserForm.dart';


Future<String> PostSignUp(UserForm userForm) async {
  var body = {
    'name' : userForm.name,
    'mobile':userForm.mobile,
    'email':userForm.email,
    'password':userForm.password,
    'upi':'',
    'bankName': '',
    'bankAccName':'',
    'bankAccNumber': '',
    'bankBranch':'',
    'bankIfsc': '',

  };
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(API_URL+'user'));
  request.headers.set('Content-type', 'application/json');
  request.headers.set('Authorization','e10adc3949ba59abbe56e057f20f883e');
  request.add(utf8.encode(json.encode(body)));
  HttpClientResponse response = await request.close();
  httpClient.close();
  if(response.statusCode==200) {
    String reply = await response.transform(utf8.decoder).join();
    print(reply);
    return reply;
  }

}