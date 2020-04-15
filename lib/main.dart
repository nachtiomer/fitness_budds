import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fitnessbudds/screens/main/splash.dart';

void main() {
  return runApp(MaterialApp(
    theme: ThemeData(primaryColor: Colors.amber, accentColor: Colors.amber),
    debugShowCheckedModeBanner: false,
    home: Center(child: SplashScreen()),
  ));
}
