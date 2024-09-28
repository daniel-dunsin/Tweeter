import 'dart:convert';

import 'package:client/modules/follow/models/follows_model.dart';

class UserModel {
  final String email;
  final String name;
  final String dateOfBirth;
  final String userName;
  final String profilePicture;
  final String id;
  final String? bio;
  final String? coverPicture;
  final String? website;
  final DateTime createdAt;
  final List<FollowsModel>? followers;
  final List<FollowsModel>? followings;
  final int? tweets;

  UserModel({
    required this.email,
    required this.name,
    required this.dateOfBirth,
    required this.userName,
    required this.profilePicture,
    required this.id,
    this.bio,
    this.coverPicture,
    this.website,
    required this.createdAt,
    this.followers,
    this.followings,
    this.tweets = 0,
  });

  UserModel copyWith({
    String? email,
    String? name,
    String? dateOfBirth,
    String? userName,
    String? profilePicture,
    String? id,
    String? bio,
    String? coverPicture,
    String? website,
    DateTime? createdAt,
    List<FollowsModel>? followers,
    List<FollowsModel>? followings,
    int? tweets,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      userName: userName ?? this.userName,
      profilePicture: profilePicture ?? this.profilePicture,
      id: id ?? this.id,
      bio: bio ?? this.bio,
      coverPicture: coverPicture ?? this.coverPicture,
      website: website ?? this.website,
      createdAt: createdAt ?? this.createdAt,
      followers: followers ?? this.followers,
      followings: followings ?? this.followings,
      tweets: tweets ?? this.tweets,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({
      'email': email
    });
    result.addAll({
      'name': name
    });
    result.addAll({
      'dateOfBirth': dateOfBirth
    });
    result.addAll({
      'userName': userName
    });
    result.addAll({
      'profilePicture': profilePicture
    });
    result.addAll({
      'id': id
    });
    if (bio != null) {
      result.addAll({
        'bio': bio
      });
    }
    if (coverPicture != null) {
      result.addAll({
        'coverPicture': coverPicture
      });
    }
    if (website != null) {
      result.addAll({
        'website': website
      });
    }
    result.addAll({
      'createdAt': createdAt.toIso8601String()
    });
    if (followers != null) {
      result.addAll({
        'followers': followers!.map((x) => x.toMap()).toList()
      });
    }
    if (followings != null) {
      result.addAll({
        'followings': followings!.map((x) => x.toMap()).toList()
      });
    }
    if (tweets != null) {
      result.addAll({
        "tweets": tweets,
      });
    }

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      dateOfBirth: map['dateOfBirth'] ?? '',
      userName: map['userName'] ?? '',
      profilePicture: map['profilePicture'] ?? '',
      id: map['id'] ?? '',
      bio: map['bio'],
      coverPicture: map['coverPicture'],
      website: map['website'],
      createdAt: DateTime.parse(map['createdAt']),
      followers: map['followers'] != null ? List<FollowsModel>.from(map['followers']?.map((x) => FollowsModel.fromMap(x))) : null,
      followings: map['followings'] != null ? List<FollowsModel>.from(map['followings']?.map((x) => FollowsModel.fromMap(x))) : null,
      tweets: map["_count"]?["tweets"] != null ? map["_count"]["tweets"] : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
}
