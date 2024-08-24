import 'package:client/modules/auth/models/user_model.dart';
import 'package:client/shared/constants/localstorage.dart';
import 'package:client/shared/utils/localstorage.dart';

Future<UserModel> getUserFromLocalStorage() async {
  final user = await LocalStorage.getString(key: localStorageConstants.user);

  return UserModel.fromJson(user!);
}
