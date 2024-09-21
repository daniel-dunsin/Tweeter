import 'package:client/shared/cubit/app_cubit/app_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class CreateTweetHeader extends StatelessWidget {
  const CreateTweetHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppCubit>().state.user!;

    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(user.profilePicture),
        )
      ],
    );
  }
}
