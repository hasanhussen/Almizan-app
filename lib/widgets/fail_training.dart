import 'package:flutter/material.dart';
import 'package:almizan/cubit/question_cubit.dart';
import 'package:almizan/general/constant.dart';

import '../general/color.dart';

class FailTraining extends StatelessWidget {
  final int? correct;
  final int? wrong;
  final QuestionCubit trainingCubit;
  const FailTraining(
      {Key? key, this.correct, this.wrong, required this.trainingCubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              "assets/img/bg.jpg",
            ),
            fit: BoxFit.cover),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        ////////////////////////////////////////////////////////////////mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 80,
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/img/logo_app.png",
              width: 100,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/img/golden.png",
                width: 150,
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.12,
          ),
          const Directionality(
            textDirection: TextDirection.ltr,
            child: Text(
              'لا تيأس',
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: 'Tajawal',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          const Directionality(
            textDirection: TextDirection.ltr,
            child: Text(
              'للأسف لم تجتز الامتحان هذه المرة ',
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: 'Tajawal',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          const Directionality(
            textDirection: TextDirection.ltr,
            child: Text(
              ' استمر في العمل بجد وستحقق النجاح قريبًا',
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: 'Tajawal',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          SizedBox(
            height: 180,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              backgroundColor: Colors.white,
              minimumSize:
                  Size(double.infinity, 50), // جعل الزر مستطيلًا طويلًا
            ),
            onPressed: () {
              trainingCubit.update(context);
              // Navigator.of(context).pop();
            },
            child: const Text(
              'إظهار النتيجة ',
              style: TextStyle(fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }
}
