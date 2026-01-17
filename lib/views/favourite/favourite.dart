// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:almizan/cubit/package_cubit.dart';
// import 'package:almizan/general/color.dart';
// import 'package:almizan/general/my_theme.dart';
// import 'package:almizan/services/extensions.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../../state/package_state.dart';
// import '../choose_subject.dart';

// class MyFavourite extends StatelessWidget {
//   MyFavourite({
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
//                 PackageCubit cubit = PackageCubit();
//                 cubit.getPackage();
//                 return cubit;
//               },
//               child: BlocConsumer<PackageCubit, PackageState>(
//                 listener: (context, state) {},
//                 builder: (context, state) {
//                   PackageCubit cubit = PackageCubit.get(context);
//                   return Directionality(
//                     textDirection: TextDirection.rtl,
//                     child: Container(
//                       decoration: const BoxDecoration(
//                         image: DecorationImage(
//                           image: AssetImage('assets/img/bg.jpg'),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 15, vertical: 5),
//                         child: Directionality(
//                           textDirection: TextDirection.rtl,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Align(
//                                 alignment: Alignment.center,
//                                 child: Image.asset(
//                                   "assets/img/logo_app.png",
//                                   width: 100,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Align(
//                                   alignment: Alignment.center,
//                                   child: Image.asset(
//                                     "assets/img/golden.png",
//                                     width: 150,
//                                   )),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               const Text(
//                                 '1.التحويل الى المحفظة االالكترونية زين كاش  الرقم 987-00-99-079',
//                                 style: TextStyle(
//                                     fontSize: 16, color: Colors.white),
//                               ),
//                               const Text(
//                                 '2. يرجى ارسال صورة الفاتورة وذكر الباقة على رقم الواتس اب 987-00-99-079  ',
//                                 style: TextStyle(
//                                     fontSize: 16, color: Colors.white),
//                               ),
//                               const Text(
//                                 '3. اضغط على زر اشترك الان ',
//                                 style: TextStyle(
//                                     fontSize: 16, color: Colors.white),
//                               ),
//                               Text(
//                                 "*يرجى التاكد عند الدفع حيث لا نتحمل مسؤولية عند الدفع بشكل خاطئ او على شكل رصيد  *",
//                                 textDirection: TextDirection.rtl,
//                                 style: TextStyle(color: Colors.amberAccent),
//                               ),
//                               Align(
//                                 alignment: Alignment.center,
//                                 child: TextButton(
//                                     onPressed: () async {
//                                       Navigator.pushReplacement(
//                                           context,
//                                           PageTransition(
//                                               type: PageTransitionType
//                                                   .leftToRight,
//                                               child: ChooseSubject(),
//                                               duration: const Duration(
//                                                   microseconds: 800)));
//                                     },
//                                     style: ButtonStyle(
//                                         backgroundColor:
//                                             MaterialStateProperty.all(
//                                                 Colors.amber)),
//                                     child: Text(
//                                       "الاشتراك لاحقاً",
//                                       style: TextStyle(color: Colors.white),
//                                     )),
//                               ),
//                               if (state is PackageLoading)
//                                 const Center(child: CircularProgressIndicator())
//                               else
//                                 Expanded(
//                                   child: ListView.separated(
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 10, horizontal: 17.0),
//                                     shrinkWrap: true,
//                                     scrollDirection: Axis.horizontal,
//                                     itemCount: PackageCubit.get(context)
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
//                                                     PackageCubit.get(context)
//                                                         .premium[index]
//                                                         .name,
//                                                     style: TextStyle(
//                                                         color: Colors.black),
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
//                                                         'دينار ${PackageCubit.get(context).premium![index].price.toString()} ',
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
//                                                         '\u2713  ${PackageCubit.get(context).premium![index].days} days',
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
//                                                               .price !=
//                                                           0) {
//                                                         await launchUrl(Uri.parse(
//                                                             'https://wa.me/+962799900987'));
//                                                       } else {
//                                                         PackageCubit.get(
//                                                                 context)
//                                                             .subscibe(
//                                                                 cubit
//                                                                     .premium[
//                                                                         index]
//                                                                     .id,
//                                                                 cubit
//                                                                     .premium[
//                                                                         index]
//                                                                     .days);
//                                                         Navigator.pushReplacement(
//                                                             context,
//                                                             PageTransition(
//                                                                 type: PageTransitionType
//                                                                     .leftToRight,
//                                                                 child:
//                                                                     ChooseSubject(),
//                                                                 duration: const Duration(
//                                                                     microseconds:
//                                                                         800)));
//                                                       }
//                                                     },
//                                                     style: ButtonStyle(
//                                                         backgroundColor:
//                                                             MaterialStateProperty
//                                                                 .all(primary)),
//                                                     child: PackageCubit.get(
//                                                                     context)
//                                                                 .premium![index]
//                                                                 .id ==
//                                                             1
//                                                         ? Text(
//                                                             "اشترك الان",
//                                                             style: TextStyle(
//                                                                 color: Colors
//                                                                     .white),
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
//                                   ),
//                                 ),

