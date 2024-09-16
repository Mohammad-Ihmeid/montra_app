import 'package:montra_app/core/enums/update_category.dart';
import 'package:montra_app/core/utils/typedef.dart';
import 'package:montra_app/src/category/domain/entities/category.dart';

abstract class CategoryRepo {
  CategoryRepo();

  ResultFuture<List<Category>> getCategories(int type);

  ResultFuture<List<String>> getCategoriesIcon();

  ResultVoid addCategory(Category category);

  ResultVoid deleteCategory(String categoryId);

  ResultVoid editCategory({
    required String categoryId,
    required UpdateCategoryAction action,
    required dynamic categoryData,
  });
}
