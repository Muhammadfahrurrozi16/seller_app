part of 'add_product_bloc.dart';

@freezed
class AddProductState with _$AddProductState {
  const factory AddProductState.initial() = _Initial;
  const factory AddProductState.loading() = _Loading;
  const factory AddProductState.loaded(AddProductResponseModel data) = _loaded;
  const factory AddProductState.error() = _Error;
}
