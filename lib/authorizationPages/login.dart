import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessbudds/homePage.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _password, _email, _errorMessage;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        appBar: AppBar(title: Text('Log In')),
        body: Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.all(20),
              child: Column(children: <Widget>[
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
                Text(_errorMessage)
              ]),
            )));
  }
}