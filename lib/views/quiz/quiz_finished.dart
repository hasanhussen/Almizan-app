
import 'package:almizan/models/answer.dart';
import 'package:almizan/views/choose_subject.dart';
import 'package:flutter/material.dart';
import 'package:almizan/general/color.dart';
import 'package:almizan/general/constant.dart';
import 'package:almizan/models/question_model.dart';
import 'package:almizan/views/quiz/check_answer.dart';

class QuizFinishedPage extends StatelessWidget {
  final List<QuestionModel> questions;
  final Map<int, Answers> answers;
  final double totalMarks;
  final int? noQuestion;
  const QuizFinishedPage(
      {Key? key,
      required this.questions,
      required this.answers,
      required this.totalMarks,
      this.noQuestion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int correct = 0;
    int unAnswerd = 0;
    answers.forEach((index, value) {
      if (value.isCorrect == 1) {
        correct++;
      }
    });
    questions.forEach((element) {
      if (element.isAnswered == 0) {
        unAnswerd++;
      }
    });

    TextStyle titleStyle =
        TextStyle(color: DarkBlue, fontSize: 16.0, fontWeight: FontWeight.w500);
    final TextStyle trailingStyle = TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 20.0,
        fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'النتيجة',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/img/bg.jpg",
              ),
              fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text("عدد الأسئلة", style: titleStyle),
                  trailing: Text("${questions.length}", style: trailingStyle),
                ),
              ),
              const SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text("النتيجة", style: titleStyle),
                  trailing: Text("$totalMarks", style: trailingStyle),
                ),
              ),
              const SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text("الإجابات الصحيحة", style: titleStyle),
                  trailing: Text("$correct/${questions.length}",
                      style: trailingStyle),
                ),
              ),
              const SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text("الإجابات الخاطئة", style: titleStyle),
                  trailing: Text(
                      "${questions.length - correct}/${questions.length}",
                      style: trailingStyle),
                ),
              ),
              const SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text("لم تتم الإجابة", style: titleStyle),
                  trailing: Text("$unAnswerd", style: trailingStyle),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 20.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      backgroundColor: Colors.grey.withOpacity(0.8),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("عودة للرئيسية"),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ChooseSubject()), // الصفحة الهدف
                        (Route<dynamic> route) =>
                            false, // حذف كل الصفحات السابقة
                      );
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 20.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      backgroundColor: Colors.deepPurple.withOpacity(0.8),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("عرض الإجابات"),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => CheckAnswersPage(
                                questions: questions,
                                answers: answers,
                                noQustion: noQuestion,
                              )));
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
