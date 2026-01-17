import 'package:flutter/material.dart';
import 'package:almizan/cubit/question_cubit.dart';
import 'package:almizan/models/question_model.dart';

class CheckPage extends StatelessWidget {
  final List<QuestionModel> questions;
  final Map<int, dynamic> answers;
  final int? noQustion;
  final QuestionCubit trainingCubit;

  const CheckPage(
      {Key? key,
      required this.questions,
      required this.trainingCubit,
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
                height: MediaQuery.of(context).size.height * 0.75,
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
                  Navigator.of(context).pop();
                },
              )
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
                        height: 80,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "مراجعة الأجوبة",
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
              SizedBox(
                height: 110,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    if (index == questions.length + 1) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
        ),
        child: const Text("Done"),
        onPressed: () {
          Navigator.of(context).pop();
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
        ? answers[index].isCorrect == 1
            ? true
            : false
        : false;
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        trainingCubit.changeIndex(index);
      },
      child: ListTile(
          trailing: questions[index].isMark
              ? const Icon(
                  Icons.flag,
                  color: Colors.red,
                )
              : const Text(""),
          leading: questions[index].isSubmited
              ? questions[index].isAnswered == 0
                  ? Text("")
                  : questions[index].isAnswered == 1
                      ? const Icon(
                          Icons.done,
                          color: Colors.green,
                        )
                      : const Icon(
                          Icons.close,
                          color: Colors.red,
                        )
              : const Text(""),
          title: Text("${index + 1}")),
    );
  }
}
