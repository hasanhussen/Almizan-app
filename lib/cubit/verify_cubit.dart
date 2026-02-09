
import 'package:almizan/general/color.dart';
import 'package:almizan/models/user.dart';
import 'package:almizan/services/cache_helper.dart';
import 'package:almizan/services/dio_helper.dart';
import 'package:almizan/state/verify_state.dart';
import 'package:almizan/views/choose_subject.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

enum RadioButtonOption {
  ok,
  decline;
}

class RegisterCubit extends Cubit<VerifyState> {
  RegisterCubit() : super(VerifyInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  late User user;

  late String selectedCity;
  bool accept = false;

  var formKey = GlobalKey<FormState>();

  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  void userRegister(BuildContext context) {
    emit(VerifyLoadingState());
    DioHelper.postData(url: 'account2/signup', data: {
      'EMAIL': emailController.text.trim(),
      'PASSWORD': passwordController.text.trim(),
      'USER_NAME': userNameController.text.trim(),
    }).then((value) {
      if (value!.statusCode == 200 || value.statusCode == 201) {
        print(value!.data['user']);
        user = User.fromJson(value.data['user']);
        CacheHelper.saveData(key: 'name', value: user.name);
        CacheHelper.saveData(key: 'email', value: user.email);
        CacheHelper.saveData(key: 'api_token', value: user.apiToken);
        debugPrint(value.statusMessage);
        emit(VerifySuccessState(user: user));
        Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                duration: const Duration(milliseconds: 300),
                child: ChooseSubject()));
      }
    }).catchError((error) {
      debugPrint(error.toString());
      if (error
          .toString()
          .contains("The request returned an invalid status code of 409")) {
        print(error.response.data['body']);
        if (error.response.data['body'].toString().contains(
            "Email is already exist , try using another email or re-login.")) {
          Fluttertoast.showToast(
            msg: "يرجى استخدام بريد الكتروني اخر ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: primary,
            textColor: Colors.white,
            fontSize: 13,
          );
        } else {
          Fluttertoast.showToast(
            msg: "يرجى استخدام رقم هاتف  اخر ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            backgroundColor: primary,
            textColor: Colors.white,
            fontSize: 13,
          );
        }
      }
      emit(VerifyErrorState(error: error.toString()));
    });
  }
}
