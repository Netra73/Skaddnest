import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_local/config.dart';
import 'package:flutter_local/main.dart';
import 'package:flutter_local/models/LoginForm.dart';
import 'package:flutter_local/models/Rewards.dart';


Future<String> AddReward(String id,String token) async {
  print(token);
  var body =
  {
    'videoId': id,
  };
  print(body);
  print(API_URL);
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(API_URL+'reward'));
  request.headers.set('Content-type', 'application/json');
  request.headers.set('Authorization',token);
  request.add(utf8.encode(json.encode(body)));
  HttpClientResponse response = await request.close();

  httpClient.close();
  print(response.statusCode);
  if(response.statusCode==200) {
    String reply = await response.transform(utf8.decoder).join();
    print(reply);
    return reply;

  }

}