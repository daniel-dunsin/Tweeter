import 'dart:convert';

class ResetPasswordModel {
  final String code;
  final String password;
  ResetPasswordModel({
    required this.code,
    required this.password,
  });

  Map<String, String> toMap() {
    final result = <String, String>{};

    result.addAll({
      'code': code
    });
    result.addAll({
      'password': password
    });

    return result;
  }

  factory ResetPasswordModel.fromMap(Map<String, String> map) {
    return ResetPasswordModel(
      code: map['code'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ResetPasswordModel.fromJson(String source) => ResetPasswordModel.fromMap(json.decode(source));
}
