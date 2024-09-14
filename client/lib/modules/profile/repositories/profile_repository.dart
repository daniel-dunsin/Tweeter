import 'package:client/modules/profile/models/edit_profile_model.dart';
import 'package:client/modules/profile/services/profile_service.dart';

class ProfileRepository {
  final ProfileService profileService;

  ProfileRepository(this.profileService);

  getUserProfile(String userId) async {
    final response = await profileService.getUserProfile(userId);

    return response.data;
  }

  editUserProfile(EditProfileModel editProfileDto) async {
    final response = await profileService.editUserProfile(editProfileDto.toMap());

    return response.data;
  }

  deleteProfilePicture() async {
    final response = await profileService.deleteProfilePicture();

    return response.data;
  }

  deleteCoverPicture() async {
    final response = await profileService.deleteCoverPicture();

    return response.data;
  }
}
