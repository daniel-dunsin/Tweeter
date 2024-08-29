import 'package:client/config/routes.dart';
import 'package:client/modules/auth/models/user_model.dart';
import 'package:client/modules/follow/repository/follow_repository.dart';
import 'package:client/modules/follow/service/follow_service.dart';
import 'package:client/shared/cubit/app_cubit/app_cubit.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/theme/font.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import "package:flutter_bloc/flutter_bloc.dart";

final navigatorKey = GlobalKey<NavigatorState>();

class App extends StatefulWidget {
  final String initialRoute;
  final UserModel? user;

  App({super.key, required this.initialRoute, this.user});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final mode = TweeterColors.dark();

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _loadAppCubit();
    }
  }

  _loadAppCubit() async {
    final appCubit = context.read<AppCubit>();

    appCubit.setUser(widget.user!);

    final response = await FollowRepository(FollowService()).getUserFollows(widget.user!.id);

    final List<UserModel> followers = (response["data"]["followers"] as List<dynamic>)
        .map(
          (userMap) => UserModel.fromMap(userMap),
        )
        .toList();

    final List<UserModel> following = (response["data"]["followings"] as List<dynamic>)
        .map(
          (userMap) => UserModel.fromMap(userMap),
        )
        .toList();

    appCubit.setFollowers(followers);
    appCubit.setFollowings(following);
  }

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Tweeter',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          textTheme: ThemeData().textTheme.apply(
                fontFamily: FontFamily.poppins,
                bodyColor: mode.secondaryForegroundColor,
              ),
        ).copyWith(
          extensions: [
            mode,
          ],
          scaffoldBackgroundColor: mode.backgroundColor,
          appBarTheme: AppBarTheme().copyWith(
            backgroundColor: mode.backgroundColor,
            foregroundColor: mode.secondaryForegroundColor,
            surfaceTintColor: Colors.transparent,
          ),
        ),
        routes: getRoutes(context),
        initialRoute: widget.initialRoute,
      ),
    );
  }
}
