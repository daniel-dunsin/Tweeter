import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/modules/tweets/models/tweet_list_model.dart';
import 'package:client/modules/tweets/widgets/tweet_media.dart';
import 'package:client/modules/tweets/widgets/tweet_media_grid.dart';
import 'package:client/shared/theme/colors.dart';
import 'package:client/shared/utils/misc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class SingleTweet extends StatelessWidget {
  final TweetListModel tweet;
  const SingleTweet({
    super.key,
    required this.tweet,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            minTileHeight: 30,
            leading: CircleAvatar(
              radius: 20,
              backgroundImage: CachedNetworkImageProvider(
                tweet.tweeter.profilePicture,
              ),
            ),
            titleAlignment: ListTileTitleAlignment.top,
            isThreeLine: true,
            title: RichText(
              text: TextSpan(children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Text(
                    "${tweet.tweeter.name}",
                    style: TextStyle(
                      fontSize: 12.h,
                      color: appColors.foregroundColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const WidgetSpan(child: SizedBox(width: 8)),
                WidgetSpan(
                  alignment: PlaceholderAlignment.top,
                  child: Text(
                    "@${tweet.tweeter.userName}",
                    style: TextStyle(
                      fontSize: 8.h,
                      color: appColors.secondaryForegroundColor,
                    ),
                  ),
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.top,
                  child: Text(
                    ". ${formatTimeDifference((DateTime.now().difference(tweet.createdAt)))}",
                    style: TextStyle(
                      fontSize: 7.8.h,
                      color: appColors.secondaryForegroundColor,
                    ),
                  ),
                )
              ]),
            ),
            subtitle: Text(
              tweet.text,
              style: TextStyle(
                fontSize: 11.h,
                color: appColors.foregroundColor,
              ),
            ),
          ),
          ...(tweet.media.isNotEmpty
              ? [
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: TweetMediaGrid(
                      mediaList: [
                        for (int i = 0; i < tweet.media.length; i++)
                          TweetMedia(
                            tweetMedia: tweet.media[i],
                          )
                      ],
                    ),
                  )
                ]
              : []),
        ],
      ),
    );
  }
}
