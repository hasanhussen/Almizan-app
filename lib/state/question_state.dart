
abstract class QuestionState {}

class QuestionInitial extends QuestionState {}


class QuestionLoading extends QuestionState {}
class QuestionError extends QuestionState {}
class QuestionDone extends QuestionState {}

class TrainingReport extends QuestionState {}
class TrainingFinish extends QuestionState {}
class TrainingFail extends QuestionState {}
class ExamDone extends QuestionState {}
class ExamError extends QuestionState {}