import 'package:client/modules/tweets/enums/index.dart';
import 'package:client/modules/tweets/routes/create_tweet/models/create_tweet_media_model.dart';
import 'package:client/modules/tweets/routes/create_tweet/widgets/editable_tweet_overlay.dart';
import 'package:client/modules/tweets/routes/create_tweet/widgets/tweet_video_player.dart';
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          Container(
            child: Builder(
              builder: (context) {
                switch (tweetMediaModel!.type) {
                  case TweetMediaType.gif:
                    return Image(
                      image: NetworkImage(tweetMediaModel!.file!.path),
                      width: double.maxFinite,
                      height: double.maxFinite,
                      fit: BoxFit.cover,
                    );

                  case TweetMediaType.image:
                    return Image(
                      image: AssetImage(tweetMediaModel!.file!.path),
                      width: double.maxFinite,
                      height: double.maxFinite,
                      fit: BoxFit.cover,
                    );

                  case TweetMediaType.audio:
                    return SizedBox();

                  case TweetMediaType.video:
                    return EditableTweetVideoPlayer(file: tweetMediaModel!.file!);
                    ;
                }
              },
            ),
          ),
          EditableTweetMediaOverlay(mediaIndex: index)
        ],
      ),
    );
  }
}
