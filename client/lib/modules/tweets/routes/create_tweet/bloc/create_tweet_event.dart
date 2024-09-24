// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_tweet_bloc.dart';

@immutable
sealed class CreateTweetEvent {}

class AddNewTweet extends CreateTweetEvent {}

class AddText extends CreateTweetEvent {
  final String text;

  AddText(this.text);
}

class AddAudio extends CreateTweetEvent {
  final File audio;

  AddAudio(this.audio);
}

class AddGif extends CreateTweetEvent {
  final String gifUrl;

  AddGif(this.gifUrl);
}

class AddImage extends CreateTweetEvent {
  final File image;

  AddImage(this.image);
}

class AddVideo extends CreateTweetEvent {
  final File video;

  AddVideo(this.video);
}

class RemoveMedia extends CreateTweetEvent {
  final int index;

  RemoveMedia({required this.index});
}

class RemoveTweet extends CreateTweetEvent {
  final int index;

  RemoveTweet({required this.index});
}

class AddLocation extends CreateTweetEvent {
  final CreateTweetLocationModel location;

  AddLocation(this.location);
}

class ChangeActiveIndex extends CreateTweetEvent {
  final int index;

  ChangeActiveIndex(this.index);
}
