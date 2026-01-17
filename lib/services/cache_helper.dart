import 'package:almizan/cubit/question_cubit.dart';
import 'package:almizan/cubit/question_type_cubit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    // await checkBackgroundNotifications();
    requestPermissionNotification();
    fcmConfig();
  }

  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences.get(key);
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    }
    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    }
    if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    }

    return await sharedPreferences.setDouble(key, value);
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPreferences.remove(key);
  }

  static Future<bool> replaceData({
    required String key,
    required dynamic value,
  }) async {
    return await removeData(key: key).then((val) async {
      return await sharedPreferences.setString(key, value);
    });
  }

  static Future<bool> clearData() async {
    return await sharedPreferences.clear();
  }

  static requestPermissionNotification() async {
    // ignore: unused_local_variable
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  static void fcmConfig() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("================== Notification =================");
      print(message.notification?.title);
      print(message.notification?.body);

      refreshPageNotification(message.data);
    });
  }

  static void refreshPageNotification(
    Map<String, dynamic> data,
  ) {
    if (QuestionTypeCubit.instance.isActive && data['type'] == "exam_started") {
      QuestionTypeCubit.instance.getSubject();
    }

    /// Questions
    if (QuestionCubit.instance.isExamActive && data['type'] == "exam_ended") {
      QuestionCubit.instance.finish(data['exam_id']);
    }
  }

  static Future<void> checkBackgroundNotifications() async {
    final bool needsRefresh =
        sharedPreferences.getBool('needs_refresh') ?? false;
    final String? endedExamId = sharedPreferences.getString('ended_exam_id');

print('📱needsRefresh = $needsRefresh');
print('📱 endedExamId = $endedExamId');

    if (needsRefresh) {
      // إزالة العلامة مباشرة
      await sharedPreferences.remove('needs_refresh');

      // تنفيذ الإجراء مباشرة إذا التطبيق مفتوح
      if (QuestionTypeCubit.instance.isActive) {
        QuestionTypeCubit.instance.getSubject();
      }
    }

    if (endedExamId != null && endedExamId.isNotEmpty) {
      await sharedPreferences.remove('ended_exam_id');

      if (QuestionCubit.instance.isExamActive) {
        QuestionCubit.instance.finish(endedExamId);
      }
    }
  }
}
