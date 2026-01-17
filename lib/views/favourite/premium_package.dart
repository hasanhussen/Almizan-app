// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:almizan/views/choose_subject.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:almizan/cubit/UserPackage_cubit.dart';

// import 'package:almizan/general/color.dart';
// import 'package:almizan/state/userPackage_state.dart';

// import 'package:url_launcher/url_launcher.dart';

// class Premium extends StatelessWidget {
//   Premium({
//     Key? key,
//   }) : super(key: key);
//   final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
//   void showSnackBar(BuildContext context) {
//     SnackBar snackBar = SnackBar(
//       content: Text("your package is activate successfully"),
//       backgroundColor: primary,
//       behavior: SnackBarBehavior.floating,
//       duration: const Duration(milliseconds: 1000),
//     );
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//         designSize: const Size(360, 690),
//         minTextAdapt: true,
//         splitScreenMode: true,

//         /// note : this line fix screen scroll
//         useInheritedMediaQuery: true,
//         builder: (context, child) {
//           return Scaffold(
//             appBar: AppBar(
//               iconTheme: IconThemeData(color: Colors.white),
//               title: Row(
//                 children: [
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width / 2 - 120,
//                   ),
//                   const Text(
//                     "الاشتراكات",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width / 2 - 120,
//                   )
//                 ],
//               ),
//               backgroundColor: blue,
//             ),
//             body: BlocProvider(
//               create: (context) {
//                 UserPackageCubit cubit = UserPackageCubit();
//                 cubit.getUserPackage();
//                 return cubit;
//               },
//               child: BlocConsumer<UserPackageCubit, UserPackageState>(
//                 listener: (context, state) {},
//                 builder: (context, state) {
//                   UserPackageCubit cubit = UserPackageCubit.get(context);
//                   return Directionality(
//                       textDirection: TextDirection.rtl,
//                       child: Container(
//                         decoration: const BoxDecoration(
//                           image: DecorationImage(
//                             image: AssetImage('assets/img/bg.jpg'),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 15, vertical: 5),
//                           child: Directionality(
//                             textDirection: TextDirection.rtl,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Align(
//                                   alignment: Alignment.center,
//                                   child: Image.asset(
//                                     "assets/img/logo_app.png",
//                                     width: 100,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Align(
//                                     alignment: Alignment.center,
//                                     child: Image.asset(
//                                       "assets/img/golden.png",
//                                       width: 150,
//                                     )),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 const Text(
//                                   '1.التحويل الى المحفظة االالكترونية زين كاش  الرقم 987-00-99-079',
//                                   style: TextStyle(
//                                       fontSize: 16, color: Colors.white),
//                                 ),
//                                 const Text(
//                                   '2. ارسال صورة التحويل ورقم للعملية واتس اب ',
//                                   style: TextStyle(
//                                       fontSize: 16, color: Colors.white),
//                                 ),
//                                 const Text(
//                                   '3. اضغط على زر اشترك الان ',
//                                   style: TextStyle(
//                                       fontSize: 16, color: Colors.white),
//                                 ),
//                                 Text(
//                                   "*يرجى التاكد عند الدفع حيث لا نتحمل مسؤولية عند الدفع بشكل خاطئ او على شكل رصيد  *",
//                                   textDirection: TextDirection.rtl,
//                                   style: TextStyle(color: Colors.amberAccent),
//                                 ),
//                                 if (state is UserPackageLoading)
//                                   const Center(
//                                       child: CircularProgressIndicator())
//                                 else
//                                   Expanded(
//                                       child: ListView.separated(
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 10, horizontal: 17.0),
//                                     shrinkWrap: true,
//                                     scrollDirection: Axis.horizontal,
//                                     itemCount: UserPackageCubit.get(context)
//                                         .premium
//                                         .length,
//                                     separatorBuilder:
//                                         (BuildContext context, int index) =>
//                                             const SizedBox(
//                                       width: 20,
//                                     ),
//                                     itemBuilder:
//                                         (BuildContext context, int index) {
//                                       return Column(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           Container(
//                                             decoration: BoxDecoration(
//                                                 color: Colors.white,
//                                                 border: UserPackageCubit.get(
//                                                             context)
//                                                         .premium![index]
//                                                         .subscriped
//                                                     ? Border.all(
//                                                         color: Colors.green)
//                                                     : Border.all(
//                                                         color: Colors.white),
//                                                 borderRadius:
//                                                     const BorderRadius.all(
//                                                   Radius.circular(16),
//                                                 ),
//                                                 boxShadow: [
//                                                   BoxShadow(
//                                                     color: Colors.grey
//                                                         .withOpacity(0.2),
//                                                     spreadRadius: 2,
//                                                     blurRadius: 10,
//                                                     offset: const Offset(0,
//                                                         5.0), // changes position of shadow
//                                                   )
//                                                 ]),
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 28,
//                                                       vertical: 15),
//                                               child: Column(
//                                                 children: [
//                                                   const SizedBox(
//                                                     height: 40,
//                                                     width: 40,
//                                                   ),
//                                                   const SizedBox(
//                                                     height: 10.0,
//                                                   ),
//                                                   Text(
//                                                     UserPackageCubit.get(
//                                                             context)
//                                                         .premium[index]
//                                                         .name,
//                                                     style: TextStyle(
//                                                         color: UserPackageCubit
//                                                                     .get(
//                                                                         context)
//                                                                 .premium![index]
//                                                                 .subscriped
//                                                             ? Colors.greenAccent
//                                                             : Colors.black),
//                                                   ),
//                                                   const SizedBox(
//                                                     height: 10.0,
//                                                   ),
//                                                   Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .center,
//                                                     children: [
//                                                       Text(
//                                                         'دينار ${UserPackageCubit.get(context).premium![index].price.toString()} ',
//                                                         style: const TextStyle(
//                                                             color: Colors.black,
//                                                             fontSize: 24,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .bold),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   const SizedBox(
//                                                     height: 20.0,
//                                                   ),
//                                                   Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       Text(
//                                                         '\u2713  ${UserPackageCubit.get(context).premium![index].days} days',
//                                                         style: TextStyle(
//                                                             color:
//                                                                 Colors.black),
//                                                       ),
//                                                       const SizedBox(
//                                                         height: 14.0,
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   TextButton(
//                                                     onPressed: () async {
//                                                       if (cubit.premium[index]
//                                                           .subscriped) {
//                                                         Fluttertoast.showToast(
//                                                           msg:
//                                                               "انت مشترك بالفعل    ",
//                                                           toastLength: Toast
//                                                               .LENGTH_SHORT,
//                                                           gravity: ToastGravity
//                                                               .SNACKBAR,
//                                                           timeInSecForIosWeb: 1,
//                                                           backgroundColor:
//                                                               primary,
//                                                           textColor:
//                                                               Colors.white,
//                                                           fontSize: 13,
//                                                         );
//                                                       } else {
//                                                         if (cubit.premium[index]
//                                                                 .price !=
//                                                             0) {
//                                                           await launchUrl(Uri.parse(
//                                                               'https://wa.me/+962799900987'));
//                                                         } else {
//                                                           UserPackageCubit.get(
//                                                                   context)
//                                                               .subscibe(
//                                                                   cubit
//                                                                       .premium[
//                                                                           index]
//                                                                       .id,
//                                                                   cubit
//                                                                       .premium[
//                                                                           index]
//                                                                       .days);

//                                                           Navigator.pushReplacement(
//                                                               context,
//                                                               PageTransition(
//                                                                   type: PageTransitionType
//                                                                       .leftToRight,
//                                                                   child:
//                                                                       ChooseSubject(),
//                                                                   duration: const Duration(
//                                                                       microseconds:
//                                                                           800)));
//                                                         }
//                                                       }
//                                                     },
//                                                     style: ButtonStyle(
//                                                       backgroundColor:
//                                                           MaterialStateProperty
//                                                               .all(primary),
//                                                       side: MaterialStateBorderSide
//                                                           .resolveWith((Set<
//                                                                   MaterialState>
//                                                               states) {
//                                                         if (UserPackageCubit
//                                                                 .get(context)
//                                                             .premium![index]
//                                                             .subscriped) {
//                                                           return BorderSide(
//                                                               color: Colors
//                                                                   .greenAccent);
//                                                         }
//                                                       }),
//                                                     ),
//                                                     child: UserPackageCubit.get(
//                                                                 context)
//                                                             .premium![index]
//                                                             .subscriped
//                                                         ? Column(
//                                                             children: [
//                                                               Text(
//                                                                 "مشترك",
//                                                                 style: TextStyle(
//                                                                     color: Colors
//                                                                         .white),
//                                                               ),
//                                                               Text(
//                                                                 "متبقي:${UserPackageCubit.get(context).premium![index].duration().toString()} ايام",
//                                                                 style: TextStyle(
//                                                                     color: Colors
//                                                                         .white),
//                                                               )
//                                                             ],
//                                                           )
//                                                         : Text(
//                                                             'اشترك الان',
//                                                             style: TextStyle(
//                                                                 color: Colors
//                                                                     .white),
//                                                           ),
//                                                   ),

//                                                   // TextButton(onPressed: (){}, child: child)
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       );
//                                     },
//                                   )),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ));
//                 },
//               ),
//             ),
//           );
//         });
//   }
// }
