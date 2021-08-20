import 'dart:async';

import 'package:balize_todo/Services/RootUserLoggedIn.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    start_timer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width*0.5,
          child: Image.asset(
              "Assets/Images/dotloading.gif",
              fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  void start_timer ()
  {

    Timer(
        Duration(seconds: 3),
            (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => CheckRootUser()));
        }
    );


  }



}
