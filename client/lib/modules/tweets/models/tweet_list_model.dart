import 'package:client/modules/auth/models/user_model.dart';
import 'package:client/modules/tweets/models/hashtags_model.dart';
import 'package:client/modules/tweets/models/tweet_media_model.dart';
import 'package:client/modules/tweets/models/tweet_mentions_model.dart';

class TweetListModel {
  String id;
  bool isPinned;
  String text;
  DateTime createdAt;
  String tweeterId;
  List<TweetMediaModel> media;
  int likersCount;
  int retweetersCount;
  int childTweetsCount;
  int bookmarkersCount;
  List<TweetMentionsModel> mentions;
  List<HashtagsModel> hashTags;
  UserModel tweeter;
  TweetListModel? quotedTweet;
  TweetListModel? parentTweet;

  TweetListModel({
    required this.id,
    required this.isPinned,
    required this.text,
    required this.createdAt,
    required this.tweeterId,
    required this.media,
    required this.likersCount,
    required this.retweetersCount,
    required this.childTweetsCount,
    required this.bookmarkersCount,
    required this.mentions,
    required this.hashTags,
    required this.tweeter,
    this.quotedTweet,
    this.parentTweet,
  });

  TweetListModel copyWith({
    String? id,
    bool? isPinned,
    String? text,
    DateTime? createdAt,
    String? tweeterId,
    List<TweetMediaModel>? media,
    int? likersCount,
    int? retweetersCount,
    int? childTweetsCount,
    int? bookmarkersCount,
    List<TweetMentionsModel>? mentions,
    List<HashtagsModel>? hashTags,
    UserModel? tweeter,
    TweetListModel? quotedTweet,
    TweetListModel? parentTweet,
  }) {
    return TweetListModel(
      id: id ?? this.id,
      isPinned: isPinned ?? this.isPinned,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
      tweeterId: tweeterId ?? this.tweeterId,
      media: media ?? this.media,
      likersCount: likersCount ?? this.likersCount,
      retweetersCount: retweetersCount ?? this.retweetersCount,
      childTweetsCount: childTweetsCount ?? this.childTweetsCount,
      bookmarkersCount: bookmarkersCount ?? this.bookmarkersCount,
      mentions: mentions ?? this.mentions,
      hashTags: hashTags ?? this.hashTags,
      tweeter: tweeter ?? this.tweeter,
      quotedTweet: quotedTweet ?? this.quotedTweet,
      parentTweet: parentTweet ?? this.parentTweet,
    );
  }

  factory TweetListModel.fromMap(Map<String, dynamic> map) {
    return TweetListModel(
      id: map['id'] as String,
      isPinned: map['isPinned'] as bool,
      text: map['text'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      tweeterId: map['tweeterId'] as String,
      media: List<TweetMediaModel>.from(
        (map['media'] as List<int>).map<TweetMediaModel>(
          (x) => TweetMediaModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      likersCount: map['likersCount'] as int,
      retweetersCount: map['retweetersCount'] as int,
      childTweetsCount: map['childTweetsCount'] as int,
      bookmarkersCount: map['bookmarkersCount'] as int,
      mentions: List<TweetMentionsModel>.from(
        (map['mentions'] as List<int>).map<TweetMentionsModel>(
          (x) => TweetMentionsModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      hashTags: List<HashtagsModel>.from(
        (map['hashTags'] as List<int>).map<HashtagsModel>(
          (x) => HashtagsModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      tweeter: UserModel.fromMap(map['tweeter'] as Map<String, dynamic>),
      quotedTweet: map["quotedTweet"] != null ? TweetListModel.fromMap(map["quotedTweet"]) : null,
      parentTweet: map["parentTweet"] != null ? TweetListModel.fromMap(map["parentTweet"]) : null,
    );
  }
}
