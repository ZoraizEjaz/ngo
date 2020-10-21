import 'package:flutter/material.dart';
import 'dart:async';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = new Duration(seconds: 2);
    return new Timer(duration, route);
  }

  route() {
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => AuthScreen()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initScreen(context),
    );
  }

  initScreen(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlutterLogo(
            size: 300,
            ),
            Container(
              //: 300,
              //height: 200,
              //child: Image.asset("assets/images/splash.png"),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            // Text(
            //   "Splash Screen",
            //   style: TextStyle(fontSize: 20.0, color: Colors.white),
            // ),
            // Padding(padding: EdgeInsets.only(top: 20.0)),
            // CircularProgressIndicator(
            //   backgroundColor: Colors.white,
            //   strokeWidth: 1,
            // )
          ],
        ),
      ),
    );
  }
}

