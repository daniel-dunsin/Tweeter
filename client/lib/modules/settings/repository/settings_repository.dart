import 'package:client/modules/settings/models/change_password_model.dart';
import 'package:client/modules/settings/services/settings_service.dart';

class SettingsRepository {
  final SettingsService settingsService;

  SettingsRepository(this.settingsService);

  deactivateAccount() async {
    final response = await this.settingsService.deactivateAccount();

    return response.data;
  }

  changePassword(ChangePasswordModel changePasswordDto) async {
    final response = await this.settingsService.changePassword(changePasswordDto.toMap());

    return response.data;
  }

  signOut() async {
    final response = await this.settingsService.signOut();

    return response.data;
  }

  updateUserName(String userName) async {
    final response = await this.settingsService.updateUserName(userName);

    return response.data;
  }

  updateEmail(String email) async {
    final response = await this.settingsService.updateUserEmail(email);

    return response.data;
  }

  verifyPassword(String password) async {
    final response = await this.settingsService.verifyPassword(password);

    return response.data;
  }
}
