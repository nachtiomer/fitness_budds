import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessbudds/homePage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import '../ProfileScreen.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _password, _email, _errorMessage;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  var loggedIn = false;
  var firebaseAuth = FirebaseAuth.instance;

  void initiateSignIn(String type) {
    _handleSignIn(type).then((result) {
      if (result != null) {
        setState(() {
          loggedIn = true;
        });
      }
    });
  }

  Future<FirebaseUser> _handleSignIn(String type) async {
    AuthResult result;
    switch (type) {
      case "FB":
        FacebookLogin facebookLogin = FacebookLogin();
        FacebookLoginResult facebookLoginResult =
            await facebookLogin.logIn(['email']);
        final accessToken = facebookLoginResult.accessToken.token;
        if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
          final facebookAuthCred =
              FacebookAuthProvider.getCredential(accessToken: accessToken);
          result = await firebaseAuth.signInWithCredential(facebookAuthCred);
        } else {
          return null;
        }
        break;
      case "G":
        try {
          GoogleSignInAccount googleSignInAccount = await _handleGoogleSignIn();
          final googleAuth = await googleSignInAccount.authentication;
          final googleAuthCred = GoogleAuthProvider.getCredential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
          result = await firebaseAuth.signInWithCredential(googleAuthCred);
        } catch (error) {
          return null;
        }
    }
    FirebaseUser userDetails = result.user;
    ProviderDetails providerInfo = ProviderDetails(userDetails.providerId);

    List<ProviderDetails> providerData = List<ProviderDetails>();
    providerData.add(providerInfo);

    UserDetails details = UserDetails(
      userDetails.providerId,
      userDetails.displayName,
      userDetails.photoUrl,
      userDetails.email,
      providerData,
    );
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileScreen(detailsUser: details),
        )); //MyHomePage(title:'FitnessBudds'))); //
    return userDetails;
  }

  Future<GoogleSignInAccount> _handleGoogleSignIn() async {
    // TODO: move to configuration file
    GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly']);
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    return googleSignInAccount;
  }

  bool _validateEmail(email) {
    return email.isEmpty;
  }

  bool _validatePassword(input) {
    return input.length < 6;
  }

  Future<void> _logIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        AuthResult result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        FirebaseUser user = result.user;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(title: 'FitnessBudds')));
      } catch (e) {
        print(e.message);
        setState(() {
          _errorMessage = e.message;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_errorMessage == null) {
      _errorMessage = '';
    }

    return Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Fitness Budds"),
          ),
          body: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                TextFormField(
                  // ignore: missing_return
                  validator: (input) {
                    if (_validateEmail(input)) {
                      return 'Please enter a valid Email';
                    }
                  },
                  onSaved: (input) => _email = input,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextFormField(
                  // ignore: missing_return
                  validator: (input) {
                    if (_validatePassword(input)) {
                      return 'Please enter a valid Password';
                    }
                  },
                  onSaved: (input) => _password = input,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                RaisedButton(onPressed: _logIn, child: Text('התחבר')),
                Text(_errorMessage),
                SignInButton(
                  Buttons.Google,
                  text: "Sign up with Google",
                  onPressed: () {
                    initiateSignIn("G");
                  },
                ),
                SignInButton(
                  Buttons.Facebook,
                  text: "Sign up with Facebook",
                  onPressed: () {
                    initiateSignIn("FB");
                  },
                ),
              ],
            ),
          ),
        ));
  }
}

class UserDetails {
  final String providerDetails;
  final String userName;
  final String photoUrl;
  final String userEmail;
  final List<ProviderDetails> providerData;

  UserDetails(this.providerDetails, this.userName, this.photoUrl,
      this.userEmail, this.providerData);
}

class ProviderDetails {
  ProviderDetails(this.providerDetails);

  final String providerDetails;
}
