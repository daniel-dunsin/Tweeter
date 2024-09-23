class CreateTweetLocationModel {
  final int lng;
  final int lat;
  final String name;

  CreateTweetLocationModel({
    required this.lng,
    required this.lat,
    required this.name,
  });

  CreateTweetLocationModel copyWith({
    int? lng,
    int? lat,
    String? name,
  }) {
    return CreateTweetLocationModel(
      lng: lng ?? this.lng,
      lat: lat ?? this.lat,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lng': lng,
      'lat': lat,
      'name': name,
    };
  }
}
