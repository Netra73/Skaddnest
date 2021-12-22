/*import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local/api/PostSignup.dart';
import 'package:flutter_local/main.dart';
import 'package:flutter_local/models/SignUpForm.dart';




class MyYoutubeVideo extends StatefulWidget {
  MyYoutubeVideo({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _YoutubeVideoState createState() => _YoutubeVideoState();
}

class _YoutubeVideoState extends State<MyYoutubeVideo> {
  final _signForm  = GlobalKey<FormState>();
  String name = "";
  String email = "";
  String mobile = "";
  String password = "";
  String errormsg= "";
  bool mblerror= false;
  bool emailerror= false;
  bool autovalidate = false;
  bool  signupError  = false;


  _CreateAccount() {
    final isValid =  _signForm.currentState.validate();
    if (isValid) {
      _signForm.currentState.save();
      _signUp();
    }else{
      setState(() {
        autovalidate= true;
      });
    }
    //_signForm.currentState.save();
  }

  SignUpForm signUpForm = SignUpForm();

  _showLoading() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  child: CircularProgressIndicator(),
                  height: 40.0,
                  width: 40.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Youtube Player'),
     backgroundColor: Colors.black54,
      ),
      body: SingleChildScrollView(
        child: Form(
         autovalidate: autovalidate,
         key: _signForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0,left: 20.0,right: 20.0),
                child: TextFormField(
                  validator: (value){
                    if (value == null ||value.isEmpty) {
                      return 'Enter your name';
                    }
                    return null;
                  },
                  onSaved: (value){
                    signUpForm.name = value;
                    },
                  keyboardType:TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Your Name',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0,left: 20.0,right: 20.0),
                child: TextFormField(
                  validator: (value){
                    if (value == null ||value.isEmpty) {
                      return 'Enter a valid Email id';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    signUpForm.email=value;
                    },
                  onChanged:(val){
                    setState(() {
                      emailerror=false;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email id',
                  ),
                ),
              ),
            if(emailerror)
                Padding(
                  padding: EdgeInsets.only(left:20.0),
                  child: Text(errormsg,style: TextStyle(fontSize: 16,color: Colors.red),),
                ),
              Padding(
                padding: EdgeInsets.only(top: 15.0,left: 20.0,right: 20.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty)
                    {
                      return 'Enter valid mobile number';
                    }
                    return null;
                  },
                  onSaved: (value){
                    signUpForm.mobile = value;
                  },
                  onChanged:(val){
                    setState(() {
                      mblerror=false;
                    });
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Mobile Number',
                  ),
                ),
              ),
           if(mblerror)
                Padding(
                  padding: EdgeInsets.only(left:20.0),
                  child: Text(errormsg,style: TextStyle(fontSize: 16,color: Colors.red),),
                ),
              Padding(
                padding: EdgeInsets.only(top: 15.0,left: 20.0,right: 20.0),
                child: TextFormField(
                  obscureText: true,
                  validator: (value){
                    if (value == null || value.isEmpty) {
                      return 'Enter Password';
                    }
                    return null;
                  },
                  onSaved: (value){
                    signUpForm.password = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                  ),
                ),
              ),
             /*if(signupError)
                Padding(
                  padding: EdgeInsets.only(left:20.0),
                  child: Text(errormsg,style: TextStyle(fontSize:16,color: Colors.red),),
                ),*/
              Container(
                  width: 180.0,
                  height: 50.0,
                  margin: EdgeInsets.only(left:100.0,top:30.0),
                  child: ElevatedButton(
                    child: Text('Create Account',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18),),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black54,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                     /* if(_signForm.currentState.validate()){
                        _signForm.currentState.save();
                        _signUp();
                      }*/
                      _CreateAccount();
                      },

                  )
              ),

              Padding(
                padding: EdgeInsets.only(top:30.0,left: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left:40.0),
                      child: Text("Already member? ",style: TextStyle(fontSize: 18),),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => MyHomePage(),
                        ));
                      },
                        child: Text("Login",style: TextStyle(fontSize: 18,color: Colors.green),),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  _signUp(){
    _showLoading();
    PostSignUp(signUpForm).then((value){
      Navigator.pop(context);
      var response = jsonDecode(value);
      if(response['status'] == 409){
        setState(() {
          errormsg = response['message'];
      //  signupError = true;
         if(errormsg== 'Mobile number already exist'){
            mblerror= true;
          }else{
            emailerror =true;
          }

        });
      }
      if(response['status']==200){
        var data = response['data'];
        print("see profile" );
        print(data);
      }
    });
  }
} */
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local/Validations.dart';
import 'package:flutter_local/api/PostSignup.dart';
import 'package:flutter_local/functions/UserData.dart';
import 'package:flutter_local/layouts/Login.dart';
import 'package:flutter_local/layouts/Payment.dart';
import 'package:flutter_local/layouts/YoutubeVideoPlayer.dart';
import 'package:flutter_local/models/SignUpForm.dart';
import 'package:flutter_local/models/UserForm.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _signUpForm  = GlobalKey<FormState>();
  bool isError = false;
  String errorMsg ="";
  bool autovalidate = false;
  bool isValid = false;
  bool mblError= false;
  bool emailError=false;
  bool signUpError = false;
  SignUpForm signUpForm = SignUpForm();
  UserForm userForm = UserForm();
