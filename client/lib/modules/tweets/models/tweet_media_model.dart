import 'package:client/modules/tweets/enums/index.dart';

class TweetMediaModel {
  TweetMediaType type;
  String url;
  String? publicId;

  TweetMediaModel({
    required this.type,
    required this.url,
    this.publicId,
  });

  factory TweetMediaModel.fromMap(map) {
    return TweetMediaModel(
      type: TweetMediaType.values.firstWhere((v) => v.name == map['type']),
      url: map['url'] as String,
      publicId: map['publicId'] != null ? map['publicId'] as String : null,
    );
  }
}
