import 'dart:convert';

import 'package:client/modules/auth/models/user_model.dart';

class AppCubitState {
  final UserModel? user;
  final List<UserModel>? followers;
  final List<UserModel>? following;

  AppCubitState({
    this.user,
    this.followers,
    this.following,
  });

  AppCubitState copyWith({
    UserModel? user,
    List<UserModel>? followers,
    List<UserModel>? following,
  }) {
    return AppCubitState(
      user: user ?? this.user,
      followers: followers ?? this.followers,
      following: following ?? this.following,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (user != null) {
      result.addAll({
        'user': user!.toMap()
      });
    }
    if (followers != null) {
      result.addAll({
        'followers': followers!.map((x) => x.toMap()).toList()
      });
    }
    if (following != null) {
      result.addAll({
        'following': following!.map((x) => x.toMap()).toList()
      });
    }

    return result;
  }

  factory AppCubitState.fromMap(Map<String, dynamic> map) {
    return AppCubitState(
      user: map['user'] != null ? UserModel.fromMap(map['user']) : null,
      followers: map['followers'] != null ? List<UserModel>.from(map['followers']?.map((x) => UserModel.fromMap(x))) : null,
      following: map['following'] != null ? List<UserModel>.from(map['following']?.map((x) => UserModel.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppCubitState.fromJson(String source) => AppCubitState.fromMap(json.decode(source));

  @override
  String toString() => 'AppCubitState(user: $user, followers: $followers, following: $following)';
}
