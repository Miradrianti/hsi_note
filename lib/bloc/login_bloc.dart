import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.loading));

    // Simulasi delay (seperti API call)
    await Future.delayed(const Duration(seconds: 1));

    // Dummy login check
    if (event.email == "test@mail.com" && event.password == "1234") {
      emit(state.copyWith(
        status: LoginStatus.success,
        email: event.email,
      ));
    } else {
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: "Email atau password salah",
      ));
    }
  }

  void _onLogoutRequested(
      LogoutRequested event, Emitter<LoginState> emit) {
    emit(const LoginState(status: LoginStatus.initial));
  }
}
