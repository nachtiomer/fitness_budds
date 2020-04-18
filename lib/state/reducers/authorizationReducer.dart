import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessbudds/models/user.dart';
import 'package:fitnessbudds/state/actions/authorizationActions.dart';

class AuthorizationState {
  User loggedinUser;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthorizationState();

  AuthorizationState.duplicate(AuthorizationState state) {
    loggedinUser = state.loggedinUser;
  }

  FirebaseAuth get firebaseAuth => _firebaseAuth;
}

AuthorizationState authorizationReducer(
    AuthorizationState prevState, dynamic action) {
  AuthorizationState newState = AuthorizationState.duplicate(prevState);

  if (action is LoginAction) {
    //should check if it involves logout because it inherits login
    newState.loggedinUser = action.payload;
  }

  return newState;
}
