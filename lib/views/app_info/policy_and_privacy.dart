import 'package:almizan/cubit/policy_cubit.dart';
import 'package:almizan/general/color.dart';
import 'package:almizan/widgets/policy_content%20.dart';
import 'package:almizan/widgets/policy_header%20.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PolicyAndPrivacy extends StatelessWidget {
  const PolicyAndPrivacy({Key? key}) : super(key: key);

  static const String fallbackTitle = 'سياسة الخصوصية';
  static const String fallbackBody = 'نص سياسة الخصوصية غير متوفر حالياً';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PolicyCubit()..fetchPolicy(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          title: Image.asset("assets/img/golden.png", width: 150),
          centerTitle: true,
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Stack(
            children: [
              PolicyHeader(),
              PolicyContent(),
            ],
          ),
        ),
      ),
    );
  }
}
