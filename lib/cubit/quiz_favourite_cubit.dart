// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:almizan/general/color.dart';
// import 'package:almizan/models/answer.dart';

// import 'package:almizan/models/favourite.dart';
// import 'package:almizan/models/subjects.dart';
// import 'package:almizan/services/cache_helper.dart';
// import 'package:almizan/services/dio_helper.dart';
// import 'package:almizan/state/quiz_favourite_state.dart';

// import 'package:http/http.dart' as http;

// import '../views/quiz/quiz_finished.dart';

// class QuestionFavouriteCubit extends Cubit<QuestionFavouriteState> {
//   QuestionFavouriteCubit() : super(QuestionFavouriteInitial());

//   static QuestionFavouriteCubit get(context) => BlocProvider.of(context);
//   int currentIndex = 0;
//   final Map<int, dynamic> answers = {};
//   List<Answers> answer = [];
//   List? category;
//   final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
//   List<FavouriteModel> QuestionFavourites = [];
//   List<FavouriteModel> questions = [];
//   Subject? selectSubject;
//   bool isfree = false;
//   int noQuestion = 60;
//   void changenumber(number, isf) {
//     noQuestion = int.parse(number!);
//     isfree = isf;
//   }

//   void changeSubject(s) {
//     selectSubject = s;
//   }

//   int QuestionFavouriteCount = 0;

//   void changeIndex(id) {
//     currentIndex = id;
//     emit(QuestionFavouriteDone());
//   }

//   void addIndex() {
//     currentIndex = currentIndex + 1;
//     emit(QuestionFavouriteDone());
//   }

//   changeCategory(value) {
//     category = value;
//     emit(QuestionFavouriteDone());
//   }

//   addQuestion(value) {
//     QuestionFavourites = value;
//     emit(QuestionFavouriteDone());
//   }

//   finishTime() {
//     emit(TrainingFinish());
//   }

//   void finish(context) {
//     if (answers.isNotEmpty) {
//       int correct = 0;
//       int uncorrect = 0;
//       int t = 0;
//       answers.forEach((index, value) {
//         if (value.isCorrect == 1) {
//           correct++;
//           t++;
//         } else {
//           uncorrect++;
//           t++;
//         }
//       });
//       if (!isfree) {
//         if (QuestionFavourites.length > 60) {
//           int total = 60 - t;
//           uncorrect = uncorrect + total;
//         } else {
//           int total = QuestionFavourites.length - t;
//           uncorrect = uncorrect + total;
//         }
//       } else {
//         if (noQuestion! < QuestionFavourites.length) {
//           int total = noQuestion - t;
//           uncorrect = uncorrect + total;
//         } else {
//           int total = QuestionFavourites.length - t;
//           uncorrect = uncorrect + total;
//         }
//       }

//       if (correct >= uncorrect) {
//         emit(TrainingFinish());
//       } else {
//         emit(TrainingFail());
//       }
//       addExam();
//     } else {
//       Fluttertoast.showToast(
//         msg: "لم تجب على اي سؤال بعد",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.SNACKBAR,
//         timeInSecForIosWeb: 1,
//         backgroundColor: primary,
//         textColor: Colors.white,
//         fontSize: 13,
//       );
//     }
//   }

//   List<FavouriteModel> getquestion() {
//     if (isfree) {
//       if (noQuestion! < QuestionFavourites.length) {
//         for (int i = 0; i < noQuestion; i++) {
//           questions.add(QuestionFavourites[i]);
//         }
//       } else {
//         questions.addAll(QuestionFavourites);
//       }
//     } else {
//       if (QuestionFavourites.length > 60) {
//         for (int i = 0; i < 60; i++) {
//           questions.add(QuestionFavourites[i]);
//         }
//       } else {
//         questions.addAll(QuestionFavourites);
//       }
//     }
//     return questions;
//   }

//   bool ba() {
//     emit(QuestionFavouriteDone());
//     return true;
//   }


//   void back(context) {
//     if (currentIndex < (QuestionFavourites.length) && currentIndex > 0) {
//       currentIndex = currentIndex - 1;
//     }
//     emit(QuestionFavouriteDone());
//   }

//   nextSubmit(context) {


