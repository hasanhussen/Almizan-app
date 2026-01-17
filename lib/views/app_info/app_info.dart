import 'package:almizan/cubit/appInfo_cubit.dart';
import 'package:almizan/widgets/app_info_background_header.dart';
import 'package:almizan/widgets/app_info_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:almizan/general/color.dart';
import 'package:almizan/views/app_info/policy_and_privacy.dart';

class AppInfo extends StatelessWidget {
  const AppInfo({Key? key}) : super(key: key);

  static const String fallbackText = """
مركز خاص بإشراف وزارة الاقتصاد

مرخص بموجب القرار رقم (3070) تاريخ 27-12-2010 الصادر عن وزارة الاقتصاد

هو مركز مختص بتعليم العلوم الاقتصاد  
""";

  static const String fallbackNote = """
لا يجوز استخدام أي مادة من مواد هذا التطبيق او نسخها او نقلها او استخدامها كلياً او جزئياً
في اي شكل وبأي وسيلة دون الحصول على إذن خطي من صاحب التطبيق
""";

  static const String fallbackInstagram =
      'https://www.instagram.com/almizan_center_tartous/';
  static const String fallbackFacebook =
      'https://www.facebook.com/share/15ZfL4EWeX/';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        AppInfoCubit cubit = AppInfoCubit();
        cubit.fetchAppInfo();
        return cubit;
      },
      // create: (_) => AppInfoCubit()..fetchAppInfo(),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Spacer(),
              Image.asset("assets/img/golden.png", width: 150),
              const Spacer(),
            ],
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: primary,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Stack(
            children: [
              BackgroundHeader(),
              Content(),
            ],
          ),
        ),
      ),
    );
  }
}
