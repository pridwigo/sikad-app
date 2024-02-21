import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sikad_app/src/data/datasources/auth_remote_datasource.dart';

part 'logout_event.dart';
part 'logout_state.dart';
part 'logout_bloc.freezed.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(const _Initial()) {
    on<_Logout>((event, emit) async {
      emit(const _Loading());

      final response = await AuthRemoteDatasource().logout();
      response.fold(
        (l) => emit(const _Error()),
        (r) => emit(const _Loaded()),
      );
    });
  }
}
