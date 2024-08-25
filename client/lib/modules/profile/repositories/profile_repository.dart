import 'package:client/modules/profile/services/profile_service.dart';

class ProfileRepository {
  final ProfileService profileService;

  ProfileRepository(this.profileService);

  getUserProfile(String userId) async {
    final response = await this.profileService.getUserProfile(userId);

    return response.data;
  }
}
