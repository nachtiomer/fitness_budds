import 'dart:async';

import 'package:flutter/material.dart';

import 'authorizationPages/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(color: Colors.green),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    Image.asset("assets/fitnessbuddslogo.jpg"),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                  ),
//                  Text(
//                    "Find your perfect Trainer",
//                    style: TextStyle(
//                        color: Colors.white,
//                        fontSize: 18.0,
//                        fontWeight: FontWeight.bold),
//                  )
                ],
              ),
            ),
          ],
        )
      ],
    ));
  }
}
