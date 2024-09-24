import 'package:client/modules/tweets/enums/index.dart';
import 'package:client/modules/tweets/routes/create_tweet/models/create_tweet_media_model.dart';
import 'package:flutter/cupertino.dart';

class EditableTweetMedia extends StatelessWidget {
  final CreateTweetMediaModel? tweetMediaModel;

  const EditableTweetMedia({
    super.key,
    this.tweetMediaModel,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
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
                return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
