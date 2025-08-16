class User {
  final int? id;
  final String email;
  final String password;

  User({this.id, required this.password, required this.email});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pass': password,
      'email': email,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      password: json['pass'],
      email: json['email'],
    );
  }
}