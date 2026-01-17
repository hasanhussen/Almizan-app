import 'package:almizan/general/end_points.dart';
import 'package:almizan/widgets/select_exam.dart';
import 'package:almizan/widgets/showExamCodeDialog.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:almizan/cubit/question_type_cubit.dart';
import 'package:almizan/general/color.dart';
import 'package:almizan/models/subjects.dart';
import 'package:almizan/models/type.dart';
import 'package:almizan/models/years.dart';
import 'package:almizan/services/cache_helper.dart';

import 'package:almizan/state/question_type_state.dart';
import 'package:almizan/views/app_info/app_info.dart';
import 'package:almizan/views/app_info/policy_and_privacy.dart';
import 'package:almizan/views/auth/login.dart';
import 'package:almizan/views/auth/profile.dart';
import 'package:almizan/views/quiz/myexam.dart';
import 'package:almizan/widgets/select_subject.dart';
import 'package:almizan/widgets/select_subject_one.dart';
import 'package:almizan/widgets/select_type.dart';
import 'package:almizan/widgets/select_year.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/question_type.dart';

class ChooseSubject extends StatelessWidget {
  const ChooseSubject({super.key});

  @override
  Widget build(BuildContext context) {
    // final List<String> imgList = [
    //   'assets/img/slide1.jpg',
    //   'assets/img/slide2.jpg',
    //   'assets/img/slide3.jpg',
    // ];
    Future<bool> _showLogoutConfirmationDialog(BuildContext context) async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("تأكيد تسجيل الخروج"),
              content: Text("هل أنت متأكد أنك تريد تسجيل الخروج؟"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false), // إلغاء
                  child: Text("لا"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true), // تأكيد
                  child: Text("نعم"),
                ),
              ],
            ),
          ) ??
          false;
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: primary,
          statusBarIconBrightness: Brightness.light,
        ),
        child: BlocProvider(
          create: (context) {
            QuestionTypeCubit cubit = QuestionTypeCubit();
            cubit.getSubject(); // هيدول بيجيبوا subjects + whatsapp مع بعض
            return cubit;
          },
          child: Scaffold(
              drawer: Builder(builder: (drawerContext) {
                return Drawer(
                  backgroundColor: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    "assets/img/bg.jpg",
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30))),
                          height: 150,
                          width: double.infinity,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 25,
                              ),
                              Image.asset(
                                "assets/img/logo_app.png",
                                height: 60,
                              ),
                              Image.asset(
                                "assets/img/golden.png",
                                color: Colors.white,
                                width: 125,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.leftToRight,
                                      child: const ProfileCard(),
                                      duration:
                                          const Duration(microseconds: 800)));
                            },
                            child: const ListTile(
                              leading: Icon(Icons.account_circle),
                              title: Text("الملف الشخصي"),
                            )),
                        const Divider(),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.leftToRight,
                                      child: const AppInfo(),
                                      duration:
                                          const Duration(microseconds: 800)));
                            },
                            child: const ListTile(
                              leading: Icon(Icons.info),
                              title: Text("من نحن"),
                            )),
                        const Divider(),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.leftToRight,
                                      child: const PolicyAndPrivacy(),
                                      duration:
                                          const Duration(microseconds: 800)));
                            },
                            child: const ListTile(
                              leading: Icon(Icons.policy),
                              title: Text("سياسة الخصوصية"),
                            )),
                        const Divider(),
                        InkWell(
                            onTap: () async {
                              final cubit =
                                  QuestionTypeCubit.get(drawerContext);
                              final whatsapp = cubit.whatsapp;
                              if (whatsapp != null && whatsapp.isNotEmpty) {
                                await launchUrl(
                                    Uri.parse('https://wa.me/$whatsapp'));
                              } else {
                                ScaffoldMessenger.of(drawerContext)
                                    .showSnackBar(
                                  const SnackBar(
                                      content: Text("رقم الدعم غير متاح")),
                                );
                              }
                            },
                            child: const ListTile(
                              leading: Icon(Icons.support_agent),
                              title: Text("الدعم الفني"),
                            )),
                        const Divider(),
                        InkWell(
                          onTap: () async {
                            // عرض نافذة التأكيد
                            bool shouldLogout =
                                await _showLogoutConfirmationDialog(
                                    drawerContext);

                            if (shouldLogout) {
                              QuestionTypeCubit.get(drawerContext).logout(
                                  onSuccess: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const Login()),
                                  (route) => false,
                                );
                              });
                              // إذا وافق المستخدم على تسجيل الخروج
                              // CacheHelper.clearData();
                              // Navigator.pushReplacement(
                              //   context,
                              //   PageTransition(
                              //     type: PageTransitionType.leftToRight,
                              //     child: const Login(),
                              //     duration: const Duration(milliseconds: 800),
                              //   ),
                              // );
                            }
                          },
                          child: const ListTile(
                            leading: Icon(Icons.exit_to_app),
                            title: Text("تسجيل خروج"),
                          ),
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                );
              }),
              body: BlocConsumer<QuestionTypeCubit, QuestionTypeState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is QuestionTypeLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.indigo,
                        ),
                      );
                    }

                    if (state is QuestionTypeError) {
                      return Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'عذراً حدث خطأ ما',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'Tajawal'),
                          ),
                          TextButton(
                            onPressed: () {
                              QuestionTypeCubit.get(context).getSubject();
                            },
                            child: const Text(
                              'إعادة محاولة',
                              style: TextStyle(
                                  color: Colors.indigo,
                                  fontSize: 18,
                                  fontFamily: 'Tajawal',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ));
                    }

                    if (state is QuestionTypeDone) {
                      return WillPopScope(
                        onWillPop: () async {
                          // إظهار حوار التأكيد
                          return await showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('تأكيد مغادرة التطبيق'),
                                  content: const Text(
                                      'هل أنت متأكد أنك تريد مغادرة التطبيق؟'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context)
                                          .pop(false), // لا تغادر
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
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Stack(
                            children: <Widget>[
                              SingleChildScrollView(
                                child: Container(
                                  padding: const EdgeInsets.only(top: 210),
                                  height: MediaQuery.of(context).size.height,
                                  width: double.infinity,
                                  child: RefreshIndicator(
                                  onRefresh: () async {
                                    QuestionTypeCubit cubit = QuestionTypeCubit.get(context);
                                    cubit.getSubject();
                                  },
                                    child: ListView.builder(
                                      itemCount: QuestionTypeCubit.get(context)
                                          .subjects
                                          .length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                          onTap: () {
                                            List<Subject> subject =
                                                QuestionTypeCubit.get(context)
                                                    .subjects;
                                            if (subject[index].exams!.isEmpty) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      'هذه المادة لا تحتوي على امتحان'),
                                                  backgroundColor: Colors.red,
                                                  duration:
                                                      const Duration(seconds: 2),
                                                ),
                                              );
                                            }
                                            subject[index].exams!.length > 1
                                                ? showModalBottomSheet(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return SelectExam(
                                                        onTap: () {
                                                          Navigator.pop(context);
                                                          showExamCodeDialog(
                                                            context: context,
                                                            subjectId:
                                                                subject[index]
                                                                    .id!,
                                                            examId: subject[index]
                                                                .exams![0]
                                                                .id!,
                                                            subjectName:
                                                                subject[index]
                                                                    .name!,
                                                          );
                                    
                                                          // QuestionTypeCubit.get(
                                                          //         context)
                                                          //     .selectSubject(
                                                          //         subject[index]
                                                          //             .id!,
                                                          //         subject[index]
                                                          //             .exams![0]
                                                          //             .id!,
                                                          //         subject[index]
                                                          //             .name!,
                                                          //         context);
                                                        },
                                                        subjectId:
                                                            subject[index].id!,
                                                        subjectName:
                                                            subject[index].name!,
                                                        exams:
                                                            subject[index].exams!,
                                                      );
                                                    },
                                                  )
                                                : showExamCodeDialog(
                                                    context: context,
                                                    subjectId: subject[index].id!,
                                                    examId: subject[index]
                                                        .exams![0]
                                                        .id!,
                                                    subjectName:
                                                        subject[index].name!,
                                                  );
                                    
                                            // QuestionTypeCubit.get(context)
                                            //     .selectSubject(
                                            //         subject[index].id!,
                                            //         subject[index]
                                            //             .exams![0]
                                            //             .id!,
                                            //         subject[index].name!,
                                            //         context);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              color: Colors.white,
                                            ),
                                            width: double.infinity,
                                            // height: 100,
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 20),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 20),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .end, // ترتيب العناصر من اليمين
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .end, // محاذاة النص إلى اليمين
                                                    children: <Widget>[
                                                      Text(
                                                        QuestionTypeCubit.get(
                                                                context)
                                                            .subjects[index]
                                                            .name!,
                                                        style: TextStyle(
                                                            color: blue,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18),
                                                        textAlign: TextAlign
                                                            .right, // محاذاة النص إلى اليمين
                                                      ),
                                                      QuestionTypeCubit.get(
                                                                  context)
                                                              .subjects[index]
                                                              .specialty!
                                                              .isEmpty
                                                          ? const SizedBox()
                                                          : Wrap(
                                                              alignment:
                                                                  WrapAlignment
                                                                      .end,
                                                              spacing: 6,
                                                              runSpacing: 4,
                                                              children:
                                                                  QuestionTypeCubit
                                                                          .get(
                                                                              context)
                                                                      .subjects[
                                                                          index]
                                                                      .specialty!
                                                                      .map(
                                                                          (spec) {
                                                                return Container(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8,
                                                                      vertical:
                                                                          3),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: blue
                                                                        .withOpacity(
                                                                            0.1),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                12),
                                                                  ),
                                                                  child: Text(
                                                                    spec.name!,
                                                                    style:
                                                                        TextStyle(
                                                                      color: blue,
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .right,
                                                                  ),
                                                                );
                                                              }).toList(),
                                                            ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end, // ترتيب العناصر من اليمين
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            'year: ${QuestionTypeCubit.get(context).subjects[index].year.toString()}',
                                                            style: TextStyle(
                                                                color: blue,
                                                                fontSize: 13,
                                                                letterSpacing:
                                                                    .3),
                                                            textAlign: TextAlign
                                                                .right, // محاذاة النص إلى اليمين
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        8.0),
                                                            child: Text(
                                                              "-",
                                                              style: TextStyle(
                                                                  color: blue,
                                                                  fontSize: 13,
                                                                  letterSpacing:
                                                                      .3),
                                                              textAlign: TextAlign
                                                                  .right, // محاذاة النص إلى اليمين
                                                            ),
                                                          ),
                                                          Text(
                                                            'semester: ${QuestionTypeCubit.get(context).subjects[index].semester.toString()}',
                                                            style: TextStyle(
                                                                color: blue,
                                                                fontSize: 13,
                                                                letterSpacing:
                                                                    .3),
                                                            textAlign: TextAlign
                                                                .right, // محاذاة النص إلى اليمين
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: 50,
                                                  height: 50,
                                                  margin: const EdgeInsets.only(
                                                      left: 15),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(50),
                                                    border: Border.all(
                                                        width: 1, color: blue),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(
                                                        2), // كبّر الرقم لتصغير الصورة أكتر
                                                    child: Image.asset(
                                                      "assets/img/logo_app.png",
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 2, vertical: 36.1),
                                  child: QuestionTypeCubit.get(context)
                                          .imgList
                                          .isEmpty
                                      ? const SizedBox(
                                          height: 200,
                                        )
                                      : CarouselSlider(
                                          options: CarouselOptions(
                                            height: 200,
                                            autoPlay: true,
                                            enlargeCenterPage: true,
                                            aspectRatio: 16 / 9,
                                            autoPlayCurve: Curves.fastOutSlowIn,
                                            enableInfiniteScroll: true,
                                            autoPlayAnimationDuration:
                                                Duration(milliseconds: 800),
                                            viewportFraction: 1.0,
                                          ),
                                          items: QuestionTypeCubit.get(context)
                                              .imgList
                                              .map((item) {
                                            return Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 3),
                                              height: 200,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  // topLeft:Radius.circular(30) ,
                                                  // topRight: Radius.circular(30),
                                                  bottomLeft:
                                                      Radius.circular(30),
                                                  bottomRight:
                                                      Radius.circular(30),
                                                ),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      '$imageUrl/$item'),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        )),
                              Positioned(
                                top: 47, // المسافة من الأعلى
                                left: 12, // المسافة من اليسار
                                child: Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40),
                                      topRight: Radius.circular(40),
                                      bottomLeft: Radius.circular(40),
                                      bottomRight: Radius.circular(40),
                                    ),
                                    color: Color.fromARGB(128, 11, 11, 87),
                                  ),
                                  child: Center(
                                    child: IconButton(
                                      icon: Icon(Icons.menu,
                                          color: Colors.white), // الأيقونة
                                      onPressed: () {
                                        Scaffold.of(context)
                                            .openDrawer(); // فتح الـ Drawer
                                      },
                                    ),
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
                        ),
                      );
                    }
                    return Container();
                  })),
        ));
  }
}
