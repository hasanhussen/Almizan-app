

abstract class ProfileStates {}

class ProfileInitialState extends ProfileStates {}

class ProfileLoadingState extends ProfileStates {}

class ProfileSuccessState extends ProfileStates {
  ProfileSuccessState();
}

class ProfileNSuccessState extends ProfileStates {}

class ProfileNErrorState extends ProfileStates {}

class ProfileErrorState extends ProfileStates {
  final String error;

  ProfileErrorState({required this.error});
}
