import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_local/config.dart';
import 'package:flutter_local/main.dart';
import 'package:flutter_local/models/LoginForm.dart';
import 'package:flutter_local/models/SignUpForm.dart';
import 'package:flutter_local/models/User.dart';
import 'package:flutter_local/models/UserForm.dart';


Future<String> UserUpdate(UserForm userForm,String token) async {
  var body =
  {
    'name': userForm.name,
    'mobile': userForm.mobile,
    'email': userForm.email,
    'upi': userForm.upi,
    'bankName': userForm.bankName,
    'bankAccName': userForm.bankAccName,
    'bankAccNumber': userForm.bankAccNumber,
    'bankBranch': userForm.bankBranch,
    'bankIfsc': userForm.bankIfsc,
  };
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.putUrl(Uri.parse(API_URL+'user'));
  request.headers.set('Content-type', 'application/json');
  request.headers.set('Authorization',token);
  request.add(utf8.encode(json.encode(body)));
  HttpClientResponse response = await request.close();

  httpClient.close();
  if(response.statusCode==200) {
    String reply = await response.transform(utf8.decoder).join();
    print(reply);
    return reply;

  }

}