import 'package:client/modules/auth/models/user_model.dart';
import 'package:client/modules/follow/models/follows_model.dart';

List<UserModel> followersToUsers(List<FollowsModel> follows) {
  return follows.map((follow) => follow.follower).toList();
}

List<UserModel> followingsToUsers(List<FollowsModel> follows) {
  return follows.map((follow) => follow.following).toList();
}
