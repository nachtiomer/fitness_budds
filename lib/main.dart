import 'package:fitnessbudds/state/appState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fitnessbudds/screens/main/splash.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() {

  final AppState _initialState = AppState.initial();
  final Store<AppState> _store =
      Store<AppState>(appReducer, initialState: _initialState);

  return runApp(StoreProvider<AppState>(
    store: _store,
    child: MaterialApp(
      theme: ThemeData(primaryColor: Colors.amber, accentColor: Colors.amber),
      debugShowCheckedModeBanner: false,
      home: Center(child: SplashScreen()),
    ),
  ));
}
