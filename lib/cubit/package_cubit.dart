// import 'package:flutter/foundation.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:almizan/models/package.dart';
// import 'package:almizan/services/cache_helper.dart';
// import 'package:almizan/services/dio_helper.dart';
// import 'package:almizan/state/package_state.dart';

// class PackageCubit extends Cubit<PackageState> {
//   PackageCubit() : super(PackageInitial());

//   static PackageCubit get(context) => BlocProvider.of(context);

//   List<Package> categories = [];
//   List<Package> premium = [];
//   void getPackage() {
//     emit(PackageLoading());
//     DioHelper.postData(
//       url: '/subscripe/getPackages',
//       query: {},
//       data: {"token": CacheHelper.getData(key: "api_token")},
//     ).then((value) {
//       if (value == null || value.statusCode != 200) {
//         emit(PackageError());
//         return;
//       }
//       categories = value.data['packages']
//           .map<Package>((e) => Package.fromJson(e))
//           .toList();
//       premium.addAll(categories.where((element) => element.shown == true));
//       emit(PackageDone());
//     }).catchError((error) {
//       if (kDebugMode) {
//         print(error.toString());
//       }
//       emit(PackageError());
//     });
//   }

//   void subscibe(id, days) {
//     emit(PackageLoading());
//     DioHelper.postData(url: '/subscripe/addSubscripe', query: {}, data: {
//       "token": CacheHelper.getData(key: 'api_token'),
//       "PACKAGE_ID": id,
//       "DAYS": days
//     }).then((value) {
//       if (value == null || value.statusCode != 200) {
//         emit(PackageError());
//         return;
//       }
//       categories = value.data['packages']
//           .map<Package>((e) => Package.fromJson(e))
//           .toList();

//       emit(PackageDone());
//     }).catchError((error) {
//       if (kDebugMode) {
//         print(error.toString());
//       }
//       emit(PackageError());
//     });
//   }
// }
