import 'dart:convert';

class SubcategoryModel {
  final String id;
  final String name;
  final String? description;
  final String categoryId;

  SubcategoryModel({
    required this.id,
    required this.name,
    this.description,
    required this.categoryId,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({
      'id': id,
    });
    result.addAll({
      'name': name
    });
    if (description != null) {
      result.addAll({
        'description': description
      });
    }
    result.addAll({
      'categoryId': categoryId
    });

    return result;
  }

  factory SubcategoryModel.fromMap(Map<String, dynamic> map) {
    return SubcategoryModel(
      id: map["id"] ?? '',
      name: map['name'] ?? '',
      description: map['description'],
      categoryId: map['categoryId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SubcategoryModel.fromJson(String source) => SubcategoryModel.fromMap(json.decode(source));
}
