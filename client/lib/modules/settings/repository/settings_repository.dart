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
}