//     if (isfree) {
//       if (currentIndex < (noQuestion - 1)) {
//         addIndex();
//       } else {
//         emit(TrainingReport());
//       }
//     } else {
//       if (QuestionFavourites.length < 60) {
//         if (currentIndex < (QuestionFavourites.length - 1)) {
//           addIndex();
//         } else {
//           if (answers.isNotEmpty) {
//             emit(TrainingReport());
//           } else {
//             Fluttertoast.showToast(
//               msg: "لم تجب على اي سؤال بعد",
//               toastLength: Toast.LENGTH_SHORT,
//               gravity: ToastGravity.SNACKBAR,
//               timeInSecForIosWeb: 1,
//               backgroundColor: primary,
//               textColor: Colors.white,
//               fontSize: 13,
//             );
//           }
//         }
//       } else {
//         if (currentIndex < (60 - 1)) {
//           addIndex();
//         } else {
//           if (answers.isNotEmpty) {
//             emit(TrainingReport());
//           } else {
//             Fluttertoast.showToast(
//               msg: "لم تجب على اي سؤال بعد",
//               toastLength: Toast.LENGTH_SHORT,
//               gravity: ToastGravity.SNACKBAR,
//               timeInSecForIosWeb: 1,
//               backgroundColor: primary,
//               textColor: Colors.white,
//               fontSize: 13,
//             );
//           }
//         }
//       }
//     }
//   }

//   void next(option, context) {
//     if (currentIndex < (QuestionFavourites.length - 1) && currentIndex > 0) {
//       currentIndex = currentIndex - 1;
//     }
//     emit(QuestionFavouriteDone());
//   }

//   void mark() {
//     QuestionFavourites[currentIndex].toggleIsMark();
//     emit(QuestionFavouriteDone());
//   }

//   void submit() {
//     QuestionFavourites[currentIndex].toggleisSubmited();

//     emit(QuestionFavouriteDone());
//   }

//   void addAnswer(option, context) {
//     answers[currentIndex] = option;
//     QuestionFavourites[currentIndex].checkAnswer(option);
//     QuestionFavourites[currentIndex].toggleIsSelected();

//     if (answers[currentIndex] == null) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text("You must select an answer to continue."),
//       ));
//       return;
//     }
//     emit(QuestionFavouriteDone());
//   }

//   void getQuestionFavourite(List id) {
//     print(id);

//     for (var element in id) {
//       emit(QuestionFavouriteLoading());
//       DioHelper.postData(
//           url: 'QuestionFavourite2/getQuestionFavourites',
//           query: {},
//           data: {"TYPE_ID": element}).then((value) {
//         if (value == null || value.statusCode != 200) {
//           emit(QuestionFavouriteError());
//           return;
//         }
//         if (value.data['QuestionFavourite'] != []) {
//           QuestionFavourites.addAll(value.data['QuestionFavourites']
//               .map<FavouriteModel>((e) => FavouriteModel.fromJson(e))
//               .toList());

//           QuestionFavourites.forEach((element) {
//             element.rand();
//           });
//         }

//         if (QuestionFavourites.length > 0) {
//           emit(QuestionFavouriteDone());
//         } else {
//           emit(QuestionFavouriteLoading());
//         }
//       }).catchError((error) {
//         if (kDebugMode) {
//           print(error.toString());
//         }
//         emit(QuestionFavouriteError());
//       });
//     }
//   }

//   void getQuestionFavourite2(List id, QuestionFavourite) {
//     print(id);

//     for (var element in id) {
//       emit(QuestionFavouriteLoading());
//       DioHelper.postData(
//           url: 'QuestionFavourite2/getQuestionFavourites',
//           query: {},
//           data: {
//             "TYPE_ID": element,
//             "QuestionFavouriteS_COUNT": QuestionFavourite
//           }).then((value) {
//         if (value == null || value.statusCode != 200) {
//           emit(QuestionFavouriteError());
//           return;
//         }
//         if (value.data['QuestionFavourite'] != []) {
//           QuestionFavourites.addAll(value.data['QuestionFavourites']
//               .map<FavouriteModel>((e) => FavouriteModel.fromJson(e))
//               .toList());

//           QuestionFavourites.forEach((element) {
//             element.rand();
//           });
//         }

//         if (QuestionFavourites.length > 0) {
//           emit(QuestionFavouriteDone());
//         } else {
//           emit(QuestionFavouriteLoading());
//         }
//       }).catchError((error) {
//         if (kDebugMode) {
//           print(error.toString());
//         }
//         emit(QuestionFavouriteError());
//       });
//     }
//   }

//   void addExam() async {
//     int correct = 0;
//     int incorrect = 0;
//     answers.forEach((key, value) {
//       if (value.isCorrect == 1) {
//         correct++;
//       } else {
//         incorrect++;
//       }
//     });
//     var token = await CacheHelper.getData(key: 'api_token');

//     DioHelper.postData(url: 'exam/addExam', query: {}, data: {
//       "CATEGORY_NAME": "اسئلة صعبة",
//       "TOKEN": token,
//       "CORRECTED_ANSWERS": correct,
//       "INCORRECTED_ANSWERS": incorrect,
//     }).then((value) {
//       print(value);

//       if (value == null || value.statusCode != 200) {
//         emit(ExamError());
//         return;
//       }
//     }).catchError((error) {
//       if (kDebugMode) {
//         print(error.toString());
//       }
//       emit(ExamError());
//     });
//   }
// }
