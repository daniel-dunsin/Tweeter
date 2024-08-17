import 'package:client/modules/categories/bloc/categories_events.dart';
import 'package:client/modules/categories/bloc/categories_state.dart';
import 'package:client/modules/categories/models/category_model.dart';
import 'package:client/modules/categories/repository/categories_repository.dart';
import 'package:client/shared/utils/network.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesBloc extends Bloc<CategoriesEvents, CategoriesState> {
  final CategoriesRepository categoriesRepository;

  CategoriesBloc(this.categoriesRepository) : super(CategoriesInitialState()) {
    on<CategoriesEvents>((event, emit) async {
      emit(GetCategoriesLoading());

      try {
        final response = await categoriesRepository.getCategories();

        final List<dynamic> categoriesMap = response["data"];

        final categories = categoriesMap.map((category) => CategoryModel.fromMap(category)).toList();

        emit(GetCategoriesSuccess(categories));
        print(categories);
      } catch (e) {
        handleError(e: e);
        emit(GetCategoriesError());
      }
    });
  }
}
