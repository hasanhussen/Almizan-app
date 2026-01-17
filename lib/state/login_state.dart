import 'package:almizan/models/user.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  late final User user;
  LoginSuccessState({required this.user});
}

class LoginNSuccessState extends LoginStates {}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState({required this.error});
}
