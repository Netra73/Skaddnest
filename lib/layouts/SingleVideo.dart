

/*import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class SingleVideo extends StatefulWidget {
  String id ;
  SingleVideo(this.id, {mediaUrl});
  @override
  _SingleVideoState createState() => _SingleVideoState();
}

class _SingleVideoState extends State<SingleVideo> {
  YoutubePlayerController _controller;
  bool _isPlayerReady = false;
  int vpos = 0;
  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  TextEditingController _idController;
  TextEditingController _seekToController;


  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: true,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
        hideControls: false,
      ),
    );_controller.addListener(() {
      Duration pos = _controller.value.position;
      int crpos = pos.inSeconds;
      int comp = crpos-vpos;
      if(comp>1){
        _controller.seekTo(Duration(seconds: vpos));
      } else {
        setState(() {
          vpos = pos.inSeconds;
        });
      }
    }
    );
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
    _controller.value.position;
  }
  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: [
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
            ),
          ],
        ),
      );
  }

}*/
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local/api/AddReward.dart';
import 'package:flutter_local/api/getVideoList.dart';
import 'package:flutter_local/layouts/YoutubeVideoPlayer.dart';
import 'package:flutter_local/models/VideoLinks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SingleVideo extends StatefulWidget {
  final String mediaUrl,id,title,date,minDuration,token,clientName;
  final int viewStatus;
  final VoidCallback onCallBack;
  const SingleVideo({Key key, this.id, this.mediaUrl,this.title,this.date,this.minDuration,this.viewStatus,this.token,this.clientName, this.onCallBack}) ;
  @override
  _SingleVideoState createState() => _SingleVideoState(id,title,date,minDuration,viewStatus,token,clientName);
}

class _SingleVideoState extends State<SingleVideo> {
  _SingleVideoState (this.id,this.title,this.date,this.minDuration,this.viewStatus,this.token,this.clientName);
  List<VideoLinks>vList = [];
  String token ;
  String id ;
  String clientName ;
  String mediaUrl ;
  String minDuration ;
  int viewStatus ;
  var status;
  int view = 0;

  String title ;
  String date ;
  YoutubePlayerController _controller;
  bool _isPlayerReady = false;
  int vpos = 0;
  int duration = 0;
  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  TextEditingController _idController;
  TextEditingController _seekToController;
  var position=false;
  int i = 0;
  bool vposition = true;
  bool vpostn = false;
  bool containsData = false;
  bool noData = false;
  var formatted;

