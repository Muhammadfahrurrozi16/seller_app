
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../Data/DataResources/category_remote_datasources.dart';
import '../../Data/Models/Category_model_respon.dart';

part 'category_event.dart';
part 'category_state.dart';
part 'category_bloc.freezed.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(const _Initial()) {
    on<_GetCategory>((event, emit) async{
      emit(const _Loading());
      final result = await CategoryRemoteDataSources().getCategory();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
        );
    });
  }
}
