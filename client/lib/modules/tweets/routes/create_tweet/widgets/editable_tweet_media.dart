import 'package:client/modules/tweets/enums/index.dart';
import 'package:client/modules/tweets/models/create_tweet_media_model.dart';
import 'package:client/modules/tweets/routes/create_tweet/widgets/editable_tweet_overlay.dart';
import 'package:client/modules/tweets/routes/create_tweet/widgets/tweet_audio_player.dart';
import 'package:client/modules/tweets/routes/create_tweet/widgets/tweet_video_player.dart';
import 'package:client/shared/widgets/cached_image.dart';
import 'package:flutter/cupertino.dart';

class EditableTweetMedia extends StatelessWidget {
  final int index;
  final CreateTweetMediaModel? tweetMediaModel;

  const EditableTweetMedia({
    super.key,
    this.tweetMediaModel,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    if (tweetMediaModel == null || (tweetMediaModel!.type == TweetMediaType.gif && tweetMediaModel!.url == null) || (tweetMediaModel!.type != TweetMediaType.gif && tweetMediaModel!.file == null)) {
      return const SizedBox();
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        child: Builder(
          builder: (context) {
            switch (tweetMediaModel!.type) {
              case TweetMediaType.gif:
                return Stack(
                  children: [
                    CachedImage(
                      url: tweetMediaModel!.url!,
                      width: double.maxFinite,
                      height: double.maxFinite,
                    ),
                    EditableTweetMediaOverlay(mediaIndex: index),
                  ],
                );

              case TweetMediaType.image:
                return Stack(
                  children: [
                    Image(
                      image: AssetImage(tweetMediaModel!.file?.path ?? ""),
                      width: double.maxFinite,
                      height: double.maxFinite,
                      fit: BoxFit.cover,
                    ),
                    EditableTweetMediaOverlay(mediaIndex: index),
                  ],
                );

              case TweetMediaType.audio:
                return Stack(
                  children: [
                    TweetAudioPlayer(file: tweetMediaModel!.file),
                    EditableTweetMediaOverlay(mediaIndex: index),
                  ],
                );

              case TweetMediaType.video:
                return EditableTweetVideoPlayer(
                  file: tweetMediaModel!.file!,
                  index: index,
                );
            }
          },
        ),
      ),
    );
  }
}
