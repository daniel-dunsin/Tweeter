import 'package:client/modules/tweets/models/create_tweet_media_model.dart';

class SingleCreateTweetModel {
  String? text;
  List<CreateTweetMediaModel> media;

  SingleCreateTweetModel({
    this.text,
    this.media = const [],
  });

  SingleCreateTweetModel copyWith({
    String? text,
    List<CreateTweetMediaModel>? media,
  }) {
    return SingleCreateTweetModel(
      text: text ?? this.text,
      media: media ?? this.media,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'media': media.map((x) => x.toMap()).toList(),
    };
  }
}