// //                             ListView.builder(
// //                                 physics: BouncingScrollPhysics(),
// //                                 itemCount: cubit.categories.length,
// //                                 itemBuilder: (BuildContext context, int index) {
// //                                   return InkWell(
// //                                     onTap: () async{
// //
// //                                       PackageCubit.get(context).subscibe(cubit.categories[index].id, cubit.categories[index].days);
// //
// //                                       if(cubit.categories[index].price!=0){
// //
// //
// //                                         await       launchInBrowser(Uri.parse(
// //                                             'https://wa.me/+962796641378'));
// //                                       }
// // else{
// //
// //                                         Navigator.pushReplacement(context, PageTransition(
// //                                             type: PageTransitionType.leftToRight,
// //                                             child:  QuizHomePage(),
// //                                             duration: const Duration(microseconds: 800)));
// //
// //                                       }
// //                                     },
// //                                     child: Container(
// //                                       constraints: BoxConstraints(
// //                                           minHeight: assignHeight(
// //                                               context: context, fraction: 0.3),
// //                                           minWidth: assignWidth(
// //                                               context: context, fraction: 0.8),
// //                                           maxHeight: assignHeight(
// //                                               context: context, fraction: 0.5),
// //                                           maxWidth: assignWidth(
// //                                               context: context, fraction: 1)),
// //                                       margin: EdgeInsets.symmetric(
// //                                           vertical: 10, horizontal: 10),
// //                                       padding: EdgeInsets.all(10),
// //                                       height: assignHeight(
// //                                           context: context, fraction: 0.08),
// //                                       decoration: BoxDecoration(
// //                                         color: Colors.white,
// //                                         borderRadius: BorderRadius.circular(2),
// //                                         boxShadow: [
// //                                           BoxShadow(
// //                                             color: Colors.grey.withOpacity(0.5),
// //                                             spreadRadius: 1,
// //                                             blurRadius: 2,
// //                                             offset: Offset(
// //                                                 0, 3), // changes position of shadow
// //                                           ),
// //                                         ],
// //                                       ),
// //                                       child: Column(
// //                                         crossAxisAlignment: CrossAxisAlignment.start,
// //                                         mainAxisAlignment: MainAxisAlignment.center,
// //                                         children: [
// //                                           Text(
// //                                             cubit.categories[index].name,
// //                                             style: TextStyle(
// //                                               fontWeight: FontWeight.bold,
// //                                               fontSize: 16.sp,
// //                                             ),
// //                                           ),
// //                                           10.ph,
// //                                           (cubit.categories[index].price==0)?  const Text("سعر الباقة: باقة مجانية"):
// //                                             Text("سعر الباقة: ${cubit.categories[index].price}دينار"),
// //
// //
// //
// //                                           Text("مدة الباقة: ${cubit.categories[index].days}يوم"),
// //
// //                                           const Text(
// //                                             "تفاصيل" + " : ",
// //                                           ),
// //
// //                                           Center(
// //                                             child: Container(
// //                                                 alignment: Alignment.center,
// //                                                 padding: EdgeInsets.all(5),
// //                                                 width: assignWidth(
// //                                                     context: context, fraction: 0.6),
// //                                                 child: GestureDetector(
// //                                                   onTap: () async{
// //
// //                                                     PackageCubit.get(context).subscibe(cubit.categories[index].id, cubit.categories[index].days);
// //
// //                                                     if(cubit.categories[index].price!=0){
// //
// //
// //                                                       await       launchInBrowser(Uri.parse(
// //                                                           'https://wa.me/+962796641378'));
// //                                                     }else{
// //                                                       showSnackBar(context);
// //
// //                                                       Navigator.pushReplacement(context, PageTransition(
// //                                                           type: PageTransitionType.leftToRight,
// //                                                           child:  QuizHomePage(),
// //                                                           duration: const Duration(microseconds: 800)));
// //
// //                                                     }
// //                                                   },
// //                                                   child: const Card(
// //                                                     elevation: 2,
// //                                                     color:  Colors.indigo
// //                                                     ,
// //                                                     child: Center(
// //                                                       child: Text(
// //                                                         "Subscibe",
// //                                                         style: TextStyle(
// //                                                             color: Colors.white,
// //                                                             fontWeight:
// //                                                             FontWeight.w500),
// //                                                       ),
// //                                                     ),
// //                                                   ),
// //                                                 )),
// //                                           ),
// //                                         ],
// //                                       ),
// //                                     ),
// //                                   );
// //                                 }),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           );
//         });
//   }
// }
