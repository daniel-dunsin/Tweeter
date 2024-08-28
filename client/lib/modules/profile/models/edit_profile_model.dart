import 'dart:convert';
import 'dart:io';

import 'package:client/shared/utils/file.dart';

class EditProfileModel {
  final File? coverPicture;
  final File? profilePicture;
  final String? name;
  final String? bio;
  final String? website;

  EditProfileModel({
    this.coverPicture,
    this.profilePicture,
    this.name,
    this.bio,
    this.website,
  });

  EditProfileModel copyWith({
    File? coverPicture,
    File? profilePicture,
    String? name,
    String? bio,
    String? website,
  }) {
    return EditProfileModel(
      coverPicture: coverPicture ?? this.coverPicture,
      profilePicture: profilePicture ?? this.profilePicture,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      website: website ?? this.website,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (coverPicture != null) {
      result.addAll({
        'coverPicture': convertImageToBase64(coverPicture!)
      });
    }
    if (profilePicture != null) {
      result.addAll({
        'profilePicture': convertImageToBase64(profilePicture!)
      });
    }
    if (name != null) {
      result.addAll({
        'name': name
      });
    }
    if (bio != null) {
      result.addAll({
        'bio': bio
      });
    }
    if (website != null) {
      result.addAll({
        'website': website
      });
    }

    return result;
  }

  factory EditProfileModel.fromMap(Map<String, dynamic> map) {
    return EditProfileModel(
      coverPicture: map['coverPicture'] != null ? convertBase64ToImage(map["coverPicture"]!) : null,
      profilePicture: map['profilePicture'] != null ? convertBase64ToImage(map['profilePicture']!) : null,
      name: map['name'],
      bio: map['bio'],
      website: map['website'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EditProfileModel.fromJson(String source) => EditProfileModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EditProfileModel(coverPicture: $coverPicture, profilePicture: $profilePicture, name: $name, bio: $bio, website: $website)';
  }
}
