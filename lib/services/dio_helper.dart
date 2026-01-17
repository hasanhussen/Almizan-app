import 'package:dio/dio.dart';
import 'package:almizan/general/end_points.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: serverUrl,
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  static Future<Response?> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio?.options.headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    return await dio?.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response?> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    dio?.options.headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    return await dio?.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response?> postDataWithoutToken({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    return await dio?.post(
      url,
      data: data,
    );
  }
}
