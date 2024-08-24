import 'dart:convert';

import 'package:client/modules/auth/models/user_model.dart';

class AppCubitState {
  final UserModel? user;

  AppCubitState({
    this.user,
  });

  AppCubitState copyWith({
    UserModel? user,
  }) {
    return AppCubitState(
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (user != null) {
      result.addAll({
        'user': user!.toMap()
      });
    }

    return result;
  }

  factory AppCubitState.fromMap(Map<String, dynamic> map) {
    return AppCubitState(
      user: map['user'] != null ? UserModel.fromMap(map['user']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppCubitState.fromJson(String source) => AppCubitState.fromMap(json.decode(source));

  @override
  String toString() => 'AppCubitState(user: $user)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppCubitState && other.user == user;
  }

  @override
  int get hashCode => user.hashCode;
}
