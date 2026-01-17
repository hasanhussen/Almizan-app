abstract class QuestionTypeState {}

class QuestionTypeInitial extends QuestionTypeState {}

class QuestionTypeLoading extends QuestionTypeState {}

class QuestionTypeError extends QuestionTypeState {
  final String? message;
  QuestionTypeError({this.message});
}

class QuestionTypeDone extends QuestionTypeState {}

class QuestionEmpty extends QuestionTypeState {}
