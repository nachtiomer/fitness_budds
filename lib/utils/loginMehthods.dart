import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum LoginMethods { FACEBOOK, GOOGLE, EMAIL }

Future<AuthResult> loginWithFacebook(FirebaseAuth firebaseAuth) async {
  AuthResult result;
  FacebookLogin facebookLogin = FacebookLogin();
  FacebookLoginResult facebookLoginResult =
      await facebookLogin.logIn(['email']);
  final accessToken = facebookLoginResult.accessToken.token;

  if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
    final facebookAuthCred =
        FacebookAuthProvider.getCredential(accessToken: accessToken);
    result = await firebaseAuth.signInWithCredential(facebookAuthCred);
  }

  return result;
}

Future<AuthResult> loginWithGoogle(FirebaseAuth firebaseAuth) async {
  AuthResult result;
  // TODO: move to configuration file
  GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly']);
  GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final googleAuth = await googleSignInAccount.authentication;
  final googleAuthCred = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
  result = await firebaseAuth.signInWithCredential(googleAuthCred);
  return result;
}

Future<AuthResult> loginWithEmail(
    FirebaseAuth firebaseAuth, String email, String password) async {
  AuthResult result = await firebaseAuth.signInWithEmailAndPassword(
      email: email, password: password);
  return result;
}
