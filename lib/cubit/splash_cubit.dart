import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:page_transition/page_transition.dart';
import 'package:almizan/services/cache_helper.dart';
import 'package:almizan/state/splash_state.dart';
import 'package:almizan/views/app_info/onBoarding.dart';


class SplashCubit extends Cubit<SplashState> {
  double visibleImage = 0;
  int visibleText = 0;

  static SplashCubit get(context) => BlocProvider.of(context);

  SplashCubit() : super(SplashInitial());

  void startApp(BuildContext context) async {
    emit(SplashStart());

    Future.delayed(const Duration(seconds: 4)).then((value) async {
      emit(SplashIsDone());
      var token = await CacheHelper.getData(key: 'api_token');
      var isNew = await CacheHelper.getData(key: 'isNew');

      Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.leftToRight,
              child: const IntroTwoPage(),
              duration: const Duration(microseconds: 800)));
    });
  }
}
