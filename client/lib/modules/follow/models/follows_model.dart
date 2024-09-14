import 'dart:convert';

import 'package:client/modules/auth/models/user_model.dart';

class FollowsModel {
  String id;
  DateTime createdAt;
  UserModel follower;
  UserModel following;

  FollowsModel({
    required this.id,
    required this.createdAt,
    required this.follower,
    required this.following,
  });

  FollowsModel copyWith({
    String? id,
    DateTime? createdAt,
    UserModel? follower,
    UserModel? following,
  }) {
    return FollowsModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      follower: follower ?? this.follower,
      following: following ?? this.following,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({
      'id': id
    });
    result.addAll({
      'createdAt': createdAt.millisecondsSinceEpoch
    });
    result.addAll({
      'follower': follower.toMap()
    });
    result.addAll({
      'following': following.toMap()
    });

    return result;
  }

  factory FollowsModel.fromMap(Map<String, dynamic> map) {
    return FollowsModel(
      id: map['id'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
      follower: UserModel.fromMap(map['follower']),
      following: UserModel.fromMap(map['following']),
    );
  }

  String toJson() => json.encode(toMap());

  factory FollowsModel.fromJson(String source) => FollowsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FollowsModel(id: $id, createdAt: $createdAt, follower: $follower, following: $following)';
  }
}
