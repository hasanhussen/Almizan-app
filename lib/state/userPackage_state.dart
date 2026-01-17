
abstract class UserPackageState {}

class UserPackageInitial extends UserPackageState {}


class UserPackageLoading extends UserPackageState {}
class UserPackageError extends UserPackageState {}
class UserPackageDone extends UserPackageState {}