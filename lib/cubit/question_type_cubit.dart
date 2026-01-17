import 'package:almizan/general/color.dart';
import 'package:almizan/general/end_points.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almizan/models/subjects.dart';
import 'package:almizan/services/cache_helper.dart';
import 'package:almizan/services/dio_helper.dart';
import 'package:almizan/state/question_type_state.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../views/quiz/quiz_page.dart';

class QuestionTypeCubit extends Cubit<QuestionTypeState> {
  static late QuestionTypeCubit instance;
  QuestionTypeCubit() : super(QuestionTypeInitial()) {
    instance = this;
  }

  static QuestionTypeCubit get(context) => BlocProvider.of(context);

  List<Subject> subjects = [];
  List imgList = [];
  bool codeValid = false;
  int selectedIndex = 0;

  String? whatsapp;

  bool isActive = false;

  void emitError(String message) {
    emit(QuestionTypeError(message: message));
  }

  selectSubject(id, examid, subname, BuildContext context) {
    selectedIndex = id;
    isActive = false;
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return QuizPage(
        examid: examid,
        subname: subname,
      );
    }));
    emit(QuestionTypeDone());
  }

  void getSlider() {
    DioHelper.getData(
            url: '$serverUrl/getSlider',
            token: CacheHelper.getData(key: 'api_token'))
        .then((value) {
      print("getSlider = ${value?.data}");
      if (value != null && value.statusCode == 200) {
        imgList = value.data['sliders'] ?? [];
        emit(QuestionTypeDone()); // بدون emit Loading مرة ثانية
      }
    }).catchError((error) {
      print(error);
    });
  }

  void getSubject() {
    isActive = true;
    emit(QuestionTypeLoading());

    DioHelper.getData(
            url: '$serverUrl/subjects',
            token: CacheHelper.getData(key: 'api_token'))
        .then((value) {
      print("getSubject = ${value?.data}");
      if (value == null || value.statusCode != 200) {
        print('value is null');
        emit(QuestionTypeError());
        return;
      }
      subjects =
          (value.data['subjects'] != null || value.data['subjects'] != [])
              ? value.data['subjects']
                  .map<Subject>((e) => Subject.fromJson(e))
                  .toList()
              : [];
      whatsapp = value.data['whatsapp'];
      print(subjects);
      getSlider();
      // emit(QuestionTypeDone());
    }).catchError((error) {
      print('catchvalue is null');
      print(error);
      if (kDebugMode) {
        print(error.toString());
      }
      emit(QuestionTypeError());
    });
  }

  Future<bool> checkExamCode(String code, int examId, id, examid, subname,
      BuildContext context) async {
    emit(QuestionTypeLoading());
    DioHelper.postData(
      url: '$serverUrl/checkCode',
      token: CacheHelper.getData(key: 'api_token'),
      data: {
        'exam_id': examId,
        'code': code,
      },
    ).then((value) {
      print(value?.data);
      if (value == null || value.statusCode != 200) {
        print('value is null');
        emit(QuestionTypeError());
        return;
      }

      codeValid = value.data['valid'];
      print(codeValid);
      if (codeValid) {
        selectSubject(id, examid, subname, context);
        // emit(QuestionTypeDone());
      } else {
        emitError(value.data['message'] ?? 'الكود غير صحيح');
      }
    }).catchError((error) {
      print('catchvalue is null');
      print(error);
      if (kDebugMode) {
        print(error.toString());
      }
      emit(QuestionTypeError());
    });
    return codeValid;
  }

  void logout({Function? onSuccess}) {
    String? fcmToken = CacheHelper.getData(key: "fcm_token");

    DioHelper.postData(url: '$serverUrl/logout', data: {
      'fcm_token': fcmToken,
    }).then((value) {
      // مسح بيانات المستخدم من الكاش
      CacheHelper.removeData(key: 'api_token');
      CacheHelper.removeData(key: 'fcm_token');
      CacheHelper.removeData(key: 'name');
      CacheHelper.removeData(key: 'email');
      CacheHelper.removeData(key: 'year');
      CacheHelper.removeData(key: 'studentId');
      CacheHelper.removeData(key: 'registered');
      CacheHelper.removeData(key: 'image');

      CacheHelper.clearData();

      Fluttertoast.showToast(
        msg: "تم تسجيل الخروج بنجاح",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: primary,
        textColor: Colors.white,
        fontSize: 14,
      );

      if (onSuccess != null) onSuccess();
    }).catchError((error) {
      debugPrint(error.toString());
      Fluttertoast.showToast(
        msg: "حدث خطأ أثناء تسجيل الخروج",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14,
      );
    });
  }
}
