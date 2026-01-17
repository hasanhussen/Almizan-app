import 'package:almizan/general/end_points.dart';
import 'package:almizan/models/policy_model.dart';
import 'package:almizan/services/cache_helper.dart';
import 'package:almizan/services/dio_helper.dart';
import 'package:almizan/state/policy_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

class PolicyCubit extends Cubit<PolicyState> {
  PolicyCubit() : super(PolicyInitial());

  static PolicyCubit get(context) => BlocProvider.of(context);

  String title = 'سياسة الخصوصية';
  String body = 'نص سياسة الخصوصية غير متوفر حالياً';

  void fetchPolicy() {
    emit(PolicyLoading());
    String? token = CacheHelper.getData(key: "api_token");
    DioHelper.getData(url: '$serverUrl/policy', token: token).then((value) {
      title = value?.data['title'] ?? '';
      body = value?.data['body'] ?? '';
      emit(PolicyLoaded());
    }).catchError((error) {
      emit(PolicyError());
    });
  }
}
