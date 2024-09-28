class TweetMentionsModel {
  String userId;
  String userName;
  TweetMentionsModel({
    required this.userId,
    required this.userName,
  });

  factory TweetMentionsModel.fromMap(Map map) {
    return TweetMentionsModel(
      userId: map['userId'] as String,
      userName: map['user']['userName'] as String,
    );
  }
}
