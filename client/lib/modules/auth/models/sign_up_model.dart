import 'dart:convert';

class SignUpModel {
  final String email;
  final String password;
  final String name;
  final String userName;
  final DateTime dateOfBirth;
  SignUpModel({
    required this.email,
    required this.password,
    required this.name,
    required this.userName,
    required this.dateOfBirth,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> result = {};

    result.addAll({'email': email});
    result.addAll({'password': password});
    result.addAll({'name': name});
    result.addAll({'userName': userName});
    result.addAll({'dateOfBirth': dateOfBirth.toIso8601String()});

    return result;
  }

  factory SignUpModel.fromMap(Map<String, dynamic> map) {
    return SignUpModel(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      name: map['name'] ?? '',
      userName: map['userName'] ?? '',
      dateOfBirth: DateTime.parse(map['dateOfBirth']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SignUpModel.fromJson(String source) =>
      SignUpModel.fromMap(json.decode(source));
}
