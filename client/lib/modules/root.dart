import 'dart:convert';
import 'package:client/config/navigation/routes_constants.dart';
import 'package:client/modules/auth/models/user_model.dart';
import 'package:client/modules/auth/repository/auth_repository.dart';
import 'package:client/modules/auth/services/auth_service.dart';
import 'package:client/modules/profile/utils/profile_utils.dart';
import 'package:client/shared/constants/localstorage.dart';
import 'package:client/shared/cubit/app_cubit/app_cubit.dart';
import 'package:client/shared/utils/localstorage.dart';
import 'package:client/shared/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

Future<Map<String, dynamic>> getInitialRoute() async {
  String? initialRoute;
  UserModel? user;

  try {
    final accessToken = await LocalStorage.getString(key: localStorageConstants.accessToken);

    if (accessToken != null) {
      final response = await AuthRepository(AuthService()).getUser();

      final userMap = response["data"];
      if (userMap != null) {
        await LocalStorage.setString(key: localStorageConstants.user, value: jsonEncode(userMap));
        initialRoute = PrivateRoutes.home;
        user = UserModel.fromMap(userMap);
      } else {
        initialRoute = AuthRoutes.signUpInitial;
        await LocalStorage.removeEntry(key: localStorageConstants.accessToken);
      }
    } else {
      initialRoute = AuthRoutes.signUpInitial;
      await LocalStorage.removeEntry(key: localStorageConstants.accessToken);
    }
  } catch (e) {
    print(e);
    initialRoute = AuthRoutes.signUpInitial;
    await LocalStorage.removeEntry(key: localStorageConstants.accessToken);
  } finally {
    FlutterNativeSplash.remove();
  }

  return {
    "initialRoute": initialRoute,
    "user": user
  };
}

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  @override
  void initState() {
    super.initState();

    _loadAppCubit();
  }

  _loadAppCubit() async {
    final {
      "initialRoute": initialRoute,
      "user": user as UserModel?
    } = await getInitialRoute();

    if (user != null) {
      final appCubit = context.read<AppCubit>();

      appCubit.setUser(user);
      appCubit.setFollowers(followersToUsers(user.followers ?? []));
      appCubit.setFollowings(followingsToUsers(user.followings ?? []));
    }

    GoRouter.of(context).goNamed(initialRoute);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Logo(),
      ),
    );
  }
}
