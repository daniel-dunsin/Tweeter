import 'package:client/config/navigation/routes_constants.dart';
import 'package:client/modules/auth/routes/forgot_password/enter_forgot_password_code.dart';
import 'package:client/modules/auth/routes/forgot_password/forgot_password.dart';
import 'package:client/modules/auth/routes/forgot_password/reset_password.dart';
import 'package:client/modules/auth/routes/login/enter_login_password.dart';
import 'package:client/modules/auth/routes/login/login.dart';
import 'package:client/modules/auth/routes/login/reactivate_account.dart';
import 'package:client/modules/auth/routes/select_sign_up/select_sign_up.dart';
import 'package:client/modules/auth/routes/onboarding/sign_up.dart';
import 'package:client/modules/auth/routes/onboarding/update_profile_picture.dart';
import 'package:client/modules/auth/routes/onboarding/verify_account.dart';
import 'package:client/modules/auth/routes/onboarding/select_interests.dart';
import 'package:client/modules/follow/routes/follows/follows.dart';
import 'package:client/modules/home/routes/communities/communities.dart';
import 'package:client/modules/home/routes/home/home.dart';
import 'package:client/modules/home/routes/messages/messages.dart';
import 'package:client/modules/home/routes/notifications/notifications.dart';
import 'package:client/modules/home/routes/root.dart';
import 'package:client/modules/home/routes/search/search.dart';
import 'package:client/modules/profile/routes/user_profile/user_profile.dart';
import 'package:client/modules/root.dart';
import 'package:client/modules/settings/routes/purchases/purchases.dart';
import 'package:client/modules/settings/routes/settings/account_settings/account_information/account_information.dart';
import 'package:client/modules/settings/routes/settings/account_settings/account_information/update_email/update_email.dart';
import 'package:client/modules/settings/routes/settings/account_settings/account_information/update_username/update_username.dart';
import 'package:client/modules/settings/routes/settings/account_settings/account_information/verify_password/verify_password.dart';
import 'package:client/modules/settings/routes/settings/account_settings/account_settings.dart';
import 'package:client/modules/settings/routes/settings/account_settings/change_password/change_password.dart';
import 'package:client/modules/settings/routes/settings/account_settings/deactivate_account/deactivate_account.dart';
import 'package:client/modules/settings/routes/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter appRouter = GoRouter(
  navigatorKey: appNavKey,
  routes: [
    GoRoute(
      path: "/",
      name: "/",
      pageBuilder: (_, state) {
        return const MaterialPage(
          child: AppRoot(),
        );
      },
    ),
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
      path: AuthRoutes.reactivateAccount,
      name: AuthRoutes.reactivateAccount,
      pageBuilder: (_, state) {
        Map args = state.extra as Map;
        return MaterialPage(
          child: ReactivateAccountScreen(
            deactivatedAt: args["deactivatedAt"]!,
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
    StatefulShellRoute.indexedStack(
      pageBuilder: (context, state, shell) {
        return MaterialPage(child: RootHome(shell: shell));
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: PrivateRoutes.home,
              name: PrivateRoutes.home,
              pageBuilder: (context, state) {
                return const MaterialPage(child: HomeScreen());
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
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: PrivateRoutes.search,
              name: PrivateRoutes.search,
              pageBuilder: (context, state) => const MaterialPage(
                child: SearchScreen(),
              ),
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
            GoRoute(
              path: PrivateRoutes.purchases,
              name: PrivateRoutes.purchases,
              pageBuilder: (context, state) {
                return const MaterialPage(child: PurchasesScreen());
              },
            ),
            GoRoute(
              path: PrivateRoutes.settings,
              name: PrivateRoutes.settings,
              pageBuilder: (context, state) {
                return const MaterialPage(child: SettingsScreen());
              },
            ),
            GoRoute(
              path: PrivateRoutes.accountSettings,
              name: PrivateRoutes.accountSettings,
              pageBuilder: (context, state) {
                return const MaterialPage(child: AccountSettingsScreen());
              },
            ),
            GoRoute(
              path: PrivateRoutes.accountInformation,
              name: PrivateRoutes.accountInformation,
              pageBuilder: (context, state) {
                return const MaterialPage(child: AccountInformationScreen());
              },
            ),
            GoRoute(
              path: PrivateRoutes.changePassword,
              name: PrivateRoutes.changePassword,
              pageBuilder: (context, state) {
                return const MaterialPage(child: ChangePasswordScreen());
              },
            ),
            GoRoute(
              path: PrivateRoutes.deactivateAccount,
              name: PrivateRoutes.deactivateAccount,
              pageBuilder: (context, state) {
                return const MaterialPage(child: DeactivateAccountScreen());
              },
            ),
            GoRoute(
              path: PrivateRoutes.updateEmail,
              name: PrivateRoutes.updateEmail,
              pageBuilder: (context, state) {
                return const MaterialPage(child: UpdateEmailScreen());
              },
            ),
            GoRoute(
              path: PrivateRoutes.updateUserName,
              name: PrivateRoutes.updateUserName,
              pageBuilder: (context, state) {
                return const MaterialPage(child: UpdateUsernameScreen());
              },
            ),
            GoRoute(
              path: PrivateRoutes.verifyPassword,
              name: PrivateRoutes.verifyPassword,
              pageBuilder: (context, state) {
                Map args = state.extra as Map;
                return MaterialPage(
                  child: VerifyPassword(nextRoute: args["nextRoute"]!),
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: PrivateRoutes.communities,
              name: PrivateRoutes.communities,
              pageBuilder: (context, state) => const MaterialPage(
                child: CommunitiesScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: PrivateRoutes.notifications,
              name: PrivateRoutes.notifications,
              pageBuilder: (context, state) => const MaterialPage(
                child: NotificationsScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: PrivateRoutes.chat,
              name: PrivateRoutes.chat,
              pageBuilder: (context, state) => const MaterialPage(
                child: MessagesScreen(),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);

extension AppRouterExtension on GoRouter {
  GoRouter copyWith({required String initialLocation}) {
    return GoRouter(
      initialLocation: initialLocation,
      routes: appRouter.configuration.routes,
      navigatorKey: appRouter.configuration.navigatorKey,
    );
  }
}
