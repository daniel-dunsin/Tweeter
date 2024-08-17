import 'dart:convert';

import 'package:client/modules/categories/models/subcategory_model.dart';

class CategoryModel {
  final String id;
  final String name;
  final String? description;
  final List<SubcategoryModel> subCategories;

  CategoryModel({
    required this.id,
    required this.name,
    this.description,
    required this.subCategories,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({
      "id": id,
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
      'subCategories': subCategories.map((x) => x.toMap()).toList()
    });

    return result;
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'],
      subCategories: List<SubcategoryModel>.from(map['subCategories']?.map((x) => SubcategoryModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) => CategoryModel.fromMap(json.decode(source));
}
