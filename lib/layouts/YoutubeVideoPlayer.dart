/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local/layouts/Login.dart';
import 'package:flutter_local/layouts/Profile.dart';
import 'package:flutter_local/layouts/SingleVideo.dart';

class YoutubeVideoPlayer extends StatefulWidget {
  String token;
  YoutubeVideoPlayer(this.token);
  @override
  _YoutubeVideoPlayerState createState() => _YoutubeVideoPlayerState(token);
}

class _YoutubeVideoPlayerState extends State<YoutubeVideoPlayer> {
  _YoutubeVideoPlayerState(this.token);
  String token ;
  List<String> _ids = [
    'aqz-KE-bpKQ',
    'eRsGyueVLvQ',
    'nsd7Mg-Hkhw',
    'EIIJpCJHccg',
    '2ZNi1GJgOh0',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            //header
            InkWell(
              child: new UserAccountsDrawerHeader(
                currentAccountPicture: GestureDetector(
                  child: new CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: Colors.black,),
                  ),
                ),
                decoration: new BoxDecoration(
                    color: Colors.black54
                ),
              ),
            ),

            //body

          /*  InkWell(
              onTap: (){
                setState(() {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => YoutubeVideoPlayer(token)
                  ));
                });
                Navigator.pop(context);
              },
              child: ListTile(
                title: Text('Home'),
                leading: Icon(Icons.home,color: Colors.amber,),
              ),
            ),*/


            InkWell(
              onTap: (){

                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Profile(token)
                ));
              },
              child: ListTile(
                title: Text('My account'),
                leading: Icon(Icons.person,color: Colors.purple,),
              ),
            ),

            InkWell(
              onTap: (){

              },
              child: ListTile(
                title: Text('Settings'),
                leading: Icon(Icons.settings, color: Colors.blue,),
              ),
            ),

            InkWell(
              onTap: (){

              },
              child: ListTile(
                title: Text('About'),
                leading: Icon(Icons.help, color: Colors.green),
              ),
            ),
            Divider(),

            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>Login(),
                ));
              },
              child: ListTile(
                title: Text('Logout'),
                leading: Icon(Icons.exit_to_app, color: Colors.redAccent),
              ),
            )
          ],
        ),
      ),




        appBar: AppBar(
         title: Text('Youtube Player'),
         backgroundColor: Colors.black54,
      ),
     body: Container(
      color: Colors.white,
      child: ListView.builder(
          itemCount:_ids.length,
          itemBuilder: (context,i) {
            return Column(
              children: [
                Container(
                  height: 35,
                  width: 400,
                  //color: Colors.red,
                  child: Padding(
                      padding: EdgeInsets.only(left:15.0,top: 5.0),
                      child: Text("NEPAL : Shrinkhala Khatiwada", style: TextStyle(fontSize: 20),)
                  ),
                ),
                Card(
                  margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10.0,top:10.0,bottom: 10.0),
                    child: SingleVideo(_ids[i]),
                  ),
                ),
              ],
            );
          }
      ),
    ),
    );
  }
}*/
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local/api/getUser.dart';
import 'package:flutter_local/api/getVideoList.dart';
import 'package:flutter_local/functions/UserData.dart';
import 'package:flutter_local/layouts/About.dart';
import 'package:flutter_local/layouts/GetStarted.dart';
import 'package:flutter_local/layouts/Profile.dart';
import 'package:flutter_local/layouts/Rewards.dart';
import 'package:flutter_local/layouts/SingleVideo.dart';
import 'package:flutter_local/models/VideoLinks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';


class YoutubeVideoPlayer extends StatefulWidget {
  String token;
  YoutubeVideoPlayer(this.token);
  @override
  _YoutubeVideoPlayerState createState() => _YoutubeVideoPlayerState(token);
}

