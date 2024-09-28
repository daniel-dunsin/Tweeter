class HashtagsModel {
  String id;
  String name;
  HashtagsModel({
    required this.id,
    required this.name,
  });

  factory HashtagsModel.fromMap(Map map) {
    return HashtagsModel(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }
}
