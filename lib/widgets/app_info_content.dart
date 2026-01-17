import 'package:almizan/cubit/appInfo_cubit.dart';
import 'package:almizan/general/color.dart';
import 'package:almizan/state/about_us_state.dart';
import 'package:almizan/views/app_info/app_info.dart';
import 'package:almizan/views/app_info/policy_and_privacy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 145),
      width: double.infinity,
      child: SingleChildScrollView(
        child: BlocBuilder<AppInfoCubit, AppInfoState>(
          builder: (context, state) {
            String? text = AppInfo.fallbackText;
            String? note = AppInfo.fallbackNote;
            String? instagram = AppInfo.fallbackInstagram;
            String? facebook = AppInfo.fallbackFacebook;

            // 🟡 حالة التحميل
            if (state is AppInfoLoading) {
              return const Padding(
                padding: EdgeInsets.only(top: 100),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            // 🔴 حالة الخطأ
            if (state is AppInfoError) {
              return Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        color: Colors.red, size: 50),
                    const SizedBox(height: 12),
                    const Text(
                      'حدث خطأ أثناء تحميل المعلومات',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Tajawal',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        AppInfoCubit.get(context).fetchAppInfo();
                      },
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              );
            }

            if (state is AppInfoLoaded) {
              text = AppInfoCubit.get(context).text!.isNotEmpty
                  ? AppInfoCubit.get(context).text
                  : AppInfo.fallbackText;

              note = AppInfoCubit.get(context).note!.isNotEmpty
                  ? AppInfoCubit.get(context).note
                  : AppInfo.fallbackNote;

              instagram = AppInfoCubit.get(context).instagram!.isNotEmpty
                  ? AppInfoCubit.get(context).instagram
                  : AppInfo.fallbackInstagram;

              facebook = AppInfoCubit.get(context).facebook!.isNotEmpty
                  ? AppInfoCubit.get(context).facebook
                  : AppInfo.fallbackFacebook;
            }

            return Column(
              children: [
                Image.asset("assets/img/logo_app.png", height: 100),
                Image.asset("assets/img/golden.png",
                    color: primary, width: 150),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: const PolicyAndPrivacy(),
                        duration: const Duration(milliseconds: 800),
                      ),
                    );
                  },
                  child: Text(
                    text!,
                    style: TextStyle(
                      fontSize: 16,
                      color: primary,
                      fontFamily: 'Tajawal',
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "في حال وجود اي مشكلة تقنية الرجاء التواصل مع الدعم الفني",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontFamily: 'Tajawal',
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Text(
                  note!,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontFamily: 'Tajawal',
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Text(
                  'روابط التواصل الاجتماعي:',
                  style: TextStyle(
                    fontSize: 18,
                    color: primary,
                    fontFamily: 'Tajawal',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Image.asset(
                        'assets/icons/Instagram.png',
                        width: 40,
                        height: 40,
                        fit: BoxFit.contain,
                      ),
                      onPressed: () => launchUrl(Uri.parse(instagram!)),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: Image.asset(
                        'assets/icons/facebook.png',
                        width: 40,
                        height: 40,
                        fit: BoxFit.contain,
                      ),
                      onPressed: () => launchUrl(Uri.parse(facebook!)),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            );
          },
        ),
      ),
    );
  }
}
