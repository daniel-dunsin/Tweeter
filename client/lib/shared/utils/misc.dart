import 'package:client/modules/auth/models/user_model.dart';
import 'package:client/shared/constants/localstorage.dart';
import 'package:client/shared/utils/localstorage.dart';
import 'package:client/shared/utils/network.dart';
import 'package:url_launcher/url_launcher.dart';

Future<UserModel> getUserFromLocalStorage() async {
  final user = await LocalStorage.getString(key: localStorageConstants.user);

  return UserModel.fromJson(user!);
}

void openUrl(String url) async {
  try {
    final Uri _url = Uri.parse(url);

    if (!await launchUrl(_url)) {
      throw Exception("Could not launch $_url");
    }
  } catch (e) {
    handleError(e: e);
  }
}

String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));

  return duration.inHours > 0 ? "$hours:$minutes:$seconds" : "$minutes:$seconds";
}
