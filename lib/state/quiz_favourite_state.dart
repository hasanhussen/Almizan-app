
abstract class QuestionFavouriteState {}

class QuestionFavouriteInitial extends QuestionFavouriteState {}


class QuestionFavouriteLoading extends QuestionFavouriteState {}
class QuestionFavouriteError extends QuestionFavouriteState {}
class QuestionFavouriteDone extends QuestionFavouriteState {}
class TrainingFinish extends QuestionFavouriteState {}
class TrainingFail extends QuestionFavouriteState {}
class TrainingReport extends QuestionFavouriteState {}

class ExamDone extends QuestionFavouriteState {}
class ExamError extends QuestionFavouriteState {}