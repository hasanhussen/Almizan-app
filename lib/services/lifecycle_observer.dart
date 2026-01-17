// import 'package:flutter/material.dart';
// import 'cache_helper.dart';

// class LifecycleObserver extends StatefulWidget {
//   final Widget child;
//   const LifecycleObserver({super.key, required this.child});

//   @override
//   State<LifecycleObserver> createState() => _LifecycleObserverState();
// }

// class _LifecycleObserverState extends State<LifecycleObserver>
//     with WidgetsBindingObserver {

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);

//     // تنفيذ فور بدء التطبيق
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       print('🔵 LifecycleObserver: post frame callback');
//       CacheHelper.checkBackgroundNotifications();
//     });
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     print('🔵 AppLifecycleState = $state');
//     if (state == AppLifecycleState.resumed) {
//       CacheHelper.checkBackgroundNotifications();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return widget.child;
//   }
// }


