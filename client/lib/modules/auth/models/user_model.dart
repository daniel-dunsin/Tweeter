import 'dart:convert';

import 'package:collection/collection.dart';

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
  final List<UserModel>? followers;
  final List<UserModel>? followings;

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
    List<UserModel>? followers,
    List<UserModel>? followings,
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
      'createdAt': createdAt.millisecondsSinceEpoch
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
      followers: map['followers'] != null ? List<UserModel>.from(map['followers']?.map((x) => UserModel.fromMap(x))) : null,
      followings: map['followings'] != null ? List<UserModel>.from(map['followings']?.map((x) => UserModel.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
}
