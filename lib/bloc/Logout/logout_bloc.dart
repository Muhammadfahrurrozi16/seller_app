
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../Data/DataResources/auth_remote_datasources.dart';

part 'logout_event.dart';
part 'logout_state.dart';
part 'logout_bloc.freezed.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(const _Initial()) {
    on<_Logout>((event, emit) async {
     emit(const _Loading());
     final result = await AuthRemoteDatasource().logout();
     result.fold(
      (l) => emit(_Error(l)),
      (r) => emit(_Loaded(r)),
      );
    });
  }
}
