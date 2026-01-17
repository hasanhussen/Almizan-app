import 'package:almizan/models/user.dart';

abstract class VerifyState {}

class VerifyInitialState extends VerifyState {}

class VerifyLoadingState extends VerifyState {}

class VerifyUpdateState extends VerifyState {}

class VerifySuccessState extends VerifyState {
  late final User user;
  VerifySuccessState({required this.user});
}

class VerifyErrorState extends VerifyState {
  final String error;
  VerifyErrorState({required this.error});
}
