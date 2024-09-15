import 'package:client/config/navigation/routes_constants.dart';
import 'package:client/modules/settings/models/settings_tile_model.dart';
import 'package:flutter/material.dart';

List<SettingsTileModel> settingsRoute = [
  SettingsTileModel(
    icon: Icons.person_outlined,
    title: "Your Account",
    description: "See information about your account, download an archive of your data, or learn about your account deactivation options.",
    route: PrivateRoutes.accountSettings,
  ),
  SettingsTileModel(
    icon: Icons.lock_outline,
    title: "Security and account access",
    description: "Manage your account's security and keep track of your account's usage including apps that you have connected to your account.",
  ),
  SettingsTileModel(
    icon: Icons.money_outlined,
    title: "Monetization",
    description: "See how you can make money on X and manage your monetization options",
  ),
  SettingsTileModel(
    icon: Icons.workspace_premium_outlined,
    title: "Premium",
    description: "Manage your subscription features including Undo post timing",
  ),
  SettingsTileModel(
    icon: Icons.view_timeline_outlined,
    title: "Timeline Settings",
    description: "Configure timeline settings, reorder home screen tabs",
  ),
  SettingsTileModel(
    icon: Icons.privacy_tip_outlined,
    title: "Privacy and Safety",
    description: "Manage what information you see and share on Tweeter.",
  ),
  SettingsTileModel(
    icon: Icons.notifications_outlined,
    title: "Notifications",
    description: "Select the kind of notifications you get about your activities, interests and recommendations.",
  ),
];

List<SettingsTileModel> accountSettingsRoutes = [
  SettingsTileModel(
    icon: Icons.person_outlined,
    title: "Account Information",
    description: "See your account information like your phone number and email address.",
    route: PrivateRoutes.accountInformation,
  ),
  SettingsTileModel(
    icon: Icons.key_outlined,
    title: "Change your password",
    description: "Change your password at any time.",
    route: PrivateRoutes.changePassword,
  ),
  SettingsTileModel(
    icon: Icons.download_outlined,
    title: "Download an archive of your data",
    description: "Get insights into the type of information stored for your account.",
  ),
  SettingsTileModel(
    icon: Icons.heart_broken_outlined,
    title: "Deactivate your account",
    description: "Find out how you can deactivate your account.",
    route: PrivateRoutes.deactivateAccount,
  ),
];
