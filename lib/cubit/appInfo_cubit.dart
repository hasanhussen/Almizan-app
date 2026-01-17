import 'package:almizan/general/end_points.dart';
import 'package:almizan/models/about.dart';
import 'package:almizan/services/cache_helper.dart';
import 'package:almizan/services/dio_helper.dart';
import 'package:almizan/state/about_us_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

class AppInfoCubit extends Cubit<AppInfoState> {
  AppInfoCubit() : super(AppInfoInitial());

  static AppInfoCubit get(context) => BlocProvider.of(context);

  String text = """ مركز خاص بإشراف وزارة الاقتصاد

مرخص بموجب القرار رقم (3070) تاريخ 27-12-2010 الصادر عن وزارة الاقتصاد

هو مركز مختص بتعليم العلوم الاقتصاد  
""";
  String note = """
لا يجوز استخدام أي مادة من مواد هذا التطبيق او نسخها او نقلها او استخدامها كلياً او جزئياً
في اي شكل وبأي وسيلة دون الحصول على إذن خطي من صاحب التطبيق
""";
  String instagram = 'https://www.instagram.com/almizan_center_tartous/';
  String? facebook = 'https://www.facebook.com/share/15ZfL4EWeX/';

  void fetchAppInfo() {
    emit(AppInfoLoading());
    String? token = CacheHelper.getData(key: "api_token");
    DioHelper.getData(url: '$serverUrl/appInfo', token: token).then((value) {
      text = value?.data['text'] ?? '';
      note = value?.data['note'] ?? '';
      instagram = value?.data['instagram'] ?? '';
      facebook = value?.data['facebook'] ?? '';
      emit(AppInfoLoaded());
    }).catchError((error) {
      emit(AppInfoError());
    });
  }

  // Future<void> fetchAppInfo() async {
  //   emit(AppInfoLoading());

  //   try {
  //     DioHelper.getData(
  //             url: '$serverUrl/app-info',
  //             token: CacheHelper.getData(key: 'api_token'))
  //         .then((value) {
  //       emit(AppInfoLoaded(AppInfoModel.fromJson(value?.data)));
  //     }).catchError((error) {
  //       print(error);
  //     });
  //     // final response = await dio.get('$serverUrl/app-info');
  //     // emit(AppInfoLoaded(AppInfoModel.fromJson(response.data)));
  //   } catch (e) {
  //     emit(AppInfoError());
  //   }
  // }
}
