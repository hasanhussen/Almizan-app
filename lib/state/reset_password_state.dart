abstract class ResetPasswordState {}

class ResetPasswordInitialState extends ResetPasswordState {}

class ResetPasswordLoadingState extends ResetPasswordState {}

class ResetPasswordCodeSentState extends ResetPasswordState {}

class ResetPasswordErrorState extends ResetPasswordState {
  final String error;
  ResetPasswordErrorState({required this.error});
}

class ResetPasswordCodeVerifiedState extends ResetPasswordState {}

class ResetPasswordChangedState extends ResetPasswordState {}
