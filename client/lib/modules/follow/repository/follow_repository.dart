import 'package:client/modules/follow/service/follow_service.dart';

class FollowRepository {
  final FollowService followService;

  FollowRepository(this.followService);

  getUserFollows(String userId) async {
    final response = await followService.getUserFollows(userId);

    return response.data;
  }

  getSuggestedFollows() async {
    final response = await followService.getSuggestedUsers();

    return response.data;
  }
}
