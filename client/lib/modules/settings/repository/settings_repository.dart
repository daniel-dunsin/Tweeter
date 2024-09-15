import 'package:client/modules/settings/services/settings_service.dart';

class SettingsRepository {
  final SettingsService settingsService;

  SettingsRepository(this.settingsService);

  deactivateAccount() async {
    final response = await this.settingsService.deactivateAccount();

    return response.data;
  }
}
