// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:almizan/cubit/exam_cubit.dart';
// import 'package:almizan/general/color.dart';
// import 'package:almizan/services/extensions.dart';
// import 'package:almizan/state/exam_state.dart';
// import 'package:almizan/views/quiz/exam_detail.dart';
//
// class ExamList extends StatefulWidget {
//   const ExamList({Key? key}) : super(key: key);
//
//   @override
//   createState() => _ExamListState();
// }
//
// class _ExamListState extends State<ExamList> {
//   final TextStyle dropdownMenuItem =
//       const TextStyle(color: Colors.black, fontSize: 18);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Row(
//             children: [
//               SizedBox(
//                 width: MediaQuery.of(context).size.width / 2 - 140,
//               ),
//               Image.asset(
//                 "assets/img/golden.png",
//                 width: 150,
//               ),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width / 2 - 120,
//               )
//             ],
//           ),
//           iconTheme: IconThemeData(color: Colors.white),
//           backgroundColor: primary,
//           elevation: 0,
//         ),
//         backgroundColor: const Color(0xfff0f0f0),
//         body: ScreenUtilInit(
//             designSize: const Size(360, 690),
//             minTextAdapt: true,
//             splitScreenMode: true,
//
//             /// note : this line fix screen scroll
//             useInheritedMediaQuery: true,
//             builder: (context, child) {
//               return BlocProvider(
//                   create: (context) {
//                     ExamCubit cubit = ExamCubit();
//                     cubit.getExam();
//                     return cubit;
//                   },
//                   child: BlocConsumer<ExamCubit, ExamState>(
//                       listener: (context, state) {},
//                       builder: (context, state) {
//                         if (state is ExamLoading) {
//                           return const Center(
//                             child: CircularProgressIndicator(
//                               color: Colors.indigo,
//                             ),
//                           );
//                         }
//
//                         if (state is ExamError) {
//                           return Center(
//                               child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               const Text(
//                                 'عذراً حدث خطأ ما',
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 18,
//                                     fontFamily: 'Tajawal'),
//                               ),
//                               TextButton(
//                                 onPressed: () {
//                                   ExamCubit.get(context).getExam();
//                                 },
//                                 child: const Text(
//                                   'إعادة محاولة',
//                                   style: TextStyle(
//                                       color: Colors.indigo,
//                                       fontSize: 18,
//                                       fontFamily: 'Tajawal',
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             ],
//                           ));
//                         }
//
//                         if (state is ExamDone) {
//                           return SingleChildScrollView(
//                             child: SizedBox(
//                               height: MediaQuery.of(context).size.height,
//                               width: MediaQuery.of(context).size.width,
//                               child: Stack(
//                                 children: <Widget>[
//                                   Container(
//                                     padding: const EdgeInsets.only(top: 145),
//                                     height: MediaQuery.of(context).size.height,
//                                     width: double.infinity,
//                                     child: ListView.builder(
//                                         itemCount:
//                                             ExamCubit.get(context).exam.length,
//                                         itemBuilder:
//                                             (BuildContext context, int index) {
//                                           return GestureDetector(
//                                             onTap: () {
//                                               Navigator.push(
//                                                   context,
//                                                   PageTransition(
//                                                       type: PageTransitionType
//                                                           .leftToRight,
//                                                       child: ExamDetail(
//                                                         exam: ExamCubit.get(
//                                                                 context)
//                                                             .exam[index],
//                                                       ),
//                                                       duration: const Duration(
//                                                           microseconds: 800)));
//                                             },
//                                             child: Container(
//                                               constraints: BoxConstraints(
//                                                   minHeight: assignHeight(
//                                                       context: context,
//                                                       fraction: 0.25),
//                                                   minWidth: assignWidth(
//                                                       context: context,
//                                                       fraction: 0.8),
//                                                   maxHeight: assignHeight(
//                                                       context: context,
//                                                       fraction: 0.5),
//                                                   maxWidth: assignWidth(
//                                                       context: context,
//                                                       fraction: 1)),
//                                               margin:
//                                                   const EdgeInsets.symmetric(
//                                                       vertical: 10,
//                                                       horizontal: 10),
//                                               padding: const EdgeInsets.all(5),
//                                               height: assignHeight(
//                                                   context: context,
//                                                   fraction: 0.06),
//                                               decoration: BoxDecoration(
//                                                 color: Colors.white,
//                                                 borderRadius:
//                                                     BorderRadius.circular(2),
//                                                 boxShadow: [
//                                                   BoxShadow(
//                                                     color: Colors.grey
//                                                         .withOpacity(0.5),
//                                                     spreadRadius: 1,
//                                                     blurRadius: 2,
//                                                     offset: const Offset(0,
//                                                         3), // changes position of shadow
//                                                   ),
//                                                 ],
//                                               ),
//                                               child: Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.start,
//                                                 children: [
//                                                   Text(
//                                                     "${ExamCubit.get(context).exam[index].id}-${ExamCubit.get(context).exam[index].category}",
//                                                     style: TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       fontSize: 16.sp,
//                                                     ),
//                                                   ),
//                                                   8.ph,
//                                                   Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceBetween,
//                                                     children: [
//                                                       Text(
//                                                           "Right Answer: ${ExamCubit.get(context).exam[index].correct.toString()}"),
//                                                       InkWell(
//                                                         child: const Icon(
//                                                           Icons.delete,
//                                                           color: Colors.red,
//                                                         ),
//                                                         onTap: () {
//                                                           ExamCubit.get(context)
//                                                               .deleteExam(
//                                                                   ExamCubit.get(
//                                                                           context)
//                                                                       .exam[
//                                                                           index]
//                                                                       .id);
//                                                         },
//                                                       )
//                                                     ],
//                                                   ),
//                                                   10.ph,
//                                                   Text(
//                                                       "Wrong Answer: ${ExamCubit.get(context).exam[index].incorrect.toString()} "),
//                                                   5.ph,
//                                                   Text(
//                                                       " Date:${ExamCubit.get(context).exam[index].date}"),
//                                                 ],
//                                               ),
//                                             ),
//                                           );
//                                         }),
//                                   ),
//                                   Container(
//                                     height: 140,
//                                     width: double.infinity,
//                                     decoration: const BoxDecoration(
//                                         image: DecorationImage(
//                                             image: AssetImage(
//                                               "assets/img/bg.jpg",
//                                             ),
//                                             fit: BoxFit.cover),
//                                         borderRadius: BorderRadius.only(
//                                             bottomLeft: Radius.circular(30),
//                                             bottomRight: Radius.circular(30))),
//                                     child: Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 30),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: <Widget>[
//                                           Container(),
//                                           const Text(
//                                             "اختباراتي",
//                                             style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 24),
//                                           ),
//                                           Container(),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   const Column(
//                                     children: <Widget>[
//                                       SizedBox(
//                                         height: 145,
//                                       ),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                           );
//                         }
//                         return Container();
//                       }));
//             }));
//   }
// }
