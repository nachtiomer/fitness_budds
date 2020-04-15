import 'package:fitnessbudds/state/reducers/authorizationReducer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';

///each state should have class and a reducer
///each state class should have duplicate constructor
///we initialize all subStates under AppState
///we use the appReducer to call all of the sub reducers

class AppState {
  AuthorizationState authorization;

  AppState({@required this.authorization});

  factory AppState.initial() {
    return AppState(authorization: AuthorizationState());
  }

  AppState.duplicate(AppState state) {
    authorization = AuthorizationState.duplicate(state.authorization);
  }
}

AppState appReducer(AppState prevState, dynamic action) {
  AppState newState = AppState.duplicate(prevState);

  newState.authorization =
      authorizationReducer(prevState.authorization, action);

  return newState;
}

// class Connect extends InheritedWidget {
//   static Connect of(BuildContext context) =>
//       context.dependOnInheritedWidgetOfExactType<Connect>();
//   Connect({Key key, Widget child}) : super(key: key, child: child);

//   @override
//   Widget build(BuildContext context) {
//     return StoreConnector<AppState, AppState>(
//         converter: (store) => store.state, builder: (context, state) {});
//   }
// }
