import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local/api/GetRewards.dart';
import 'package:flutter_local/api/getVideoList.dart';
import 'package:flutter_local/layouts/YoutubeVideoPlayer.dart';
import 'package:flutter_local/models/Rewards.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class GetReward{
  String id;
   String date;
   String reward;
  String videoId;
 String title;
 String path;
}
class Reward extends StatefulWidget {
  String token,reward;
  Reward(this.token);
  @override
  _RewardState createState() => _RewardState(token,reward);
}

class _RewardState extends State<Reward> {
_RewardState(this.token,this.reward);
String token;
String reward;
int rewardpoints = 0;
int totalRewards =0;
List<Rewards>rList = [];
List<GetReward> getReward = [];
bool rewarded = false;
bool notRewarded = false;
var formatted;
int i = 0;
int totalReward =0;
String videoCount ="";
String rewardlist ="";
String date ="";
bool containsData = false;
bool noData = false;
@override
  void initState() {
  getRewards(token).then((value) {
    Map response = jsonDecode(value);
    if (response["status"] == 200) {

        totalRewards  = int.parse(response["todayReward"]);
       if(totalRewards>0){
         rewarded = true;
       }else{
         notRewarded = true;
       }
     //int reward = int.parse(response["todayReward"]);
     if(response.containsKey("data")){
       setState(() {
         containsData = true;
         var data = response['data'];
         for(var details in data){
           String videoCount = details['videoCount'];
           String reward = details['reward'];
           String date = details['date'];
           rList.add(Rewards(videoCount,reward,date));
           print(rList);
         }
         for (int i = 0; i < response["data"].length; i++) {
           String reward =(response["data"][i]["reward"]);
           int rewards = int.parse(reward);
           totalReward = totalReward + rewards;
         }
         setState(() {
           totalReward ;
         });
       });

     }else{
       setState(() {
         noData= true; ;
       });

     }


    }
  });
 /* getRewards(token).then((value) {
    setState(() {
      rList = value;
      for (int i = 0; i < rList.length; i++) {
        int reward = int.parse(rList[i].reward);
        totalReward = totalReward + reward;
        print(totalReward);
      }
    });
  });*/

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
         title: Text('Rewards',style: TextStyle(fontWeight: FontWeight.bold),),
         backgroundColor: Color(0xff198d97),
    ),
      body: SingleChildScrollView(
        child: DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
            Container(
              child: TabBar(
                labelColor:Color(0xff198d97),
                unselectedLabelColor:Color(0xfff6821d),
                tabs: [
                  Tab(text: 'Today'),
                  Tab(text: 'History'),
                ],
              ),
            ),

                    Container(
                     height: 750,
                     decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey, width: 0.5))
                     ),
                     child: TabBarView(children: <Widget>[
                       Container(
                         child:Column(
                                 children: [
                                   if(rewarded)Container(
                                     child: Card(
                                       margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 100.0, top: 80.0),
                                       color: Colors.white,
                                       shape: RoundedRectangleBorder(
                                         borderRadius: BorderRadius.circular(16.0),),
                                       elevation: 10,
                                       child: SizedBox(
                                         width: 350,
                                         height: 520,
                                         child: Column(
                                           children: [
                                             Padding(
                                               padding: EdgeInsets.only(left: 10.0, right: 15.0, top: 20.0),
                                               child: Text("Great job! You've watched", style: TextStyle(fontSize: 20),),
                                             ),
                                             Padding(
                                               padding: EdgeInsets.only(left: 20.0, right: 15.0, top: 20.0),
                                               child: Text(rList[i].videoCount+" Videos today", style: TextStyle(fontSize: 20),),
                                             ),
                                             Padding(
                                               padding: EdgeInsets.only(left: 20.0, right: 15.0, top: 20.0),
                                               //child: Text(rList[i].videoCount+" video today", style: TextStyle(fontSize: 20),),
                                             ),
                                             Padding(
                                               padding: EdgeInsets.only(left: 20.0, right: 15.0, top: 10.0),
                                               child: Text("So you deserve a reward", style: TextStyle(fontSize: 20),),
                                             ),
                                             Padding(
                                               padding: EdgeInsets.only(top: 20.0),
                                               child: Container(
                                                 height: 200,
                                                 width: 200,
                                                 child: Image(
                                                   image: AssetImage("assets/image/images.jpg"),
                                                 ),
                                               ),
                                             ),
                                             Padding(
                                                 padding: EdgeInsets.only(top: 20.0),
                                                 child: Text("Reward Earned", style: TextStyle(fontSize: 20),)
                                             ),
                                             Padding(
                                                 padding: EdgeInsets.only(top: 20.0),
                                                 child: Text(totalRewards.toString(), style: TextStyle(fontSize: 50),)
                                             ),
                                             Padding(
                                               padding: EdgeInsets.only(top: 20.0),
                                               //   child: Text("Total videos Viewed :10",style: TextStyle(fontSize: 20),)
                                             ),
                                           ],
                                         ),
                                       ),
                                     ),
                                   ),
                                   if(notRewarded)Container(
                                     child: Card(
                                       margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 100.0, top: 80.0),
                                       color: Colors.white,
                                       shape: RoundedRectangleBorder(
                                         borderRadius: BorderRadius.circular(16.0),),
                                       elevation: 10,
                                       child: SizedBox(
                                         width: 350,
                                         height: 500,
                                         child: Column(
                                           children: [
                                             Padding(
                                               padding: EdgeInsets.only(left: 20.0, right: 15.0, top: 150.0),
                                               child: Text("Hey!!!! Watch Videos", style: TextStyle(fontSize: 20),),
                                             ),
                                             Padding(
                                               padding: EdgeInsets.only(left: 20.0, right: 15.0, top: 20.0),
                                               child: Text("to claim your reward", style: TextStyle(fontSize: 20),),
                                             ),
                                             Padding(
                                               padding: EdgeInsets.only(left: 10.0, top: 20.0),
                                               child:Container(
                                                   width: 180.0,
                                                   height: 50.0,
                                                   margin: EdgeInsets.only(top:10.0),
                                                   child: ElevatedButton(
                                                     child: Text('Watch Now',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white),),
                                                     style: ElevatedButton.styleFrom(
                                                       primary: Color(0xff198d97),
                                                       shape: RoundedRectangleBorder(
                                                         borderRadius: BorderRadius.circular(20),
                                                       ),
                                                     ),
                                                     onPressed: () {
                                                       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                                           YoutubeVideoPlayer(token)), (Route<dynamic> route) => false);                                    },
                                                   )
                                               ),
                                             ),

                                           ],
                                         ),
                                       ),

                                     ),
                                   )
                                 ],
                               ),
                       ),


                      /*Container(
                         child: rList.length > 0 ? ListView.builder(
                               shrinkWrap: true,
                               itemCount: 1,
                               itemBuilder: (cc, i) {
                                 int totalRewards  = int.parse(rList[i].todayReward);
                                 if(totalRewards>0){
                                   rewarded = true;
                                 }else{
                                   notRewarded = true;
                                 }
                                 return Column(
                                   children: [
                                     if(rewarded)Container(
                                       child: Card(
                                         margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 100.0, top: 80.0),
                                         color: Colors.white,
                                         shape: RoundedRectangleBorder(
                                           borderRadius: BorderRadius.circular(16.0),),
                                         elevation: 10,
                                         child: SizedBox(
                                           width: 350,
                                           height: 500,
                                           child: Column(
                                             children: [
                                               Padding(
                                                 padding: EdgeInsets.only(left: 20.0, right: 15.0, top: 20.0),
                                                 child: Text("Great job! You've watched", style: TextStyle(fontSize: 20),),
                                               ),
                                               Padding(
                                                 padding: EdgeInsets.only(left: 20.0, right: 15.0, top: 20.0),
                                                 child: Text(rList[i].videoCount+" video today", style: TextStyle(fontSize: 20),),
                                               ),
                                               Padding(
                                                 padding: EdgeInsets.only(left: 20.0, right: 15.0, top: 20.0),
                                                 child: Text("So you deserve a reward", style: TextStyle(fontSize: 20),),
                                               ),
                                               Padding(
                                                 padding: EdgeInsets.only(top: 20.0),
                                                 child: Container(
                                                   height: 200,
                                                   width: 200,
                                                   child: Image(
                                                     image: AssetImage("assets/image/images.jpg"),
                                                   ),
                                                 ),
                                               ),
                                               Padding(
                                                   padding: EdgeInsets.only(top: 20.0),
                                                   child: Text("Reward Earned", style: TextStyle(fontSize: 20),)
                                               ),
                                               Padding(
                                                   padding: EdgeInsets.only(top: 20.0),
                                                   child: Text(rList[i].todayReward, style: TextStyle(fontSize: 50),)
                                               ),
                                               Padding(
                                                 padding: EdgeInsets.only(top: 20.0),
                                                 //   child: Text("Total videos Viewed :10",style: TextStyle(fontSize: 20),)
                                               ),
                                             ],
                                           ),
                                         ),
                                       ),
                                     ),
                                     if(notRewarded)Container(
                                       child: Card(
                                         margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 100.0, top: 80.0),
                                         color: Colors.white,
                                         shape: RoundedRectangleBorder(
                                           borderRadius: BorderRadius.circular(16.0),),
                                         elevation: 10,
                                         child: SizedBox(
                                           width: 350,
                                           height: 500,
                                           child: Column(
                                             children: [
                                               Padding(
                                                 padding: EdgeInsets.only(left: 20.0, right: 15.0, top: 150.0),
                                                 child: Text("Hey!!!! Watch Videos", style: TextStyle(fontSize: 20),),
                                               ),
                                               Padding(
                                                 padding: EdgeInsets.only(left: 20.0, right: 15.0, top: 20.0),
                                                 child: Text("to claim your reward", style: TextStyle(fontSize: 20),),
                                               ),
                                               Padding(
                                                 padding: EdgeInsets.only(left: 10.0, top: 20.0),
                                                 child:Container(
                                                     width: 180.0,
                                                     height: 50.0,
                                                     margin: EdgeInsets.only(top:10.0),
                                                     child: ElevatedButton(
                                                       child: Text('Watch Now',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18,color: Colors.white),),
                                                       style: ElevatedButton.styleFrom(
                                                         primary: Color(0xff198d97),
                                                         shape: RoundedRectangleBorder(
                                                           borderRadius: BorderRadius.circular(20),
                                                         ),
                                                       ),
                                                       onPressed: () {
                                                         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                                             YoutubeVideoPlayer(token)), (Route<dynamic> route) => false);                                    },
                                                     )
                                                 ),
                                               ),

                                             ],
                                           ),
                                         ),

                                       ),
                                     )
                                   ],
                                 );
                               }):SpinKitCircle(
                           color:Color(0xff198d97),
                           size: 50,) ,
                       ),*/
                       Container(
                         height: 700,
                         child: Column(
                           children: [
                          if(containsData)  Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children:[
                                Container(
                                  child: Card(
                                   margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0, top: 20.0),
                                   color: Colors.white,
                                   shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(16.0),),
                                   elevation: 10,
                                   child: SizedBox(
                                     width: 350,
                                     height: 150,
                                     child: Column(
                                       children: [
                                         Padding(
                                           padding: EdgeInsets.only(left: 10.0, right: 15.0, top: 20.0),
                                           child: Text("Total Rewards Earned", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                         ),
                                         Padding(
                                           padding: EdgeInsets.only(left: 10.0, right: 15.0, top: 20.0),
                                           child: Text(totalReward.toString(), style: TextStyle(fontSize: 20),),
                                         ),
                                       ],
                                     ),
                                   ),

                                 ),
                               ),
                               Container(
                                 height: 550,
                                 width: 400,
                                 child: rList.length > 0 ? ListView.builder(
                                     shrinkWrap: true,
                                     itemCount: rList.length,
                                     itemBuilder: (cc, i) {
                                       String date = rList[i].date;
                                       var dateTime = DateTime.parse(date);
                                       formatted = DateFormat('yyyy/MM/dd').format(dateTime);
                                       final now = new DateTime.now();
                                       String formatter = DateFormat('yyyy/MM/dd').format(now);
                                       if(formatted == formatter){
                                         return SizedBox(height: 10,);
                                       }

                                       // formatted = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
                                       //int totalRewards = rList.map((e) => int.parse(e.reward)).reduce((value, element) => value+element);
                                       return Padding(
                                         padding: EdgeInsets.only(right: 10.0,left: 10.0),
                                         child: Card(
                                           shape: RoundedRectangleBorder(
                                             borderRadius: BorderRadius.circular(16.0),),
                                           color: Colors.white,
                                           elevation: 20,
                                           child: Container(
                                             padding: EdgeInsets.all(10.0),
                                             child: Column(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               children: [
                                                 Row(
                                                   children: [
                                                     Icon(
                                                       Icons.date_range,
                                                       color: Colors.black54,
                                                       size: 30.0,
                                                     ),
                                                     Padding(
                                                       padding: EdgeInsets.only(left: 10.0),
                                                         child: Text(formatted, style: TextStyle(fontSize: 18),)
                                                     )
                                                   ],
                                                 ),
                                                 SizedBox(height: 2.0,),
                                                 Row(
                                                   children: [
                                                     Icon(
                                                       Icons.videocam_rounded,
                                                       color: Colors.black54,
                                                       size: 30.0,
                                                     ),
                                                     Padding(
                                                       padding: EdgeInsets.only(left: 10.0),
                                                         child: Text("Watched "+rList[i].videoCount+" videos", style: TextStyle(fontSize: 18),)
                                                     ),
                                                   ],
                                                 ),
                                                 SizedBox(height: 5.0,),
                                                 Row(
                                                   children: [
                                                     Container(
                                                       height: 30,
                                                       width: 30,
                                                       child: Image(
                                                         image: AssetImage("assets/image/images.jpg"),
                                                       ),
                                                     ),
                                                     Padding(
                                                       padding: EdgeInsets.only(left: 10.0),
                                                         child: Text(rList[i].reward, style: TextStyle(fontSize: 18),)
                                                     ),
                                                   ],
                                                 ),
                                               ],
                                             ),
                                           ),
                                         ),
                                       );
                                     }):SpinKitCircle(
                                   color:Color(0xff198d97),
                                   size: 50,) ,
                               )

                          ],
                           ),
                            if(noData) Container(
                               child: Padding(
                                 padding: EdgeInsets.only(top: 20.0),
                                   child: Text("No history",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                               ),
                             ),
                           ],
                         ),
                       )
                     ],
                     ),
                    ),
          ],
          ),
        ),
      ),
    );
  }
}