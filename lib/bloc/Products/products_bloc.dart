import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seller_app_fic/Data/DataResources/product_remote.datasources.dart';
import 'package:seller_app_fic/Data/Models/Product_model_respon.dart';

part 'products_event.dart';
part 'products_state.dart';
part 'products_bloc.freezed.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(const _Initial()) {
    on<_GetProduct>((event, emit) async {
      emit(const _Loading());
      final response = await ProductRemoteDatarsources().getProduct();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
        );
    });
  }
}
