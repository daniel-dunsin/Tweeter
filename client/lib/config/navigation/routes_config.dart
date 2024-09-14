import 'package:client/config/navigation/routes_constants.dart';
import 'package:client/modules/auth/routes/forgot_password/enter_forgot_password_code.dart';
import 'package:client/modules/auth/routes/forgot_password/forgot_password.dart';
import 'package:client/modules/auth/routes/forgot_password/reset_password.dart';
import 'package:client/modules/auth/routes/login/enter_login_password.dart';
import 'package:client/modules/auth/routes/login/login.dart';
import 'package:client/modules/auth/routes/select_sign_up/select_sign_up.dart';
import 'package:client/modules/auth/routes/onboarding/sign_up.dart';
import 'package:client/modules/auth/routes/onboarding/update_profile_picture.dart';
import 'package:client/modules/auth/routes/onboarding/verify_account.dart';
import 'package:client/modules/auth/routes/onboarding/select_interests.dart';
import 'package:client/modules/follow/routes/follows/follows.dart';
import 'package:client/modules/home/routes/root.dart';
import 'package:client/modules/profile/routes/user_profile/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static GoRouter initRouter({required String initialLocation}) {
    return GoRouter(
      navigatorKey: appNavKey,
      initialLocation: initialLocation,
      routes: [
        GoRoute(
          path: AuthRoutes.signUpInitial,
          name: AuthRoutes.signUpInitial,
          pageBuilder: (_, state) {
            return const MaterialPage(
              child: SelectSignUpScreen(),
            );
          },
        ),
        GoRoute(
          path: AuthRoutes.signUp,
          name: AuthRoutes.signUp,
          pageBuilder: (_, state) {
            return const MaterialPage(
              child: SignUpScreen(),
            );
          },
        ),
        GoRoute(
          path: AuthRoutes.login,
          name: AuthRoutes.login,
          pageBuilder: (_, state) {
            return const MaterialPage(
              child: LoginScreen(),
            );
          },
        ),
        GoRoute(
          path: AuthRoutes.loginPassword,
          name: AuthRoutes.loginPassword,
          pageBuilder: (_, state) {
            Map args = state.extra as Map;
            return MaterialPage(
              child: EnterLoginPasswordScreen(
                credential: args["credential"]!,
              ),
            );
          },
        ),
        GoRoute(
          path: AuthRoutes.forgotPassword,
          name: AuthRoutes.forgotPassword,
          pageBuilder: (_, state) {
            return const MaterialPage(
              child: ForgotPasswordScreen(),
            );
          },
        ),
        GoRoute(
          path: AuthRoutes.forgotPasswordCode,
          name: AuthRoutes.forgotPasswordCode,
          pageBuilder: (_, state) {
            return const MaterialPage(
              child: EnterForgotPasswordCodeScreen(),
            );
          },
        ),
        GoRoute(
          path: AuthRoutes.resetPassword,
          name: AuthRoutes.resetPassword,
          pageBuilder: (_, state) {
            final Map args = state.extra as Map;
            return MaterialPage(
              child: ResetPasswordScreen(code: args["code"]!),
            );
          },
        ),
        GoRoute(
          path: AuthRoutes.verifyEmail,
          name: AuthRoutes.verifyEmail,
          pageBuilder: (_, state) {
            Map args = state.extra as Map;
            return MaterialPage(
              child: VerifyAccountScreen(email: args["email"]!),
            );
          },
        ),
        GoRoute(
          path: AuthRoutes.selectInterests,
          name: AuthRoutes.selectInterests,
          pageBuilder: (_, state) {
            return const MaterialPage(
              child: SelectInterestScreen(),
            );
          },
        ),
        GoRoute(
          path: AuthRoutes.updateDp,
          name: AuthRoutes.updateDp,
          pageBuilder: (_, state) {
            return const MaterialPage(
              child: UpdateProfilePictureScreen(),
            );
          },
        ),
        GoRoute(
          path: PrivateRoutes.rootHome,
          name: PrivateRoutes.rootHome,
          pageBuilder: (_, state) {
            return const MaterialPage(
              child: RootHome(),
            );
          },
        ),
        GoRoute(
          path: PrivateRoutes.profile,
          name: PrivateRoutes.profile,
          pageBuilder: (_, state) {
            Map args = state.extra as Map;

            return MaterialPage(
              child: UserProfileScreen(
                userId: args["userId"]!,
              ),
            );
          },
        ),
        GoRoute(
          path: PrivateRoutes.follows,
          name: PrivateRoutes.follows,
          pageBuilder: (_, state) {
            Map args = state.extra as Map;

            return MaterialPage(
              child: FollowsScreen(
                tab: args["tab"],
                user: args["user"],
              ),
            );
          },
        ),
      ],
    );
  }
}
