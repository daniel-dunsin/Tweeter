import 'package:client/modules/tweets/routes/create_tweet/models/create_tweet_location_model.dart';
import 'package:client/modules/tweets/routes/create_tweet/models/single_create_tweet_model.dart';

class CreateTweetModel {
  final List<SingleCreateTweetModel> tweets;
  final CreateTweetLocationModel? location;

  CreateTweetModel({
    required this.tweets,
    this.location,
  });

  CreateTweetModel copyWith({
    List<SingleCreateTweetModel>? tweets,
    CreateTweetLocationModel? location,
  }) {
    return CreateTweetModel(
      tweets: tweets ?? this.tweets,
      location: location ?? this.location,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tweets': tweets.map((x) => x.toMap()).toList(),
      'location': location?.toMap(),
    };
  }
}
