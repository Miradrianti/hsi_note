import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.email,
    required this.password,
    required this.username,
  });

  final String id;
  final String email;
  final String password;
  final String username;

  @override
  List<Object> get props => [id, email, password];

  static const empty = User(id: '-', email: '-', password: '-', username: '-');
}
