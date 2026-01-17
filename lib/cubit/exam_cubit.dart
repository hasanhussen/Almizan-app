// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:almizan/general/color.dart';
// import 'package:almizan/models/exam.dart';
// import 'package:almizan/services/cache_helper.dart';
// import 'package:almizan/services/dio_helper.dart';
// import 'package:almizan/state/exam_state.dart';
// import 'package:http/http.dart' as http;

// class ExamCubit extends Cubit<ExamState> {
//   ExamCubit() : super(ExamInitial());

//   static ExamCubit get(context) => BlocProvider.of(context);

//   List<Exams> categories = [];

//   List<Exams> exam = [];
//   void getExam() async {
//     var token = await CacheHelper.getData(key: 'api_token');
//     print(token);
//     emit(ExamLoading());
//     DioHelper.postData(url: 'exam/getExamByUser', query: {}, data: {
//       "TOKEN": token,
//     }).then((value) {
//       print(value);

//       if (value == null || value.statusCode != 200) {
//         emit(ExamError());
//         return;
//       }
//       categories =
//           value.data['exams'].map<Exams>((e) => Exams.fromJson(e)).toList();
//       exam = categories.reversed.toList();
//       emit(ExamDone());
//     }).catchError((error) {
//       if (kDebugMode) {
//         print(error.toString());
//       }
//       emit(ExamError());
//     });
//   }

//   Future<void> deleteExam(int id) async {
//     var myUrl = Uri.parse("https://dierocket.com/public/api/exam/deleteExam");

//     final response = await http.post(myUrl, body: {
//       'ID': id.toString(),
//       'APP_TOKEN': CacheHelper.getData(key: 'api_token'),
//     });
//     if (response.statusCode == 200) {
//       Fluttertoast.showToast(
//         msg: "تم حذف الامتحان بنجاح",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.SNACKBAR,
//         timeInSecForIosWeb: 1,
//         backgroundColor: primary,
//         textColor: Colors.white,
//         fontSize: 13,
//       );
//       getExam();
//     } else {
//       emit(ExamError());
//     }
//   }
// }
