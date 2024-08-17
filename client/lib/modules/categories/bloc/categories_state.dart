import 'package:client/modules/categories/models/category_model.dart';
import 'package:flutter/material.dart';

@immutable
sealed class CategoriesState {}

class CategoriesInitialState extends CategoriesState {}

class GetCategoriesLoading extends CategoriesState {}

class GetCategoriesSuccess extends CategoriesState {
  final List<CategoryModel> categories;

  GetCategoriesSuccess(this.categories);
}

class GetCategoriesError extends CategoriesState {}
