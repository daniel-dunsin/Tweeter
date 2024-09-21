import 'package:client/config/navigation/routes_constants.dart';
import 'package:client/modules/auth/bloc/auth_bloc.dart';
import 'package:client/modules/auth/bloc/auth_event.dart';
import 'package:client/modules/auth/bloc/auth_state.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/widgets/app_cover.dart';
import 'package:client/shared/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ReactivateAccountScreen extends StatelessWidget {
  final DateTime deactivatedAt;

  const ReactivateAccountScreen({super.key, required this.deactivatedAt});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;

    return AppCover(
      child: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is ReActivateAccountSuccess) {
              GoRouter.of(context).push(PrivateRoutes.home);
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Reactivate your account?",
                  style: TextStyle(
                    fontSize: 22.h,
                    fontWeight: FontWeight.bold,
                    color: appColors.foregroundColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'You deactivated your account on ${DateFormat.yMMMd().format(deactivatedAt)}.\nOn ${DateFormat.yMMMd().format(
                    DateTime(
                      deactivatedAt.month == 12 ? deactivatedAt.year + 1 : deactivatedAt.year,
                      deactivatedAt.month + 1,
                      deactivatedAt.day,
                    ),
                  )}, it will no longer be possible for you to restore your X account if it was accidentally or wrongfully deactivated.\n\nBy clicking "Yes, reactivate", you will halt the deactivation process and reactivate your account.',
                ),
                const SizedBox(height: 30),
                ContainedButton(
                  child: const Text("Yes, reactivate"),
                  onPressed: () {
                    context.read<AuthBloc>().add(ReactivateAccountRequested());
                  },
                  fullWidth: true,
                  loading: state is ReActivateAccountLoading,
                  disabled: state is ReActivateAccountLoading,
                ),
                const SizedBox(height: 15),
                SecondaryButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    GoRouter.of(context).pop();
                  },
                  fullWidth: true,
                  disabled: state is ReActivateAccountLoading,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
