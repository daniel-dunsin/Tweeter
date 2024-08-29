import 'package:client/modules/auth/models/user_model.dart';

class UserFollowsModel {
  List<UserModel> followers;
  List<UserModel> followings;
  List<UserModel> verifiedFollowers;

  UserFollowsModel({
    required this.followers,
    required this.followings,
    required this.verifiedFollowers,
  });

  factory UserFollowsModel.fromMap(Map<String, dynamic> map) {
    return UserFollowsModel(
      followers: List<UserModel>.from(map['followers']?.map((x) => UserModel.fromMap(x))),
      followings: List<UserModel>.from(map['followings']?.map((x) => UserModel.fromMap(x))),
      verifiedFollowers: List<UserModel>.from(map['verifiedFollowers']?.map((x) => UserModel.fromMap(x))),
    );
  }
}
