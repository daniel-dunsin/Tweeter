import 'dart:io';

import 'package:client/modules/tweets/enums/index.dart';

class CreateTweetMediaModel {
  final TweetMediaType type;
  final File? file;
  final String? url;
  final String? publicId;
  CreateTweetMediaModel({
    required this.type,
    this.file,
    this.url,
    this.publicId,
  });

  CreateTweetMediaModel copyWith({
    TweetMediaType? type,
    File? file,
    String? url,
    String? publicId,
  }) {
    return CreateTweetMediaModel(
      type: type ?? this.type,
      file: file ?? this.file,
      url: url ?? this.url,
      publicId: publicId ?? this.publicId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type.name,
      'url': url,
      'publicId': publicId,
    };
  }
}
