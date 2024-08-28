import 'package:client/modules/profile/models/edit_profile_model.dart';
import 'package:client/modules/profile/services/profile_service.dart';

class ProfileRepository {
  final ProfileService profileService;

  ProfileRepository(this.profileService);

  getUserProfile(String userId) async {
    final response = await this.profileService.getUserProfile(userId);

    return response.data;
  }

  editUserProfile(EditProfileModel editProfileDto) async {
    final response = await this.profileService.editUserProfile(editProfileDto.toMap());

    return response.data;
  }
}
