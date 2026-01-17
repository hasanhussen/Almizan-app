
abstract class PackageState {}

class PackageInitial extends PackageState {}


class PackageLoading extends PackageState {}
class PackageError extends PackageState {}
class PackageDone extends PackageState {}