part of 'categories_bloc.dart';

@immutable
sealed class CategoriesEvents {}

class CategoriesRequested extends CategoriesEvents {}

class SelectInterestsRequested extends CategoriesEvents {
  final List<String> interests;

  SelectInterestsRequested(this.interests);
}