  @override
  void initState() {
   /* getVideoList(token).then((value) {
      setState(() {
        vList = value;

      });
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
    _controller = YoutubePlayerController(
      initialVideoId: widget.mediaUrl,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: true,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
       hideControls: false,
      ),
    );_controller.addListener(() {
     Duration pos = _controller.value.position;
      int crpos = pos.inSeconds;
      int comp = crpos-vpos;
      if(comp>1){
        _controller.seekTo(Duration(seconds: vpos));
      } else {
        setState(() {
          vpos = pos.inSeconds;
          print(vpos);
          _addReward();
        });
      }
    }
    );

    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.paused;
    _controller.value.position;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;

      });
    }

  }

  @override
  Widget build(BuildContext context) {
     return WillPopScope(
       child: OrientationBuilder(builder:
           (BuildContext context, Orientation orientation) {
         if (orientation == Orientation.landscape) {
           return Scaffold(
             body: youtubeHierarchy(),
           );
         } else {
           return Scaffold(
             appBar: AppBar(
               title: Text('SK AD Nest',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
               backgroundColor: Color(0xff198d97),
             ),
             body:SingleChildScrollView(
               child: Container(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children:[
                     Card(
                       margin: EdgeInsets.fromLTRB(5, 0, 2, 5),
                          child: Padding(
                     padding: const EdgeInsets.only(left: 5.0,right: 2.0,top:5.0,bottom: 10.0),
                     child: youtubeHierarchy(),
                   ),
                 ),

                     Padding(
                       padding: const EdgeInsets.all(5.0),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           SizedBox(height: 10.0,),
                           Padding(
                             padding: EdgeInsets.only(left: 10.0),
                             child: Text("Title: "+title,style:TextStyle(fontSize:18),),
                           ),
                           SizedBox(height: 10.0,),
                           Padding(
                             padding: EdgeInsets.only(left: 10.0),
                             child: Text("Posted By :"+clientName,style:TextStyle(fontSize:18),),
                           ),
                           SizedBox(height: 10.0,),
                           Padding(
                             padding: EdgeInsets.only(left: 10.0),
                             child: Text("Posted Date: "+date,style:TextStyle(fontSize:17),),
                           ),
                           SizedBox(height: 10.0,),
                         ],
                       ),
                     ),
                    if(containsData) Container(
                       height: 400,
                       width: 400,
                       child: vList.length > 0 ?ListView.builder(
                           shrinkWrap: true,
                           itemCount: vList.length,
                           itemBuilder: (cc, i) {
                             vList.sort((a, b) => a.viewStatus.compareTo(b.viewStatus));
                             if(  vList[i].id == id ||vList[i].viewStatus == 1) {
                               print(vList[i].viewStatus);
                               return SizedBox(height: 10,);
                             }
                             String  url = vList[i].path;
                             String path  = url.substring(url.length -11);

                             String date = vList[i].date;
                             var dateTime = DateTime.parse(date);
                             formatted = DateFormat('yyyy/MM/dd  hh:mm a').format(dateTime);

                            // var dateTime = DateTime.parse(date);
                             //  formatted = "${dateTime.day}-${dateTime.month}-${dateTime.year}${dateTime.hour}:${dateTime.minute}";
                             //formatted = "${dateTime.day}-${dateTime.month}-${dateTime.year}";

                             return Card(
                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
                               elevation: 10,
                               margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                               child: Padding(
                                 padding: const EdgeInsets.all(5.0),
                                 child: GestureDetector(
                                   onTap: () {
                                     Navigator.push(context, MaterialPageRoute(
                                       builder: (context) => SingleVideo(mediaUrl:path,id:vList[i].id,title:vList[i].title,date:vList[i].date,
                                           minDuration:vList[i].minDuration,viewStatus:vList[i].viewStatus,
                                           token:token,clientName:vList[i].clientName,
                                           onCallBack: () {
                                             setState(() {
                                               vList[i].viewStatus = 1;
                                             });
                                           }
                                       ),
                                     ),
                                     );
                                   },
                                   child: Container(
                                     child: Row(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Stack(
                                           children: [
                                             Container(
                                               height: 140,
                                               width: 100,
                                               child: Image.network('https://img.youtube.com/vi/'+path+'/0.jpg',
                                                   height: 150, fit:BoxFit.fill),
                                             ),
                                             SizedBox(width: 5.0),
                                             Padding(
                                               padding: EdgeInsets.only(top: 20.0),
                                               child: Container(
                                                   width: 100,
                                                   height: 100,
                                                   child: Center(child: Icon(Icons.play_circle_outline, size: 50.0,))
                                               ),
                                             ),
                                           ],
                                         ),
                                         SizedBox(width: 15,),
                                         Expanded(
                                           child: Container(
                                             child: Column(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               children: [
                                                 SizedBox(height: 5,),
                                                 Text("Title: "+vList[i].title,style:TextStyle(fontSize: 20),),
                                                 SizedBox(height: 10,),
                                                 Text("Posted By: "+vList[i].clientName ,style:TextStyle(fontSize: 14),),
                                                 SizedBox(height: 10,),
                                                 Text("Posted Date: " +formatted,style:TextStyle(fontSize: 14),),
                                                 SizedBox(height: 10,),
                                                 if(vList[i].viewStatus == 1)Row(
                                                   children: [
                                                     Text("viewed",style: TextStyle(color: Color(0xff198d97))),
                                                     Icon(Icons.check_circle, size: 30.0,color:  Color(0xff198d97),),
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
                           }):SpinKitCircle(
                         color:Color(0xff198d97),
                         size: 50,) ,
                     ),
                     if(noData)Container(
                       child: Padding(
                           padding: EdgeInsets.only(top: 20.0),
                           child: Text("No Videos to watch",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                       ),
                     ),
                     /* Container(
                   child: vList.length == 0 ? FutureBuilder(
                     future: getVideoList(token),
                     builder: (context, snapshot) {
                       if (snapshot.connectionState == ConnectionState.waiting) {
                         return SpinKitCircle(
                           color:Color(0xff198d97),
                           size: 50,
                         );
                       }
                       if (snapshot.hasData) {
                         vList = snapshot.data;
                         return videoList();
                       }
                       return Container(
                         child: Padding(
                           padding: EdgeInsets.only(left:140.0,),
                           child: Text('No videos',style: TextStyle(fontSize: 20),),
                         ),
                       );
                     },
                   ) : videoList(),
                 ),*/
                     /* Container(
                   height:1000,
                   color: Colors.black12,
                   child: ListView.builder(
                       shrinkWrap: true,
                       itemCount:20,
                       itemBuilder: (cc, i) {
                         return Column(
                           children: [
                             Card(
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(16.0),
                               ),
                               elevation: 10,
                               margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                               child: Padding(
                                 padding: const EdgeInsets.all(10.0),
                                 child: Container(
                                   child: Column(
                                     children: [
                                       Row(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Stack(
                                             children: [
                                               Container(
                                                   height: 100,
                                                   width: 100,
                                                   child: Image(
                                                     image: AssetImage("assets/image/sliderone.jpg"),
                                                   )
                                               ),
                                               SizedBox(width: 5.0),
                                               Container(
                                                   width: 100,
                                                   height: 100,
                                                   child: Center(child: Icon(
                                                     Icons.play_circle_outline,
                                                     size: 50.0,))
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
                                                   SizedBox(height: 10,),
                                                   Text("Video Title", style: TextStyle(fontSize: 20),),
                                                   SizedBox(height: 10.0,),
                                                   Text("Posted By : Eneblur Consulting", style: TextStyle(fontSize: 16),),
                                                   SizedBox(height: 10.0,),
                                                   Text("Posted Date: 01/09/2021", style: TextStyle(fontSize: 16),),
                                                   SizedBox(height: 10,),
                                                 ],
                                               ),
                                             ),
                                           )
                                         ],
                                       ),
                                     ],
                                   ),
                                 ),
                               ),
                             ),
                           ],
                         );
                       }
                      ),
                 ),*/

                   ],
                 ),
               ),
             ),

             //youtubeHierarchy(),
           );
         }
       }),
     );

      /* Scaffold(
       appBar: AppBar(
         title: Text('SK AD Nest',style: TextStyle(color: Colors.white,fontSize: 25),),
         backgroundColor: Color(0xff198d97),
       ),
         body: SingleChildScrollView(
           child: Container(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children:[

              /* WillPopScope(
                 child: OrientationBuilder(builder:
                   (BuildContext context, Orientation orientation) {
                 if (orientation == Orientation.landscape) {
                   return Scaffold(
                     body: youtubeHierarchy(),
                   );
                 } else {
                   return Scaffold(
                     appBar: AppBar(
                       title: Text(widget.title),
                     ),
                     body: youtubeHierarchy(),
                   );
                 }
               }),
             ),*/
                /* Card(
                   margin: EdgeInsets.fromLTRB(5, 0, 2, 5),
                   child: Padding(
                     padding: const EdgeInsets.only(left: 5.0,right: 2.0,top:5.0,bottom: 10.0),
                     child: YoutubePlayer(
                       controller: _controller,
                       showVideoProgressIndicator: true,
                       progressIndicatorColor: Colors.blueAccent,
                     ),
                   ),
                 ),*/

                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     SizedBox(height: 10.0,),
                     Padding(
                       padding: EdgeInsets.only(left: 10.0),
                         child: Text("Title: "+title,style:TextStyle(fontSize:18),),
                     ),
                     SizedBox(height: 10.0,),
                     Padding(
                       padding: EdgeInsets.only(left: 10.0),
                       child: Text("Posted By :"+clientName,style:TextStyle(fontSize:18),),
                     ),
                     SizedBox(height: 10.0,),
                     Padding(
                       padding: EdgeInsets.only(left: 10.0),
                       child: Text("Posted Date:"+date,style:TextStyle(fontSize:18),),
                     ),
                     SizedBox(height: 10.0,),
                   ],
                 ),
                Container(
                  height: 400,
                  width: 400,
                  child: vList.length > 0 ?ListView.builder(
                      shrinkWrap: true,
                      itemCount: vList.length,
                      itemBuilder: (cc, i) {
                        String  url = vList[i].path;
                        String path  = url.substring(url.length -11);
                        vList.sort((a, b) => a.viewStatus.compareTo(b.viewStatus));

                        String date = vList[i].date;

                        var dateTime = DateTime.parse(date);
                      //  formatted = "${dateTime.day}-${dateTime.month}-${dateTime.year}${dateTime.hour}:${dateTime.minute}";
                        formatted = "${dateTime.day}-${dateTime.month}-${dateTime.year}";

                        return Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
                          elevation: 10,
                          margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => SingleVideo(mediaUrl:path,id:vList[i].id,title:vList[i].title,date:vList[i].date,
                                        minDuration:vList[i].minDuration,viewStatus:vList[i].viewStatus,
                                        token:token,clientName:vList[i].clientName,
                                      onCallBack: () {
                                        setState(() {
                                          vList[i].viewStatus = 1;
                                        });
                                      }
                                    ),
                                ));
                              },
                              child: Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                              Container(
                                                  height: 140,
                                                  width: 100,
                                                  child: Image.network('https://img.youtube.com/vi/'+path+'/0.jpg',
                                                      height: 150, fit:BoxFit.fill),
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
                                    SizedBox(width: 15,),
                                    Expanded(
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 5,),
                                            Text("Title: "+vList[i].title,style:TextStyle(fontSize: 20),),
                                            SizedBox(height: 10,),
                                            Text("Posted By: "+vList[i].clientName ,style:TextStyle(fontSize: 16),),
                                            SizedBox(height: 10,),
                                            Text("Posted Date: " +formatted,style:TextStyle(fontSize: 16),),
                                            SizedBox(height: 10,),
                                            if(vList[i].viewStatus == 1)Row(
                                              children: [
                                                Text("viewed"),
                                                Icon(Icons.check_circle, size: 30.0,),
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
                      }):SpinKitCircle(
                    color:Color(0xff198d97),
                    size: 50,) ,
                ),

                /* Container(
                   child: vList.length == 0 ? FutureBuilder(
                     future: getVideoList(token),
                     builder: (context, snapshot) {
                       if (snapshot.connectionState == ConnectionState.waiting) {
                         return SpinKitCircle(
                           color:Color(0xff198d97),
                           size: 50,
                         );
                       }
                       if (snapshot.hasData) {
                         vList = snapshot.data;
                         return videoList();
                       }
                       return Container(
                         child: Padding(
                           padding: EdgeInsets.only(left:140.0,),
                           child: Text('No videos',style: TextStyle(fontSize: 20),),
                         ),
                       );
                     },
                   ) : videoList(),
                 ),*/
              /* Container(
                   height:1000,
                   color: Colors.black12,
                   child: ListView.builder(
                       shrinkWrap: true,
                       itemCount:20,
                       itemBuilder: (cc, i) {
                         return Column(
                           children: [
                             Card(
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(16.0),
                               ),
                               elevation: 10,
                               margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                               child: Padding(
                                 padding: const EdgeInsets.all(10.0),
                                 child: Container(
                                   child: Column(
                                     children: [
                                       Row(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Stack(
                                             children: [
                                               Container(
                                                   height: 100,
                                                   width: 100,
                                                   child: Image(
                                                     image: AssetImage("assets/image/sliderone.jpg"),
                                                   )
                                               ),
                                               SizedBox(width: 5.0),
                                               Container(
                                                   width: 100,
                                                   height: 100,
                                                   child: Center(child: Icon(
                                                     Icons.play_circle_outline,
                                                     size: 50.0,))
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
                                                   SizedBox(height: 10,),
                                                   Text("Video Title", style: TextStyle(fontSize: 20),),
                                                   SizedBox(height: 10.0,),
                                                   Text("Posted By : Eneblur Consulting", style: TextStyle(fontSize: 16),),
                                                   SizedBox(height: 10.0,),
                                                   Text("Posted Date: 01/09/2021", style: TextStyle(fontSize: 16),),
                                                   SizedBox(height: 10,),
                                                 ],
                                               ),
                                             ),
                                           )
                                         ],
                                       ),
                                     ],
                                   ),
                                 ),
                               ),
                             ),
                           ],
                         );
                       }
                      ),
                 ),*/

               ],
             ),
           ),
         ),*/

       //);

       /*Scaffold(
        appBar: AppBar(
         backgroundColor:Colors.black54,
          title: Text('Video'),
      ),
      body: Container(
        child: Column(
          children: [
         Padding(
           padding: EdgeInsets.only(top: 2.0),
           child: Container(
                   height:250,
                    width: 400,
                  child:YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.blueAccent,
              ),
            ),
         ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 130.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5,),
                    //  Text(vList[i].title, style: mainStyle.text20,),
                    //Text(vList[i].date, style: mainStyle.text14,),
                    Text("Video Title",style:TextStyle(fontSize: 20),),
                    Text("Posted By : Eneblur Consulting",style:TextStyle(fontSize: 16),),
                    Text("Posted Date: 01/09/2021",style:TextStyle(fontSize: 16),),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            )
         ],
        ),
      ),
    );*/
  }
 /* ListView videoList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: vList.length,
        itemBuilder: (cc, i) {
          String  url = vList[i].path;
          String path  = url.substring(url.length -11);
          vList.sort((a, b) => a.viewStatus.compareTo(b.viewStatus));
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 10,
            margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: GestureDetector(
                onTap: () {
                       Navigator.push(context, MaterialPageRoute(
                      builder: (context) => SingleVideo(mediaUrl:path,id:vList[i].id,title:vList[i].title,date:vList[i].date,
                          minDuration:vList[i].minDuration,viewStatus:vList[i].viewStatus,token:token,clientName:vList[i].clientName)
                       ));
                  },
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          FutureBuilder(
                              future:getVideoList(token),
                              builder: (cc,snap){
                                if(snap.hasData){
                                  return Container(
                                    height: 140,
                                    width: 100,
                                    child: Image.network('https://img.youtube.com/vi/'+path+'/0.jpg',
                                        height: 150,
                                        fit:BoxFit.fill),
                                  );
                                }
                                return SizedBox();
                              }),
                          SizedBox(width: 5.0),
                          Container(
                              width: 100,
                              height: 100,
                              child: Center(child: Icon(Icons.play_circle_outline, size: 50.0,))),
                        ],
                      ),
                      SizedBox(width: 15,),
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5,),
                                 Text("Title: "+vList[i].title,style:TextStyle(fontSize: 20),),
                              SizedBox(height: 10,),
                               Text("Posted By: "+vList[i].clientName,style:TextStyle(fontSize: 16),),
                              SizedBox(height: 10,),
                              Text("Date: "+vList[i].date,style:TextStyle(fontSize: 16),),
                              SizedBox(height: 10,),
                                if(vList[i].viewStatus == 1)Text("*This video has already viewed*",style: TextStyle(color: Color(0xfff6821d)),),
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
        });
  }*/

   _addReward() {
      status = viewStatus;
      duration = int.parse(minDuration);
    if(vpos>=duration && status == 0 && vposition) {

      setState(() {
        vposition = false;
      });
      AddReward(id, token).then((value) {
        widget.onCallBack?.call();
          var response = jsonDecode(value);
          if (response['status'] == 422) {
            setState(() {

            });
          }
          if (response['status'] == 200) {
         /* Navigator.of(context).pushNamed("route123").then((result) {
              if (result != null) {
                refreshCall();
              }
            }).catchError((error) {});*/
          }
        });
    }
  }
  youtubeHierarchy() {
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.fill,
          child: YoutubePlayer(
            controller: _controller,
          ),
        ),
      ),
    );
  }

}
