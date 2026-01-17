import 'package:almizan/general/end_points.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:almizan/models/user.dart';
import 'package:almizan/state/login_state.dart';
import 'package:almizan/services/cache_helper.dart';
import 'package:almizan/services/dio_helper.dart';
import 'package:almizan/views/favourite/favourite.dart';

import '../views/choose_subject.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  var formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late User user;

  void userLogin(context) async {
    String? fcm_token = await FirebaseMessaging.instance.getToken();
    if (userNameController.text.trim().isEmpty) {
      emit(LoginErrorState(error: 'اسم المستخدم مطلوب'));
      return;
    }
    if (passwordController.text.trim().isEmpty) {
      emit(LoginErrorState(error: 'كلمة المرور مطلوبة'));
      return;
    }

    emit(LoginLoadingState());
    DioHelper.postDataWithoutToken(url: '$serverUrl/login', data: {
      'email': userNameController.text.trim(),
      'password': passwordController.text.trim(),
      'fcm_token': fcm_token
    }).then((value) {
      if (value != null && value.statusCode == 200) {
        user = User.fromJson(value!.data['user']);

        CacheHelper.replaceData(key: 'name', value: user.name);
        CacheHelper.replaceData(key: 'email', value: user.email);
        CacheHelper.replaceData(key: 'api_token', value: user.apiToken);
        CacheHelper.replaceData(key: 'fcm_token', value: fcm_token);

        debugPrint(value.statusMessage);

        emit(LoginSuccessState(user: user));

        Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.leftToRight,
                child: ChooseSubject(),
                duration: const Duration(microseconds: 800)));
      } else {
        emit(LoginErrorState(error: 'اسم المستخدم أو كلمة المرور غير صحيحة'));
      }
    }).catchError((error) {
      debugPrint(error.toString());
      emit(LoginErrorState(error: 'حدث خطأ أثناء تسجيل الدخول'));
    });
  }
}
