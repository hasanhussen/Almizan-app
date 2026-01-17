import 'package:almizan/models/answer.dart';
import 'package:flutter/material.dart';
import 'package:almizan/views/choose_subject.dart';
import 'package:page_transition/page_transition.dart';
import 'package:almizan/models/question_model.dart';

class CheckAnswersPage extends StatelessWidget {
  final List<QuestionModel> questions;
  final Map<int, Answers> answers;
  final int? noQustion;
  const CheckAnswersPage(
      {Key? key,
      required this.questions,
      required this.answers,
      this.noQustion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.92,
                child: ListView.builder(
                  padding: const EdgeInsets.only(
                      top: 145, left: 16, right: 16, bottom: 16),
                  itemCount: questions.length,
                  itemBuilder: _buildItem,
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("تم"),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.leftToRight,
                            child: ChooseSubject(),
                            duration: const Duration(microseconds: 800)));
                  })
            ],
          ),
          Container(
            height: 140,
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/img/bg.jpg",
                    ),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(),
                  Column(
                    children: [
                      Image.asset(
                        "assets/img/logo_app.png",
                        height: 100,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "مقارنة الإجابات",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ],
                  ),
                  Container(),
                ],
              ),
            ),
          ),
          const Column(
            children: <Widget>[
              const SizedBox(
                height: 110,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    if (index == questions.length) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
        ),
        child: const Text("تم"),
        onPressed: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => ChooseSubject()));
        },
      );
    }

    String getAnswer(QuestionModel question) {
      String answer = "";
      for (var element in question.answers!) {
        if (element.isCorrect == 1) {
          answer = element.answerText!;
        }
      }
      return answer;
    }

    QuestionModel question = questions[index];
    bool correct = question.isAnswered != 0
        ? (answers[index]?.isCorrect) == 1
            ? true
            : false
        : false;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              question.questionText!,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0),
            ),
            const SizedBox(height: 5.0),
            questions[index].isAnswered != 0
                ? Text(
                    "${answers[index]?.answerText}",
                    style: TextStyle(
                        color: correct ? Colors.green : Colors.red,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  )
                : Text(""),
            const SizedBox(height: 5.0),
            correct
                ? Container()
                : Text.rich(
                    TextSpan(children: [
                      const TextSpan(
                          text: "الجواب: ",
                          style: TextStyle(color: Colors.green)),
                      TextSpan(
                          text: getAnswer(question),
                          style: const TextStyle(fontWeight: FontWeight.w500))
                    ]),
                    style: const TextStyle(fontSize: 16.0),
                  )
          ],
        ),
      ),
    );
  }
}
