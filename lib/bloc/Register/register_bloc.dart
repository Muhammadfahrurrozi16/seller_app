
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../Data/DataResources/auth_remote_datasources.dart';
import '../../Data/Models/Auth_model_respon.dart';
import '../../Data/Models/request/register_request_model.dart';


part 'register_event.dart';
part 'register_state.dart';
part 'register_bloc.freezed.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const _Initial()) {
    on<_Register>((event, emit) async {
      emit(const _Loading());
      final result = await AuthRemoteDatasource().register(event.model);
      result.fold(
        (error) => emit(_Error(error)), 
        (data) => emit(_Loaded(data)),
      );
    });
  }
}
