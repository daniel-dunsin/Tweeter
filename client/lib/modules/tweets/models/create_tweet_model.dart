import 'package:client/modules/tweets/models/single_create_tweet_model.dart';

class CreateTweetModel {
  List<SingleCreateTweetModel> tweets;
  int position;

  CreateTweetModel({
    required this.tweets,
    this.position = 0,
  });

  CreateTweetModel copyWith({
    List<SingleCreateTweetModel>? tweets,
    int? position,
  }) {
    return CreateTweetModel(
      tweets: tweets ?? this.tweets,
      position: position ?? this.position,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tweets': tweets.map((x) => x.toMap()).toList(),
    };
  }
}
