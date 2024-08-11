import 'dart:convert';

class UserModel {
  final String email;
  final String name;
  final String dateOfBirth;
  final String userName;
  final String profilePicture;
  final String id;

  UserModel({
    required this.email,
    required this.name,
    required this.dateOfBirth,
    required this.userName,
    required this.profilePicture,
    required this.id,
  });

  UserModel copyWith({
    String? email,
    String? name,
    String? dateOfBirth,
    String? userName,
    String? profilePicture,
    String? id,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      userName: userName ?? this.userName,
      profilePicture: profilePicture ?? this.profilePicture,
      id: id ?? this.id,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
}
