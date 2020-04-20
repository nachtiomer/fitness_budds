import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessbudds/models/user.dart';
import 'package:fitnessbudds/models/providerDetails.dart';
import 'package:fitnessbudds/screens/main/registerScreen/registerFirstPage.dart';
import 'package:fitnessbudds/state/actions/authorizationActions.dart';
import 'package:fitnessbudds/state/appState.dart';
import 'package:fitnessbudds/utils/loginMehthods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';


class LoginPage extends StatefulWidget {
  final Map<LoginMethods, Function> _loginMethods = {
    LoginMethods.EMAIL: loginWithEmail,
    LoginMethods.FACEBOOK: loginWithFacebook,
    LoginMethods.GOOGLE: loginWithGoogle
  };

  Map<LoginMethods, Function> get loginMethods => _loginMethods;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _password, _email, _errorMessage;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseAuth _firebaseAuth;
  dynamic dispatch;
  var loggedIn = false;

  void initiateSignIn(LoginMethods type) {
    _handleSignIn(type).then((result) {
      if (result != null) {
        setState(() {
          loggedIn = true;
        });
      }
    });
  }

  Future<FirebaseUser> _handleSignIn(LoginMethods type) async {
    AuthResult result;

    if (type == LoginMethods.EMAIL) {
      result = await _logIn();
    } else {
      result = await widget.loginMethods[type](_firebaseAuth);
    }

    FirebaseUser userDetails = result.user;
    ProviderDetails providerInfo = ProviderDetails(userDetails.providerId);

    List<ProviderDetails> providerData = List<ProviderDetails>();
    providerData.add(providerInfo);

    // TODO: something smarter
    String genderPreference;
    DateTime birthDate;
    String gender;
    String level;
    String age;
    String workoutCity;
    String phoneNumber;
    List<String> friendsList;
    List<String> perfectTrainers;
    List<String> activityPreference;
    User user = User(
        genderPreference,
        userDetails.providerId ?? 'email',
        userDetails.displayName ?? _email,
        userDetails.photoUrl ?? '',
        userDetails.email ?? _email,
        birthDate,
        level,
        age,
        workoutCity,
        phoneNumber,
        friendsList,
        activityPreference,
        providerData ?? '',
        perfectTrainers,
        gender);

    if (dispatch != null) {
      dispatch(LoginAction(user));
    }

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterFirstPage(user:user),//ProfileScreen(user: user),
        ));
    return userDetails;
  }

  bool _validateEmail(email) {
    return !email.isEmpty;
  }

  bool _validatePassword(input) {
    return input.length > 6;
  }

  Future<AuthResult> _logIn() async {
    final formState = _formKey.currentState;
    AuthResult result;
    if (formState.validate()) {
      formState.save();
      try {
        result = await widget._loginMethods[LoginMethods.EMAIL](
            _firebaseAuth, _email, _password);
      } catch (e) {
        print(e.message);
        setState(() {
          _errorMessage = e.message;
        });
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    if (_errorMessage == null) {
      _errorMessage = '';
    }

    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          dispatch = StoreProvider.of<AppState>(context).dispatch;
          _firebaseAuth = state.authorization.firebaseAuth;
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
                        validator: (String input) => !_validateEmail(input)
                            ? 'Please enter a valid Email'
                            : null,
                        onSaved: (input) => _email = input,
                        decoration: InputDecoration(labelText: 'Email'),
                      ),
                      TextFormField(
                        validator: (String input) => !_validatePassword(input)
                            ? 'Please enter a valid Password'
                            : null,
                        onSaved: (input) => _password = input,
                        decoration: InputDecoration(labelText: 'Password'),
                        obscureText: true,
                      ),
                      RaisedButton(
                          onPressed: () {
                            initiateSignIn(LoginMethods.EMAIL);
                          },
                          child: Text('התחבר')),
                      Text(_errorMessage),
                      SignInButton(
                        Buttons.Google,
                        text: "Sign up with Google",
                        onPressed: () {
                          initiateSignIn(LoginMethods.GOOGLE);
                        },
                      ),
                      SignInButton(
                        Buttons.Facebook,
                        text: "Sign up with Facebook",
                        onPressed: () {
                          initiateSignIn(LoginMethods.FACEBOOK);
                        },
                      ),
                    ],
                  ),
                ),
              ));
        });
  }
}
