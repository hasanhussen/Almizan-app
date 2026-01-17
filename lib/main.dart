import 'package:almizan/services/lifecycle_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almizan/services/cache_helper.dart';
import 'package:almizan/services/dio_helper.dart';
import 'package:almizan/views/splash.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cubit/bloc_observer.dart';
import 'general/color.dart';

// ========== دالة معالجة الإشعارات في الخلفية ==========
// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   final prefs = await SharedPreferences.getInstance();

//   if (message.data['type'] == "exam_started") {
//     await prefs.setBool('needs_refresh', true);
//     print('📱 تم تعيين needs_refresh = true');
//   }

//   if (message.data['type'] == "exam_ended") {
//     await prefs.setString('ended_exam_id', message.data['exam_id'] ?? '');
//     print('📱 تم تعيين ended_exam_id = ${message.data['exam_id']}');
//   }
// }

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: primary,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp();

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //secure();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Almizan',
        theme: ThemeData(
          fontFamily: "Tajawal",
          colorScheme: ColorScheme.fromSeed(seedColor: blue),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const Splash());
  }
}
