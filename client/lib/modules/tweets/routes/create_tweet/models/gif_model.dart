class GifModel {
  String title;
  GifImageModel image;

  GifModel({
    required this.title,
    required this.image,
  });

  GifModel copyWith({
    String? title,
    GifImageModel? image,
  }) {
    return GifModel(
      title: title ?? this.title,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'image': image.toMap(),
    };
  }

  factory GifModel.fromMap(Map<String, dynamic> map) {
    return GifModel(
      title: map['title'] as String,
      image: GifImageModel.fromMap(map["images"]["preview_gif"]),
    );
  }
}

class GifImageModel {
  int width;
  int height;
  String? url;
  String? mp4;
  GifImageModel({
    required this.width,
    required this.height,
    this.url,
    this.mp4,
  });

  GifImageModel copyWith({
    int? width,
    int? height,
    String? url,
    String? mp4,
  }) {
    return GifImageModel(
      width: width ?? this.width,
      height: height ?? this.height,
      url: url ?? this.url,
      mp4: mp4 ?? this.mp4,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'width': width,
      'height': height,
      'url': url,
      'mp4': mp4,
    };
  }

  factory GifImageModel.fromMap(Map<String, dynamic> map) {
    return GifImageModel(
      width: map['width'] as int,
      height: map['height'] as int,
      url: map['url'] != null ? map['url'] as String : null,
      mp4: map['mp4'] != null ? map['mp4'] as String : null,
    );
  }
}
