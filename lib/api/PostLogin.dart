import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_local/config.dart';
import 'package:flutter_local/main.dart';
import 'package:flutter_local/models/LoginForm.dart';


Future<String> PostLogin(LoginForm loginForm) async {
  var body =
  {
    'username': loginForm.username,
    'password': loginForm.password
  };

  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(API_URL+'login'));
  request.headers.set('Content-type', 'application/json');
  request.headers.set('Authorization','e10adc3949ba59abbe56e057f20f883e');
  request.add(utf8.encode(json.encode(body)));
  HttpClientResponse response = await request.close();
  httpClient.close();
  if(response.statusCode==200) {
    String reply = await response.transform(utf8.decoder).join();
    return reply;

  }

}