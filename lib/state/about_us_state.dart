

abstract class AppInfoState {}

class AppInfoInitial extends AppInfoState {}

class AppInfoLoading extends AppInfoState {}

class AppInfoLoaded extends AppInfoState {
  // final AppInfoModel data;
  AppInfoLoaded();
}

class AppInfoError extends AppInfoState {}
