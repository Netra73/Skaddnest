
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_local/models/VideoLinks.dart';

import '../config.dart';


/*Future<List<VideoLinks>> getVideoList(token) async {
  HttpClient httpClient = new HttpClient();

  HttpClientRequest request = await httpClient.getUrl(Uri.parse( API_URL + 'video'));
  request.headers.set('Content-type', 'application/json');
  request.headers.set('Authorization',token);
  HttpClientResponse response = await request.close();
  httpClient.close();
  List<VideoLinks> vList = [];
  if(response.statusCode == 200){
    String reply = await response.transform(utf8.decoder).join();
    print(reply);
    var jdata = jsonDecode(reply);
    var data = jdata['data'];
    for(var details in data){
      String id = details['id'];
      String title = details['title'];
      String path = details['path'];
      String expiryDate = details['expiryDate'];
      String minDuration= details['minDuration'];
      String rewards= details['rewards'];
      String clientName= details['clientName'];
      String date= details['date'];
      int viewStatus= details['viewStatus'];
      vList.add(VideoLinks(id,title,path,expiryDate,minDuration,rewards,clientName,date,viewStatus));
      print(vList);
    }
  }
  return vList;
}*/
Future<String> getVideoList(token) async {
  HttpClient httpClient = new HttpClient();

  HttpClientRequest request = await httpClient.getUrl(Uri.parse( API_URL + 'video'));
  request.headers.set('Content-type', 'application/json');
  request.headers.set('Authorization',token);
  HttpClientResponse response = await request.close();
  httpClient.close();
  List<VideoLinks> vList = [];
  if(response.statusCode == 200){
    String reply = await response.transform(utf8.decoder).join();
    print(reply);
    return reply;
  }

}