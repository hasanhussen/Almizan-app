import 'package:flutter/material.dart';
import 'package:almizan/cubit/question_cubit.dart';
import 'package:almizan/general/color.dart';
import 'package:almizan/general/constant.dart';
import 'package:almizan/views/quiz/report.dart';

class FinalView extends StatelessWidget {
  final int numberOfQuestion;
  final int examid;
  final QuestionCubit trainingCubit;
  const FinalView(
      {Key? key,
      required this.numberOfQuestion,
      required this.trainingCubit,
      required this.examid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          trainingCubit.ba();
          Future<bool> s = trainingCubit.ba() as Future<bool>;

          return s;
        },
        child: Container(
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
                height: 50,
              ),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/img/logo_app.png",
                  width: 110,
                ),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/img/golden.png",
                    width: 130,
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.19,
              ),
              Column(
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly, // توزيع المساحة بالتساوي
                crossAxisAlignment:
                    CrossAxisAlignment.stretch, // جعل الأزرار تمتد عبر العرض
                children: [
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
                      QuestionCubit.get(context).finish(examid);
                    },
                    child: const Text(
                      "إنهاء الامتحان",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
                      var questions = trainingCubit.questions;
                      var answers = trainingCubit.answers;
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40),
                                bottomLeft: Radius.circular(40),
                              ),
                            ),
                            elevation: 8.0,
                            child: CheckPage(
                              trainingCubit: trainingCubit,
                              questions: questions,
                              answers: answers,
                              noQustion: numberOfQuestion,
                            ),
                          );
                        },
                      );
                    },
                    child: const Text("مراجعة الإجابات",
                        style: TextStyle(fontSize: 17)),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