class _YoutubeVideoPlayerState extends State<YoutubeVideoPlayer> {
List<VideoLinks>vList = [];
  _YoutubeVideoPlayerState(this.token);
  String token ;
  bool login = false;
  int pos = 0;
  String paymentStatus = "";
  bool paid = false;
  bool pending = false;
  bool containsData = false;
  bool noData = false;
  var formatted;
String name ="";
String email ="";
String mobile ="";
  _logout(){
    removeData("token").then((value){
      setState(() {
            login = false;
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            GetStarted()), (Route<dynamic> route) => false);
      });
    });
  }

  @override
  void initState() {
         _getPaymentStatus();
          /*   getVideoList(token).then((value) {
               Map response = jsonDecode(value);
               if (response["status"] == 200) {

                 setState(() {
                   vList = value;
                 });
               }
    });*/

         getVideoList(token).then((value) {
           Map response = jsonDecode(value);
           if (response["status"] == 200) {
             setState(() {
               containsData = true;
               var data = response['data'];
               for (var details in data) {
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
             });
           }
             else{
               setState(() {
                 noData= true; ;
               });

             }
         });
         super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            InkWell(
              child: new UserAccountsDrawerHeader(
               accountName:  Text(name,style: TextStyle(color: Colors.white),) ,
               accountEmail: Text(email,style: TextStyle(color: Colors.white),),
               currentAccountPicture: GestureDetector(
                  child: new CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color:Color(0xff198d97),),
                  ),
                ),
                decoration: new BoxDecoration(
                    color:Color(0xff198d97)
                ),
              ),
            ),

            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Profile(token),
                ));
              },
              child: ListTile(
                title: Text('My account',style: TextStyle(fontWeight: FontWeight.bold),),
                leading: Icon(Icons.person,color:Color(0xff198d97),),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Reward(token)
                ));
              },
              child: ListTile(
                title: Text('Rewards',style: TextStyle(fontWeight: FontWeight.bold),),
                leading: Icon(Icons.local_offer_rounded,color: Color(0xff198d97),),
              ),
            ),

            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>About()
                ));
              },
              child: ListTile(
                title: Text('About Us',style: TextStyle(fontWeight: FontWeight.bold),),
                leading: Icon(Icons.help, color: Color(0xff198d97)),
              ),
            ),
            Divider(),

            InkWell(
              onTap: () {
               _logout();
              },
              child: ListTile(
                title: Text('Logout',style: TextStyle(fontWeight: FontWeight.bold),),
                leading: Icon(Icons.exit_to_app, color: Color(0xff198d97)),
              ),
            )
          ],
        ),
      ),


      appBar: AppBar(
        title: Text('SK AD Nest',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
        backgroundColor: Color(0xff198d97),
      ),
           body: SingleChildScrollView(

            child:Column(
              children: [
              if(paid) if(containsData)Container(
                 height: 730,
                 width: 400,
                 child:  vList.length > 0 ? ListView.builder(
                 shrinkWrap: true,
                 itemCount: vList.length,
                 itemBuilder: (cc, i) {
                   vList.sort((a, b) => a.viewStatus.compareTo(b.viewStatus));
                   String  url = vList[i].path;
                   String path  = url.substring(url.length -11);
                   print(path);

                   String date = vList[i].date;
                   var dateTime = DateTime.parse(date);
                   formatted = DateFormat('yyyy/MM/dd  hh:mm a').format(dateTime);

                   //formatted = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
                   /*var dateFormat = new DateFormat('yyyy-MM-dd HH:mm');
                   formatted = dateFormat.format(dateTime);
                   print(formatted);*/
                   return Card(
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(15.0),
                     ),
                     elevation: 15,
                     margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: GestureDetector(
                         onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                               builder: (context) => SingleVideo(mediaUrl:path,id:vList[i].id,title:vList[i].title,date: formatted,
                                   minDuration:vList[i].minDuration,viewStatus:vList[i].viewStatus,token:token,
                                   clientName:vList[i].clientName,onCallBack: (){setState(() {
                                     vList[i].viewStatus=1;
                                   });
                                   },)
                           ));

                          /*  Navigator.push(context, MaterialPageRoute(
                               builder: (context) =>
                                   SingleVideo(mediaUrl:path,id:vList[i].id,title:vList[i].title,date: formatted,
                                       minDuration:vList[i].minDuration,viewStatus:vList[i].viewStatus,token:token,
                                       clientName:vList[i].clientName))).then((value){
                             setState(() {

                             });
                           });*/

                         },
                         child: Container(
                           child: Row(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Stack(
                                 children: [
                                   Container(
                                             height: 120,
                                             width: 100,
                                             child: Image.network('https://img.youtube.com/vi/'+path+'/0.jpg',
                                                 height: 150,
                                                 fit:BoxFit.fill),
                                           ),
                                   SizedBox(width: 5.0),
                                   Padding(
                                     padding: EdgeInsets.only(top: 20.0),
                                     child: Container(
                                         width: 100,
                                         height: 100,
                                         child: Center(child: Icon(Icons.play_circle_outline, size: 50.0,))),
                                   ),
                                 ],
                               ),
                               SizedBox(
                                 width: 15,
                               ),
                               Expanded(
                                 child: Container(
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       SizedBox(height: 5,),
                                       Text("Title: "+vList[i].title,style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                       SizedBox(height: 10,),
                                       Text("Posted By: "+vList[i].clientName,style:TextStyle(fontSize: 14),),
                                       SizedBox(height: 10,),
                                       Text("Posted Date: "+formatted,style:TextStyle(fontSize: 14),),
                                       SizedBox(height: 10,),
                                       if(vList[i].viewStatus == 1)Row(
                                         children: [
                                           Text("viewed",style: TextStyle(color: Color(0xff198d97)),),
                                           Icon(Icons.check_circle, size: 20.0,color: Color(0xff198d97),),
                                         ],
                                       ),
                                       SizedBox(height: 10,),
                                     ],
                                   ),
                                 ),
                               ),
                             ],
                           ),
                         ),
                       ),
                     ),
                   );
                 }) :SpinKitCircle(
                   color:Color(0xff198d97),
                   size: 50,) ,
               ),
                if(pending)Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 50.0,top: 40.0),
                        child: Text("Make a payment of Rs:1000",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 50.0,top: 50.0),
                        child: Card(
                          color: Colors.white,
                          child: SizedBox(
                            width: 300,
                            height: 400,
                            child:Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child: Container(
                                height: 300,
                                width: 300,
                                child: Image(
                                  image: AssetImage("assets/image/QRcode.jpg") ,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                     /* Padding(
                        padding: EdgeInsets.only(left: 40.0, top: 20.0),
                        child:Container(
                            width: 180.0,
                            height: 50.0,
                            margin: EdgeInsets.only(top:10.0),
                            child: ElevatedButton(
                              child: Text('Do Payment',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18,color: Colors.white),),
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xff198d97),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {
                                //  _doPayment();
                              }
                            )
                        ),
                      ),*/
                    ],
                  ),
                ),
                if(noData)Container(
                  child: Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text("No Videos to watch",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                  ),
                ),
              ],
            ),
           ),

    );
  }
   _getPaymentStatus(){
     getUser(token).then((value) {
       var response = jsonDecode(value);
       if(response['status'] == 409){
         setState(() {
         });
       }
       if(response['status']==200){
         setState(() {
           var data = response['data'];
           name =data["name"];
           email =data["email"];
           mobile =data["mobile"];
           paymentStatus = data['paymentStatus'];
           if(paymentStatus== '1'){
             setState(() {
               paid = true;
             });
           }else{
             setState(() {
               pending = true;

             });
           }
         });
       }
     });
   }
 /*  _doPayment(){

     PostSignUp(userForm).then((value){
       Navigator.pop(context);
       var response = jsonDecode(value);
       if(response['status'] == 409){
       }
       if(response['status']==200){
         var data = response['data'];
         String paid = data['code'];
         print(paid);


       }
     });

   }*/
}