import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seller_app_fic/Data/DataResources/product_remote.datasources.dart';
import 'package:seller_app_fic/Data/Models/add_product_respon.dart';
import 'package:seller_app_fic/Data/Models/request/product_request_model.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';
part 'add_product_bloc.freezed.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  AddProductBloc() : super(const _Initial()) {
    on<_Create>((event, emit) async {
      emit(const _Loading());
      final response = await ProductRemoteDatarsources().addProduct(event.request);
      response.fold(
        (l) => emit(const _Error()),
        (r) => emit(_loaded(r))
      );
    });
  }
}
