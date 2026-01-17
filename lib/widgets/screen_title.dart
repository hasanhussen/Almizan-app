import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class ScreenTitle extends StatelessWidget {
  final String text;

  const ScreenTitle({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) {
    return
    Align(
      alignment: Alignment.center,
      child: Text(
        text,
        style:  TextStyle(
          fontSize: 18.sp,
        ),
      ),
    );});
  }
}
