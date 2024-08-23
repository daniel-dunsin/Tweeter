part of 'categories_bloc.dart';

@immutable
sealed class CategoriesState {}

class CategoriesInitialState extends CategoriesState {}

class GetCategoriesLoading extends CategoriesState {}

class GetCategoriesSuccess extends CategoriesState {
  final List<CategoryModel> categories;

  GetCategoriesSuccess(this.categories);
}

class GetCategoriesError extends CategoriesState {}

class SelectInterestLoading extends CategoriesState {}

class SelectInterestSuccess extends CategoriesState {}

class SelectInterestError extends CategoriesState {}
