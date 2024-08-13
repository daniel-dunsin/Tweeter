import 'dart:convert';

class LoginModel {
  final String credential;
  final String password;
  LoginModel({
    required this.credential,
    required this.password,
  });

  Map<String, String> toMap() {
    final result = <String, String>{};

    result.addAll({
      'credential': credential
    });
    result.addAll({
      'password': password
    });

    return result;
  }

  factory LoginModel.fromMap(Map<String, String> map) {
    return LoginModel(
      credential: map['credential'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginModel.fromJson(String source) => LoginModel.fromMap(json.decode(source));
}
