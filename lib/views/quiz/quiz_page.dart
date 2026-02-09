import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almizan/cubit/question_cubit.dart';
import 'package:almizan/general/color.dart';
import 'package:almizan/state/question_state.dart';
import 'package:almizan/views/quiz/final_view.dart';
import 'package:almizan/widgets/awnser_widget.dart';
import 'package:almizan/widgets/fail_training.dart';
import 'package:almizan/widgets/finish_training.dart';

import '../../core/core.dart';

class QuizPage extends StatelessWidget {
  final int? examid;
  final String? subname;

  QuizPage({
    super.key,
    this.examid,
    this.subname,
  });

  final TextStyle _questionStyle = const TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.black);

  final GlobalKey<ScaffoldState> _key =
      GlobalKey<ScaffoldState>(); // تأكد من تحويلها إلى int
  String formatTime(int second) {
    int seconds = second;
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  String formatTime2(int second, int duration) {
    int seconds = duration - second;
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (BuildContext context) {
        QuestionCubit cubit = QuestionCubit();
        cubit.getmyQuestion(examid!, context);
        return cubit;
      },
      child: BlocConsumer<QuestionCubit, QuestionState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is TrainingReport) {
              return Container(
                  height: height,
                  width: width,
                  color: Colors.white,
                  child: Column(children: [
                    Expanded(
                        child: FinalView(
                      numberOfQuestion:
                          QuestionCubit.get(context).questions.length!,
                      trainingCubit: QuestionCubit.get(context),
                      examid: examid!,
                    )),
                  ]));
            }
            if (state is TrainingFinish) {
              return Container(
                height: height,
                width: width,
                color: Colors.white,
                child: Column(
                  children: [
                    Expanded(
                      child: FinishTraining(
                        trainingCubit: QuestionCubit.get(context),
                        wrong: 0,
                        correct: 0,
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state is TrainingFail) {
              return Container(
                height: height,
                width: width,
                color: Colors.white,
                child: Column(
                  children: [
                    Expanded(
                      child: FailTraining(
                        trainingCubit: QuestionCubit.get(context),
                        wrong: 0,
                        correct: 0,
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state is QuestionDone) {
              return WillPopScope(
                onWillPop: () async {
                  // إظهار حوار التأكيد
                  return await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('تأكيد مغادرة الامتحان'),
                          content: const Text(
                              'هل أنت متأكد أنك تريد مغادرة الامتحان؟'),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.of(context).pop(false), // لا تغادر
                              child: const Text('لا'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              }, // اغادر
                              child: const Text('نعم'),
                            ),
                          ],
                        ),
                      ) ??
                      false; // تأكد من أن القيمة الافتراضية هي false
                },
                child: Scaffold(
                  key: _key,
                  appBar: AppBar(
                    iconTheme: IconThemeData(
                      color: Colors.white, // Set your desired color here
                    ),
                    title: Text(
                      subname!,
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: primary,
                    actions: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          formatTime2(
                            QuestionCubit.get(context).remainingSeconds,
                            QuestionCubit.get(context).duration!,
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                    elevation: 0,
                  ),
                  body: Container(
                    height: height,
                    child: SingleChildScrollView(
                      child: Column(children: <Widget>[
                        Container(
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
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Queston ${QuestionCubit.get(context).currentIndex + 1} of ${QuestionCubit.get(context).questions.length}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    " Question ID:${QuestionCubit.get(context).questions[QuestionCubit.get(context).currentIndex].id}",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 16),
                                  child: Text(
                                    QuestionCubit.get(context)
                                        .questions[QuestionCubit.get(context)
                                            .currentIndex]
                                        .questionText!,
                                    style: AppTextStyles.heading,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 10, left: 8, right: 8, bottom: 8),
                                child: SizedBox(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                for (var i = 0;
                                                    i <
                                                        QuestionCubit.get(
                                                                context)
                                                            .questions[
                                                                QuestionCubit.get(
                                                                        context)
                                                                    .currentIndex]
                                                            .answers!
                                                            .length;
                                                    i++)
                                                  AwnserWidget(
                                                    isSubmited: QuestionCubit
                                                            .get(context)
                                                        .questions[
                                                            QuestionCubit.get(
                                                                    context)
                                                                .currentIndex]
                                                        .isSubmited,
                                                    awnser: QuestionCubit.get(
                                                            context)
                                                        .questions[
                                                            QuestionCubit.get(
                                                                    context)
                                                                .currentIndex]
                                                        .answers![i],
                                                    disabled: QuestionCubit.get(
                                                                context)
                                                            .questions[
                                                                QuestionCubit.get(
                                                                        context)
                                                                    .currentIndex]
                                                            .isSubmited
                                                        ? QuestionCubit.get(
                                                                        context)
                                                                    .answers[
                                                                QuestionCubit.get(
                                                                        context)
                                                                    .currentIndex] !=
                                                            null
                                                        : false,
                                                    isSelected: QuestionCubit
                                                                    .get(context)
                                                                .answers[
                                                            QuestionCubit.get(
                                                                    context)
                                                                .currentIndex] ==
                                                        QuestionCubit.get(
                                                                context)
                                                            .questions[
                                                                QuestionCubit.get(
                                                                        context)
                                                                    .currentIndex]
                                                            .answers![i],
                                                    onTap: QuestionCubit.get(
                                                                context)
                                                            .questions[
                                                                QuestionCubit.get(
                                                                        context)
                                                                    .currentIndex]
                                                            .isSubmited
                                                        ? (value) {}
                                                        : (value) {
                                                            //widget.onSelected(value);
                                                            QuestionCubit.get(context).addAnswer(
                                                                QuestionCubit.get(
                                                                            context)
                                                                        .questions[QuestionCubit.get(context)
                                                                            .currentIndex]
                                                                        .answers![
                                                                    i],
                                                                QuestionCubit.get(
                                                                        context)
                                                                    .questions[QuestionCubit.get(
                                                                            context)
                                                                        .currentIndex]
                                                                    .id,
                                                                context);
                                                          },
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(top: 10),
                                          alignment: Alignment.bottomCenter,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              if (QuestionCubit.get(context)
                                                      .currentIndex >
                                                  0)
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0)),
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                  ),
                                                  onPressed: () {
                                                    QuestionCubit.get(context)
                                                        .back(context);
                                                  },
                                                  child: const Text("Back"),
                                                ),
                                              if (!QuestionCubit.get(context)
                                                  .questions[
                                                      QuestionCubit.get(context)
                                                          .currentIndex]
                                                  .isSubmited)
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0)),
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                  ),
                                                  onPressed: () {
                                                    QuestionCubit.get(context)
                                                        .submit();
                                                  },
                                                  child: const Text("Submit"),
                                                ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0)),
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .primaryColor,
                                                ),
                                                onPressed: () {
                                                  QuestionCubit.get(context)
                                                      .nextSubmit(context);
                                                },
                                                child: Text(
                                                    QuestionCubit.get(context)
                                                                .currentIndex ==
                                                            (QuestionCubit.get(
                                                                        context)
                                                                    .questions
                                                                    .length -
                                                                1)
                                                        ? "Finish"
                                                        : "Next"),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                  drawer: Drawer(
                    child: Column(
                      children: [
                        Container(
                          color: primary,
                          height: 150,
                          width: double.infinity,
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/img/logo_app.png",
                                height: 100,
                              ),
                              const Text(
                                "Questions",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontFamily: 'Tajawal',
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: height - 150,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  QuestionCubit.get(context).questions.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    QuestionCubit.get(context)
                                        .changeIndex(index);
                                  },
                                  child: ListTile(
                                      trailing: QuestionCubit.get(context)
                                              .questions[index]
                                              .isMark
                                          ? const Icon(
                                              Icons.flag,
                                              color: Colors.red,
                                            )
                                          : const Text(""),
                                      leading: QuestionCubit.get(context)
                                              .questions[index]
                                              .isSubmited
                                          ? QuestionCubit.get(context)
                                                      .questions[index]
                                                      .isAnswered ==
                                                  0
                                              ? Text("")
                                              : QuestionCubit.get(context)
                                                          .questions[index]
                                                          .isAnswered ==
                                                      1
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
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            return Container();
          }),
    );
  }
}
