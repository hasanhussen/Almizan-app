import 'package:almizan/general/end_points.dart';
import 'package:almizan/state/reset_password_state.dart';
import 'package:almizan/views/auth/verify_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:almizan/models/user.dart';
import 'package:almizan/state/login_state.dart';
import 'package:almizan/services/cache_helper.dart';
import 'package:almizan/services/dio_helper.dart';
import 'package:almizan/views/favourite/favourite.dart';

import '../views/choose_subject.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitialState());

  static ResetPasswordCubit get(context) => BlocProvider.of(context);

  TextEditingController emailController = TextEditingController();

  TextEditingController codeController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void sendResetCode(BuildContext context) {
    if (emailController.text.trim().isEmpty) {
      emit(ResetPasswordErrorState(error: 'الإيميل مطلوب'));
      return;
    }

    emit(ResetPasswordLoadingState());

    DioHelper.postDataWithoutToken(
      url: '$serverUrl/forgot-password',
      data: {
        'email': emailController.text.trim(),
      },
    ).then((value) {
      if (value != null && value.statusCode == 200) {
        emit(ResetPasswordCodeSentState());

        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.leftToRight,
            child: VerifyCodeScreen(email: emailController.text),
          ),
        );
      } else {
        emit(ResetPasswordErrorState(error: 'فشل إرسال الكود'));
      }
    }).catchError((error) {
      emit(ResetPasswordErrorState(error: 'حدث خطأ'));
    });
  }

  void verifyResetCode(String email) {
    final code = codeController.text.trim();

    if (code.isEmpty) {
      emit(ResetPasswordErrorState(error: "يرجى إدخال الكود"));
      return;
    }

    emit(ResetPasswordLoadingState());

    // مثال اتصال بالباك باستخدام Dio
    DioHelper.postDataWithoutToken(
      url: '$serverUrl/verify-code',
      data: {
        'email': email,
        'code': code,
      },
    ).then((value) {
      if (value?.statusCode == 200 && value?.data['status'] == "success") {
        emit(ResetPasswordCodeVerifiedState());
      } else {
        print('الكود غير صحيح');
        emit(ResetPasswordErrorState(error: 'الكود غير صحيح'));
      }
    }).catchError((e) {
      print('حدث خطأ حاول لاحقاً');
      emit(ResetPasswordErrorState(error: 'حدث خطأ حاول لاحقاً'));
    });
  }

  void resetPassword(String email) {
    final newPass = newPasswordController.text.trim();
    final confirmPass = confirmPasswordController.text.trim();

    if (newPass.isEmpty || confirmPass.isEmpty) {
      emit(ResetPasswordErrorState(error: 'يرجى ملء الحقول'));
      return;
    }

    if (newPass != confirmPass) {
      emit(ResetPasswordErrorState(error: 'كلمتا المرور غير متطابقتين'));
      return;
    }

    emit(ResetPasswordLoadingState());

    DioHelper.postDataWithoutToken(
      url: '$serverUrl/reset-password',
      data: {
        'email': email,
        'password': newPass,
        'password_confirmation': confirmPass,
      },
    ).then((value) {
      if (value?.statusCode == 200 && value?.data['status'] == "success") {
        emit(ResetPasswordChangedState());
      } else {
        emit(ResetPasswordErrorState(error: 'فشل تغيير كلمة المرور'));
      }
    }).catchError((e) {
      emit(ResetPasswordErrorState(error: 'حدث خطأ حاول لاحقاً'));
    });
  }
}
