import 'package:flutter/material.dart';
import 'package:almizan/cubit/question_cubit.dart';
import 'package:almizan/general/constant.dart';

import '../general/color.dart';

class FinishTraining extends StatelessWidget {
  final int? correct;
  final int? wrong;
  final QuestionCubit trainingCubit;
  const FinishTraining(
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
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
            SizedBox(
              height: 10,
            ),
            Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/img/golden.png",
                  width: 150,
                )),
            SizedBox(
              height: 10,
            ),
            Image.asset(
              'assets/img/con1.gif',
              height: 100,
            ),
            SizedBox(
              height: 10,
            ),
            const Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                'تهانينا',
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
              textDirection: TextDirection.rtl,
              child: Text(
                'لقد اجتزت الامتحان بنجاح! ',
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: 'Tajawal',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            const Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                'نحن فخورون بك ونتطلع إلى مزيد',
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: 'Tajawal',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            const Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                ' من الإنجازات المستقبلية',
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: 'Tajawal',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            SizedBox(
              height: 150,
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
              child: Text(
                ' إظهار النتيجة',
                style: TextStyle(fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
