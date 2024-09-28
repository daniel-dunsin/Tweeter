import 'package:client/shared/cubit/app_cubit/app_cubit.dart';
import 'package:client/shared/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TweetShimmer extends StatelessWidget {
  const TweetShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final isLightMode = context.watch<AppCubit>().state.isLightMode;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: Shimmer.fromColors(
          baseColor: isLightMode ? Colors.grey.shade300 : Colors.grey.shade700,
          highlightColor: isLightMode ? Colors.grey.shade500 : Colors.grey.shade900,
          enabled: true,
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(radius: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      width: double.maxFinite,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Container(
                width: double.maxFinite,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.maxFinite,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
