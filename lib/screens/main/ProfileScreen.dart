import 'package:fitnessbudds/state/appState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fitnessbudds/models/user.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GoogleSignIn _gSignIn = GoogleSignIn();

    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          var user = state.authorization.loggedinUser;
          return Scaffold(
              appBar: AppBar(
                title: Text(user.userName),
                automaticallyImplyLeading: false,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      FontAwesomeIcons.signOutAlt,
                      size: 20.0,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _gSignIn.signOut();
                      print('Signed out');
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.photoUrl),
                      radius: 50.0,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "Name : " + user.userName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20.0),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "Email : " + user.userEmail,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20.0),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "Provider : " + user.providerDetails,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20.0),
                    ),
                  ],
                ),
              ));
        });
  }
}