String token ="";
  _checkValidate() {
    isValid = _signUpForm.currentState.validate();
    if (isValid) {
      _signUpForm.currentState.save();
    _signUp();

    } else {
      setState(() {
        autovalidate = true;
      });
    }

  }
  _showLoading() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  child: CircularProgressIndicator(),
                  height: 40.0,
                  width: 40.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  appBar: AppBar(
       //  title: Text('SignUp'),
      //  backgroundColor: Colors.lightBlue,
    // ),
     body:SingleChildScrollView(
       child: Container(
         //color: Color(0xff198d97),
         width: 400,
         height: 900,
         child: Column(
           children: [
             Padding(
               padding: EdgeInsets.only(left: 10.0,top: 100.0),
               child: Text("Create Your Account Here",style: TextStyle(fontSize:25,color: Colors.black,fontWeight: FontWeight.bold),),
             ),
             Padding(
               padding: EdgeInsets.only(left: 8.0,top: 5.0),
               child: Padding(
                 padding: EdgeInsets.only(top: 30.0),
                 child: Form(
                   autovalidate: autovalidate,
                   key: _signUpForm,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: <Widget>[
                       Padding(
                         padding: EdgeInsets.only(top: 20.0,left: 20.0,right: 20.0),
                         child: TextFormField(
                           validator: (value){
                             if (value==null||value.isEmpty) {
                               return 'Enter Your name';
                             }
                             else{
                               return null;
                             }
                           },
                           onSaved: (value){
                             // signUpForm.name = value;
                             userForm.name = value;
                           },
                           decoration: InputDecoration(
                               border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
                               hintText: "Name",
                               focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Color(0xff198d97)))
                           ),
                         ),
                       ),
                       Padding(
                         padding: EdgeInsets.only(top: 15.0,left: 20.0,right: 20.0),
                         child: TextFormField(
                           validator: (value){
                             return mobileRequired(value, "Enter valid mobile number");
                           },
                           onSaved: (value){
                             userForm.mobile = value;
                           },
                           decoration: InputDecoration(
                               border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
                               hintText: "Mobile Number",
                               focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Color(0xff198d97)))

                           ),
                           keyboardType: TextInputType.phone,
                         ),
                       ),
                       if(mblError)
                         Padding(
                           padding: EdgeInsets.only(left:20.0),
                           child:Text(errorMsg,style: TextStyle(fontSize:16,color: Colors.red),),
                         ),
                       Container(
                         child: Padding(
                           padding: EdgeInsets.only(top: 15.0,left: 20.0,right: 20.0),
                           child: TextFormField(
                             validator: (value){
                               return emailRequired(value, "Enter valid email id");
                             },
                             onSaved: (value){
                               userForm.email = value;
                             },
                             decoration: InputDecoration(
                                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
                                 hintText: "EmailId",
                                 focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Color(0xff198d97)))
                             ),
                             keyboardType: TextInputType.emailAddress,
                           ),
                         ),
                       ),
                       if(emailError)
                         Padding(
                           padding: EdgeInsets.only(left:20.0),
                           child:Text(errorMsg,style: TextStyle(fontSize:16,color: Colors.red),),
                         ),
                       Container(
                         child:Padding(
                           padding: EdgeInsets.only(top: 15.0,left: 20.0,right: 20.0),
                           child: TextFormField(
                             validator: (value) {
                               if (value == null || value.isEmpty) {
                                 return 'Enter Password';
                               }
                               else{
                                 return null;
                               }
                             },
                             obscureText: true,
                             onSaved: (value){
                               //signUpForm.password=value;
                               userForm.password=value;
                             },
                             decoration: InputDecoration(
                                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
                                 hintText: 'Password',
                                 focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Color(0xff198d97)))
                             ),
                           ),
                         ),
                       ),

                       Container(
                           width: 180.0,
                           height: 50.0,
                           margin: EdgeInsets.only(left:100.0,top:30.0),
                           child: ElevatedButton(
                             child: Text('Create Account',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                             style: ElevatedButton.styleFrom(
                               primary: Color(0xff198d97),
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(20),
                               ),
                             ),
                             onPressed: () {
                               _checkValidate();
                             },
                           )
                       ),

                       Padding(
                         padding: EdgeInsets.only(top:40.0,left: 40.0),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             Padding(
                               padding: EdgeInsets.only(left:40.0),
                               child: Text("Already member ? ",style: TextStyle(fontSize: 18),),
                             ),
                             GestureDetector(
                               onTap: () {
                                 Navigator.push(context, MaterialPageRoute(
                                   builder: (context) =>  Login(),
                                 ));
                                                                },
                               child: Text("Login",style: TextStyle(fontSize: 18,color:Color(0xff198d97)),),
                             ),
                           ],
                         ),
                       ),
                     ],
                   ),
                 ),
               ),
             ),
           ],
         ),
       ),
     ),
     /*SingleChildScrollView(
       child: Container(
         color: Color(0xff198d97),
         width: 400,
         height: 900,
         child: Column(
           children: [
             Padding(
               padding: EdgeInsets.only(left: 10.0,top: 100.0),
               child: Text("Create Your Account Here",style: TextStyle(fontSize:25,color: Colors.white,fontWeight: FontWeight.bold),),
             ),
           Padding(
             padding: EdgeInsets.only(left: 8.0,top: 30.0),
             child: Card(
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
                ),
                 color: Colors.white,
                 elevation: 10,
              child: SizedBox(
                width: 350,
                height: 600,
               child: Padding(
                 padding: EdgeInsets.only(top: 30.0),
                 child: Form(
                   autovalidate: autovalidate,
                   key: _signUpForm,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: <Widget>[
                       Padding(
                         padding: EdgeInsets.only(top: 20.0,left: 20.0,right: 20.0),
                         child: TextFormField(
                           validator: (value){
                             if (value==null||value.isEmpty) {
                               return 'Enter Your name';
                             }
                             else{
                               return null;
                             }
                           },
                           onSaved: (value){
                            // signUpForm.name = value;
                             userForm.name = value;
                           },
                           decoration: InputDecoration(
                             border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
                             hintText: "Name",
                               focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Color(0xff198d97)))
                           ),
                         ),
                       ),
                       Padding(
                         padding: EdgeInsets.only(top: 15.0,left: 20.0,right: 20.0),
                         child: TextFormField(
                           validator: (value){
                             return mobileRequired(value, "Enter valid mobile number");
                           },
                           onSaved: (value){
                             userForm.mobile = value;
                           },
                           decoration: InputDecoration(
                               border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
                               hintText: "Mobile Number",
                               focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Color(0xff198d97)))

                           ),
                           keyboardType: TextInputType.phone,
                         ),

                         /*child: TextFormField(
                           validator: (value) {
                             if (value == null || value.isEmpty) {
                               return 'Enter Mobile Number';
                             }
                             else{
                               return null;
                             }
                           },
                           onSaved: (value){
                             //signUpForm.mobile=value;
                             userForm.mobile=value;
                           },
                           decoration: InputDecoration(
                             border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
                             hintText: 'Mobile Number',
                               focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Color(0xff198d97)))
                           ),
                           onChanged:(val) {
                             setState(() {
                               mblError=false;
                             });
                           },
                           keyboardType: TextInputType.phone,
                         ),*/
                       ),
                       if(mblError)
                         Padding(
                           padding: EdgeInsets.only(left:20.0),
                           child:Text(errorMsg,style: TextStyle(fontSize:16,color: Colors.red),),
                         ),
                       Container(
                         child: Padding(
                           padding: EdgeInsets.only(top: 15.0,left: 20.0,right: 20.0),
                           child: TextFormField(
                             validator: (value){
                               return emailRequired(value, "Enter valid email id");
                             },
                             onSaved: (value){
                               userForm.email = value;
                             },
                             decoration: InputDecoration(
                                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
                                 hintText: "EmailId",
                                 focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Color(0xff198d97)))
                             ),
                             keyboardType: TextInputType.emailAddress,
                           ),


                           /* child: TextFormField(
                             validator: (value) {
                               if (value == null || value.isEmpty) {
                                 return 'Enter Email';
                               }
                               else{
                                 return null;
                               }
                             },
                             onSaved: (value){
                               //signUpForm.email=value;
                               userForm.email=value;
                             },
                             decoration: InputDecoration(
                               border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
                               hintText: 'Email id',
                                 focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Color(0xff198d97)))
                             ),
                             onChanged:(val){
                               setState(() {
                                 emailError = false;
                               });
                             },
                           ),*/
                         ),
                       ),
                       if(emailError)
                         Padding(
                           padding: EdgeInsets.only(left:20.0),
                           child:Text(errorMsg,style: TextStyle(fontSize:16,color: Colors.red),),
                         ),
                       Container(
                         child:Padding(
                           padding: EdgeInsets.only(top: 15.0,left: 20.0,right: 20.0),
                           child: TextFormField(
                             validator: (value) {
                               if (value == null || value.isEmpty) {
                                 return 'Enter Password';
                               }
                               else{
                                 return null;
                               }
                             },
                             obscureText: true,
                             onSaved: (value){
                               //signUpForm.password=value;
                               userForm.password=value;
                             },
                             decoration: InputDecoration(
                               border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),),
                               hintText: 'Password',
                                 focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Color(0xff198d97)))
                             ),
                           ),
                         ),
                       ),

                       Container(
                           width: 180.0,
                           height: 50.0,
                           margin: EdgeInsets.only(left:80.0,top:30.0),
                           child: ElevatedButton(
                             child: Text('Create Account',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                             style: ElevatedButton.styleFrom(
                               primary: Color(0xff198d97),
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(20),
                               ),
                             ),
                             onPressed: () {
                               _checkValidate();
                               },
                           )
                       ),

                       Padding(
                         padding: EdgeInsets.only(top:40.0,left: 40.0),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             Padding(
                               padding: EdgeInsets.only(left:40.0),
                               child: Text("Already member ? ",style: TextStyle(fontSize: 18),),
                             ),
                             GestureDetector(
                               onTap: () {
                                 Navigator.push(context, MaterialPageRoute(
                                   builder: (context) =>  Login(),
                                 ));
                                // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                  //   Login()), (Route<dynamic> route) => false);
                               },
                               child: Text("Login",style: TextStyle(fontSize: 18,color:Color(0xff198d97)),),
                             ),
                           ],
                         ),
                       ),
                     ],
                   ),
                 ),
               ),
             ),
       ),
           ),
           ],
         ),
     ),
     ),*/
    );
  }
  _signUp(){
    _showLoading();
    PostSignUp(userForm).then((value){
      Navigator.pop(context);
      var response = jsonDecode(value);
      if(response['status'] == 409){
        setState(() {
        // signUpError= true;
          errorMsg = response['message'];
          print(errorMsg);
          if(errorMsg== 'Mobile number already exist'){
            mblError= true;
          }else{
            emailError =true;
          }
        });
      }
      if(response['status']==200){
        var data = response['data'];
        print("see profile" );
        print(data);
        token = data['token'];
        print(token);
        String code = data['code'];
        print(code);

        setData("code", code).then((value){
          setData("token", jsonEncode(data)).then((value){
            // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            //  Profile(token)), (Route<dynamic> route) => false);
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                YoutubeVideoPlayer(token)), (Route<dynamic> route) => false);
          });
        });
      //  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
           //YoutubeVideoPlayer(token)), (Route<dynamic> route) => false);
       // Navigator.pop(context);
      }
    });

  }
}
