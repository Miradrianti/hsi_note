import 'package:equatable/equatable.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  final LoginStatus status;
  final String? errorMessage;
  final String? email;

  const LoginState({
    this.status = LoginStatus.initial,
    this.errorMessage,
    this.email,
  });

  LoginState copyWith({
    LoginStatus? status,
    String? errorMessage,
    String? email,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, email];

  get user => null;
}
