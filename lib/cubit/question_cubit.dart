import 'dart:async';

import 'package:almizan/general/end_points.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:almizan/general/color.dart';
import 'package:almizan/models/answer.dart';
import 'package:almizan/models/question_model.dart';
import 'package:almizan/models/subjects.dart';
import 'package:almizan/services/cache_helper.dart';
import 'package:almizan/services/dio_helper.dart';
import 'package:almizan/state/question_state.dart';
import 'package:almizan/views/quiz/quiz_finished.dart';

class QuestionCubit extends Cubit<QuestionState> {
  static late QuestionCubit instance;
  QuestionCubit() : super(QuestionInitial()) {
    instance = this;
  }

  static QuestionCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  final Map<int, Answers> answers = {};
  List<Answers> answer = [];
  List<Map<String, dynamic>> endAnswer = [];
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  List<QuestionModel> questions = [];

  Subject? selectSubject;
  int? duration = 5400;
  Timer? examTimer;
  int remainingSeconds = 0;
  int noQuestion = 60;
  List<String> isDone = [];
  List<String> getDone = [];
  bool isPassed = false;
  double totalMarks = 0.0;

  bool isExamActive = false;

  void startTimer() {
    if (duration == null) return;

    remainingSeconds = duration!;
    examTimer?.cancel();

    examTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isExamActive) {
        timer.cancel();
        return;
      }

      remainingSeconds--;

      emit(state);

      if (remainingSeconds <= 0) {
        timer.cancel();
        isExamActive = false;
        emit(TrainingReport()); // أو finish(examid) حسب منطقك
      }
    });
  }

  void changeIndex(id) {
    if (id is! int) {
      print("Error: Index is not an integer. Received: $id");
      return;
    }
    currentIndex = id;
    emit(QuestionDone());
  }

  void addIndex() {
    currentIndex = currentIndex + 1;
    emit(QuestionDone());
  }

  finishTime() {
    isExamActive = false;
    examTimer?.cancel();
    emit(TrainingFinish());
  }

  update(context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => QuizFinishedPage(
              noQuestion: questions.length,
              questions: questions,
              answers: answers,
              totalMarks: totalMarks ?? 0,
            )));
  }

  void back(context) {
    if (currentIndex < (questions.length) && currentIndex > 0) {
      currentIndex = currentIndex - 1;
    }
    emit(QuestionDone());
  }

  nextSubmit(context) {
    if (currentIndex < (questions.length - 1)) {
      addIndex();
    } else {
      emit(TrainingReport());
    }
  }

  void sendAnswers(examid) async {
    // تأكد من أن لديك الإجابات التي تريد إرسالها
    if (answers.isEmpty) {
      Fluttertoast.showToast(
        msg: "لا توجد إجابات لإرسالها.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: primary,
        textColor: Colors.white,
        fontSize: 13,
      );
      return;
    }

    // إعداد البيانات للإرسال
    List<Map<String, dynamic>> answerData = answers.entries.map((entry) {
      return {
        'question_id': entry.key,
        'answer_id': entry.value.id, // تأكد من أن لديك id للإجابة
      };
    }).toList();
    // إرسال البيانات إلى API
    print(answerData);
    print(endAnswer);
    final response = await DioHelper.postData(
      url: '$serverUrl/submitExam', // استبدل هذا بالرابط الصحيح
      token: CacheHelper.getData(key: 'api_token'),
      data: {
        'exam_id': examid, // تأكد من أن لديك examid
        'answers': endAnswer,
      },
    ).then((value) {
      print('ffffffffff$examid');
      if (value?.statusCode == 200 || value?.statusCode == 201) {
        isExamActive = false;
        print(value?.statusCode);
        print(value);
        Fluttertoast.showToast(
          msg: "تم إرسال الإجابات بنجاح.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: primary,
          textColor: Colors.white,
          fontSize: 13,
        );
        print(value?.data);
        isPassed = value?.data['data']['is_passed'];
        totalMarks = value != null
            ? double.parse(value!.data['data']['total_marks'].toString())
            : 0.0;
        print("تم ارسال الاجابات بنجاح");
        print("isPassed=$isPassed");
        if (isPassed == true) {
          print("isPassed=TrainingFinish");
          emit(TrainingFinish());
        } else {
          print("isPassed=TrainingFail");
          emit(TrainingFail());
        }
      } else {
        Fluttertoast.showToast(
          msg: "فشل إرسال الإجابات.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 13,
        );
        return;
      }
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      Fluttertoast.showToast(
        msg: "حدث خطأ: $error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 13,
      );
    });
    print(response);
  }

  void finish(examid) {
    examTimer?.cancel();
    if (answers.isNotEmpty) {
      sendAnswers(examid);
    } else {
      Fluttertoast.showToast(
        msg: "!لم تجب على أي سؤال",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: primary,
        textColor: Colors.white,
        fontSize: 13,
      );
      isExamActive = false;
      emit(TrainingFail());
    }
  }

  bool ba() {
    emit(QuestionDone());
    return true;
  }

  void next(option, context) {
    if (currentIndex < (questions.length - 1) && currentIndex > 0) {
      currentIndex = currentIndex - 1;
    }
    emit(QuestionDone());
  }

  void mark() {
    questions[currentIndex].toggleIsMark();
    emit(QuestionDone());
  }

  void submit() {
    questions[currentIndex].toggleisSubmited();
    emit(QuestionDone());
  }

  void addAnswer(option, questionid, context) {
    final currentQuestion = questions[currentIndex];

    // إذا السؤال متسلّم، لا تسمح بالتعديل
    if (currentQuestion.isSubmited) return;

    answers[currentIndex] = option;
    questions[currentIndex].checkAnswer(option);
    questions[currentIndex].toggleIsSelected();

    if (answers[currentIndex] == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("You must select an answer to continue."),
      ));
      return;
    }

    endAnswer.removeWhere((e) => e['question_id'] == questionid);

    endAnswer.add({
      'question_id': questionid,
      'answer_id': option.id, // تأكد من أن لديك id للإجابة
    });
    emit(QuestionDone());
  }

  void getmyQuestion(int examid, BuildContext context) {
    print(examid);
    emit(QuestionLoading());
    DioHelper.postData(
        url: '$serverUrl/questions',
        query: {},
        token: CacheHelper.getData(key: 'api_token'),
        data: {"exam_id": examid}).then((value) {
      if (value == null || value.statusCode != 200) {
        if (value!.statusCode == 403) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(value.data['message']),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
            ),
          );
          // إخراج المستخدم من الواجهة
          Navigator.of(context).pop();
          emit(
              QuestionError()); // يمكنك استخدام pop لإخراج المستخدم من الواجهة الحالية
          return;
        }
        emit(QuestionError());
        return;
      }

      if (value.data['questions'] != []) {
        print(value.data);
        questions.addAll(value.data['questions']
            .map<QuestionModel>((e) => QuestionModel.fromJson(e))
            .toList());

        questions.forEach((element) {
          element.rand();
        });
        duration = value.data['duration'];
        isExamActive = true;
        startTimer();
      }

      if (questions.length > 0) {
        print(questions);
        //done(examid);
        emit(QuestionDone());
      } else {
        emit(QuestionLoading());
      }
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(QuestionError());
    });
  }

  @override
  Future<void> close() {
    examTimer?.cancel();
    return super.close();
  }
}
