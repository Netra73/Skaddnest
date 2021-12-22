import 'package:flutter/material.dart';
import 'package:flutter_local/layouts/Login.dart';
import 'package:video_player/video_player.dart';

class GetStarted extends StatefulWidget {
  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
VideoPlayerController _controller;
String url="'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4'";
@override
void initState() {
  super.initState();
  _controller = VideoPlayerController.network('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');

  _controller.addListener(() {
    setState(() {});
  });
  _controller.setLooping(true);
  _controller.initialize().then((_) => setState(() {}));
  _controller.play();
  _controller.setVolume(0.0);
}

@override
void dispose() {
  _controller.dispose();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
         child: Container(
          color: Colors.white,
          height: 900,
          width: 400,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Container(
                  height: 240,
                  width: 250,
                  child: Image(
                    image: AssetImage("assets/image/logo.jpg") ,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.0,top: 1.0,right: 2.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  color: Colors.white,
                  elevation: 20,
                  child: SizedBox(
                    width: 350,
                    height: 400,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Stack( fit: StackFit.expand,
                        children: [
                         Container(
                           child:  _controller.value.isInitialized
                            ? AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                           )
                            : Container(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: ElevatedButton(
                    child: Text("Get Started",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold)
                    ),
                    style: ButtonStyle(
                      // backgroundColor: MaterialStateProperty.all(Color(0xff198d97)),
                        backgroundColor: MaterialStateProperty.all(Color(0xff198d97)),
                        padding: MaterialStateProperty.all(EdgeInsets.only(top: 10.0,bottom: 10.0,left: 40.0,right:40.0)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              //  side: BorderSide(color: Colors.black)
                            )
                        )
                    ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>Login()
                    ));
                  },
                ),
              )
            ],
          ),
        ),
    )
    );
  }
}