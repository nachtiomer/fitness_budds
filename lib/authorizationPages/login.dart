import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessbudds/homePage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../ProfileScreen.dart';
import '../main.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _password, _email, _errorMessage;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googlSignIn = new GoogleSignIn();

  Future<FirebaseUser> _signIn(BuildContext context) async {
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text('Sign in'),
    ));

    final GoogleSignInAccount googleUser = await _googlSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    FirebaseUser userDetails =
        (await _firebaseAuth.signInWithCredential(credential)) as FirebaseUser;
    ProviderDetails providerInfo = new ProviderDetails(userDetails.providerId);

    List<ProviderDetails> providerData = new List<ProviderDetails>();
    providerData.add(providerInfo);

    UserDetails details = new UserDetails(
      userDetails.providerId,
      userDetails.displayName,
      userDetails.photoUrl,
      userDetails.email,
      providerData,
    );
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new ProfileScreen(detailsUser: details),
      ),
    );
    return userDetails;
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
        Navigator.of(context).pop(true);
        Navigator.push(
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

    return Scaffold(
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
                _signIn(context).then((FirebaseUser user) {
                  print(user);
                }).catchError((e) {
                  print(e);
                });
              },
            ),
            SignInButton(
              Buttons.Facebook,
              text: "Sign up with Facebook",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
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
