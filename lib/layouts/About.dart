import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
         title: Text('About Us',style: TextStyle(fontWeight: FontWeight.bold),),
    backgroundColor: Color(0xff198d97),
    ),
      body:Center(
        child:Text("",style: TextStyle(fontSize: 20),),
      )
    );
  }
}