import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/modules/tweets/enums/index.dart';
import 'package:client/modules/tweets/models/tweet_media_model.dart';
import 'package:client/shared/cubit/app_cubit/app_cubit.dart';
import 'package:client/shared/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TweetMedia extends StatelessWidget {
  final TweetMediaModel tweetMedia;
  const TweetMedia({super.key, required this.tweetMedia});

  @override
  Widget build(BuildContext context) {
    final isLightMode = context.read<AppCubit>().state.isLightMode;

    switch (tweetMedia.type) {
      case TweetMediaType.gif:
      case TweetMediaType.image:
        return CachedNetworkImage(
          imageUrl: tweetMedia.url,
          width: double.maxFinite,
          height: double.maxFinite,
          fit: BoxFit.cover,
          progressIndicatorBuilder: (context, _, __) => Shimmer.fromColors(
            child: ColoredBox(
              color: Colors.red,
              child: Container(
                width: double.maxFinite,
                height: double.maxFinite,
              ),
            ),
            baseColor: isLightMode ? Colors.grey.shade300 : Colors.grey.shade700,
            highlightColor: isLightMode ? Colors.grey.shade500 : Colors.grey.shade900,
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
