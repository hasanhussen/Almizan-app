import 'package:almizan/state/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../services/dio_helper.dart';
import '../services/cache_helper.dart';
import '../general/end_points.dart';
import '../general/color.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  // بيانات المستخدم
  String? name;
  String? email;
  String? year;
  int? studentId;
  String? registered;
  String? image;

  void profileShow() {
    emit(ProfileLoadingState());
    String? token = CacheHelper.getData(key: "api_token");
    DioHelper.getData(url: '$serverUrl/getProfile', token: token).then((value) {
      email = value?.data['email'];
      name = value?.data['name'];
      year = value?.data['year'];
      studentId = value?.data['studentId'];
      registered = value?.data['registered'];
      image = value?.data['image'];
      CacheHelper.saveData(key: 'email', value: email);
      CacheHelper.saveData(key: 'name', value: name);
      CacheHelper.saveData(key: 'year', value: year);
      CacheHelper.saveData(key: 'studentId', value: studentId);
      CacheHelper.saveData(key: 'registered', value: registered);
      CacheHelper.saveData(key: 'image', value: image);
      emit(ProfileSuccessState());
    }).catchError((error) {
      emit(ProfileErrorState(error: 'حدث خطأ أثناء تحميل الملف الشخصي'));
    });
  }

  /// دالة Logout
  void logout({Function? onSuccess}) {
    emit(ProfileLoadingState());

    String? token = CacheHelper.getData(key: "api_token");
    String? fcmToken = CacheHelper.getData(key: "fcm_token");
    if (token == null) {
      emit(ProfileErrorState(error: 'المستخدم غير مسجل الدخول'));
      return;
    }

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

      emit(ProfileSuccessState());

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
      emit(ProfileErrorState(error: ''));
    });
  }
}
