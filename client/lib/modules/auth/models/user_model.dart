import 'dart:convert';

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
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(email: $email, name: $name, dateOfBirth: $dateOfBirth, userName: $userName, profilePicture: $profilePicture, id: $id, bio: $bio, coverPicture: $coverPicture, website: $website, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel && other.email == email && other.name == name && other.dateOfBirth == dateOfBirth && other.userName == userName && other.profilePicture == profilePicture && other.id == id && other.bio == bio && other.coverPicture == coverPicture && other.website == website && other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return email.hashCode ^ name.hashCode ^ dateOfBirth.hashCode ^ userName.hashCode ^ profilePicture.hashCode ^ id.hashCode ^ bio.hashCode ^ coverPicture.hashCode ^ website.hashCode ^ createdAt.hashCode;
  }
}
