// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:almizan/general/color.dart';
// import 'package:almizan/models/favourite.dart';
// import 'package:almizan/services/cache_helper.dart';
// import 'package:almizan/services/dio_helper.dart';
// import 'package:almizan/state/favourite_state.dart';
// import 'package:http/http.dart' as http;

// import '../models/user.dart';

// class FavoriteCubit extends Cubit<FavoriteState> {
//   FavoriteCubit() : super(FavoriteInitial());
//   static FavoriteCubit get(context) => BlocProvider.of(context);

//   List<FavouriteModel> favoriteList = [];
//   User? user;
//   int ispre = 0;
//   void getAllFavoriteProducts() {
//     String token = CacheHelper.getData(key: "api_token");
//     debugPrint(token);
//     DioHelper.postData(url: 'user2/account/getPfofile', data: {
//       'token': token,
//     }).then((value) {
//       user = User.fromJson(value!.data['user']);
//     });

//     emit(GetFavoriteProductLoading());
//     DioHelper.postData(url: '/favorite/getFavorites', query: {}, data: {
//       'token': CacheHelper.getData(key: 'api_token'),

//       //CacheHelper.getData(key: 'api_token'),
//     }).then((value) {
//       print(value);
//       if (value == null || value.statusCode != 200) {
//         emit(GetFavoriteProductError('error'));
//         return;
//       }
//       favoriteList = value.data['questions']
//           .map<FavouriteModel>((e) => FavouriteModel.fromJson(e))
//           .toList();
//       if (favoriteList.length > 0) {
//         emit(GetFavoriteProductSuccess());
//       } else {
//         emit(GetFavoriteProductEmpty());
//       }
//     }).catchError((error) {
//       if (kDebugMode) {
//         print(error.toString());
//       }
//       emit(GetFavoriteProductError('error'));
//     });
//   }

//   Future<void> deleteFromFavorite(int id) async {
//     var myUrl = Uri.parse(
//         "https://goldenjustmd.com/public/api/favorite/deleteFavorite");

//     final response = await http.post(myUrl, body: {
//       'question_id': id.toString(),
//       'token': CacheHelper.getData(key: 'api_token'),
//     });
//     if (response.statusCode == 200) {
//       emit(DeleteFromFavoriteSuccessState());
//       Fluttertoast.showToast(
//         msg: "تم الحذف من المفضلة بنجاح",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.SNACKBAR,
//         timeInSecForIosWeb: 1,
//         backgroundColor: primary,
//         textColor: Colors.white,
//         fontSize: 13,
//       );
//       getAllFavoriteProducts();
//     } else {
//       emit(DeleteFromFavoriteErrorsState());
//     }
//   }
// }
