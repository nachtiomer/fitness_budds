import 'package:fitnessbudds/models/user.dart';

class LoginAction{
  final User payload;
  LoginAction(this.payload);
}

class LogoutAction extends LoginAction{
  LogoutAction() : super(null);
}