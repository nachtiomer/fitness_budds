import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fitnessbudds/splash.dart';

//
void main() => runApp(MaterialApp(
      theme: ThemeData(primaryColor: Colors.amber, accentColor: Colors.amber),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ));
