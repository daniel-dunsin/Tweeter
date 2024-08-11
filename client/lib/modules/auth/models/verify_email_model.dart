import 'dart:convert';

class VerifyEmailModel {
  final String email;
  final String code;

  VerifyEmailModel({
    required this.email,
    required this.code,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({
      'email': email
    });
    result.addAll({
      'code': code
    });

    return result;
  }

  factory VerifyEmailModel.fromMap(Map<String, dynamic> map) {
    return VerifyEmailModel(
      email: map['email'] ?? '',
      code: map['code'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory VerifyEmailModel.fromJson(String source) => VerifyEmailModel.fromMap(json.decode(source));
}
