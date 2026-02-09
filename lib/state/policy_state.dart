

abstract class PolicyState {}

class PolicyInitial extends PolicyState {}

class PolicyLoading extends PolicyState {}

class PolicyLoaded extends PolicyState {
  PolicyLoaded();
}

class PolicyError extends PolicyState {}
