import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seller_app_fic/Data/DataResources/product_remote.datasources.dart';
import 'package:seller_app_fic/Data/Models/image_respon_model.dart';

part 'add_image_event.dart';
part 'add_image_state.dart';
part 'add_image_bloc.freezed.dart';

class AddImageBloc extends Bloc<AddImageEvent, AddImageState> {
  AddImageBloc() : super(const _Initial()) {
    on<_AddImage>((event, emit) async {
      emit(const _Loading());
      final response = await ProductRemoteDatarsources().addImage(event.image);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r))
        );
    });
  }
}
