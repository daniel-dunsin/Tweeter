import 'package:client/modules/categories/services/categories_service.dart';

class CategoriesRepository {
  final CategoriesService categoriesService;

  const CategoriesRepository(this.categoriesService);

  getCategories() async {
    final response = await categoriesService.getCategories();

    return response.data;
  }

  selectUserInterests(List<String> subCategories) async {
    final response = await this.categoriesService.updateInterests(subCategories);

    return response.data;
  }
}
