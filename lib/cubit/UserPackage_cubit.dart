// import 'package:flutter/foundation.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:almizan/models/userPackage.dart';

// import 'package:almizan/services/cache_helper.dart';
// import 'package:almizan/services/dio_helper.dart';
// import 'package:almizan/state/userPackage_state.dart';

// class UserPackageCubit extends Cubit<UserPackageState> {
//   UserPackageCubit() : super(UserPackageInitial());

//   static UserPackageCubit get(context) => BlocProvider.of(context);

//   List<UserPackage> categories = [];
//   List<UserPackage> premium = [];
//   void getUserPackage() {
//     emit(UserPackageLoading());
//     DioHelper.postData(
//       url: '/subscripe/getPackagesWithUserSubscribe',
//       query: {},
//       data: {
//         'token': CacheHelper.getData(key: "api_token"),
//       },
//     ).then((value) {
//       if (value == null || value.statusCode != 200) {
//         emit(UserPackageError());
//         return;
//       }
//       categories = value.data['packages']
//           .map<UserPackage>((e) => UserPackage.fromJson(e))
//           .toList();
//       premium.addAll(categories);
//       emit(UserPackageDone());
//     }).catchError((error) {
//       if (kDebugMode) {
//         print(error.toString());
//       }
//       emit(UserPackageError());
//     });
//   }

//   void subscibe(id, days) {
//     emit(UserPackageLoading());
//     DioHelper.postData(url: '/subscripe/addSubscripe', query: {}, data: {
//       "token": CacheHelper.getData(key: 'api_token'),
//       "PACKAGE_ID": id,
//       "DAYS": days
//     }).then((value) {
//       if (value == null || value.statusCode != 200) {
//         emit(UserPackageError());
//         return;
//       }
//       categories = value.data['packages']
//           .map<UserPackage>((e) => UserPackage.fromJson(e))
//           .toList();

//       emit(UserPackageDone());
//     }).catchError((error) {
//       if (kDebugMode) {
//         print(error.toString());
//       }
//       emit(UserPackageError());
//     });
//   }
// }
