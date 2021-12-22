/*import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:estore/model/Product.dart';
import 'package:estore/model/SliderImage.dart';
import 'package:http/http.dart' as http;
import '../config.dart';

Future<List<SliderImage>> getSliderImage() async {
  HttpClient httpClient = new HttpClient();

  HttpClientRequest request = await httpClient.getUrl(Uri.parse( API_URL + 'slider'));
  request.headers.set('Content-type', 'application/json');
  request.headers.set('Authorization','e10adc3949ba59abbe56e057f20f883e');

  // request.add(utf8.encode(json.encode(body)));
  HttpClientResponse response = await request.close();
  httpClient.close();
  var url = Uri.parse("http://ecom.digitalmarketinghubli.com/TEST_API/slider");
 // final responses = await http.get('http://ecom.digitalmarketinghubli.com/TEST_API/slider');
  final responses = await http.get(url);

  List<SliderImage> cList = [];
  if(response.statusCode == 200){
    String reply = await response.transform(utf8.decoder).join();
   // print("see reply for slider");
    print(reply);
    var jdata = jsonDecode(reply);
    var data = jdata['data'];
    for(var details in data){
      String id = details['id'];
      String title = details['title'];
      String icon = details['image'];
      cList.add(SliderImage(id,title,icon));
    }
  }
  return cList;
}*/

import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';

import '../config.dart';


Future<String> getUser(String token) async {
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.getUrl(Uri.parse(API_URL +'user'));
  request.headers.set('Content-type', 'application/json');
  request.headers.set('Authorization',token);
  HttpClientResponse response = await request.close();
  print(response);
  httpClient.close();
  if(response.statusCode==200) {
    String reply = await response.transform(utf8.decoder).join();
    print(reply);
    return reply;

  }
}



