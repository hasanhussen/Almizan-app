

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class GetFavoriteProductLoading extends FavoriteState {}
class GetFavoriteProductEmpty extends FavoriteState {}

class GetFavoriteProductSuccess extends FavoriteState {


  GetFavoriteProductSuccess();
}

class GetFavoriteProductError extends FavoriteState {
  final String error;

  GetFavoriteProductError(this.error);
}

class DeleteFromFavoriteSuccessState extends FavoriteState {}

class DeleteFromFavoriteErrorsState extends FavoriteState {}

class DeviceNotConnectedState extends FavoriteState {}