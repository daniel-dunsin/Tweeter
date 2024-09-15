import 'dart:convert';

class ChangePasswordModel {
  String oldPassword;
  String newPassword;

  ChangePasswordModel({
    required this.oldPassword,
    required this.newPassword,
  });

  ChangePasswordModel copyWith({
    String? oldPassword,
    String? newPassword,
  }) {
    return ChangePasswordModel(
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    };
  }

  factory ChangePasswordModel.fromMap(Map<String, dynamic> map) {
    return ChangePasswordModel(
      oldPassword: map['oldPassword'] as String,
      newPassword: map['newPassword'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChangePasswordModel.fromJson(String source) => ChangePasswordModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ChangePasswordModel(oldPassword: $oldPassword, newPassword: $newPassword)';
}
