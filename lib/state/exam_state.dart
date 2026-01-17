
abstract class ExamState {}

class ExamInitial extends ExamState {}


class ExamLoading extends ExamState {}
class ExamError extends ExamState {}
class ExamDone extends ExamState {}