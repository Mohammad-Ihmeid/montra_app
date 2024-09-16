import 'package:montra_app/core/usecase/usecase.dart';
import 'package:montra_app/core/utils/typedef.dart';
import 'package:montra_app/src/category/domain/entities/category.dart';
import 'package:montra_app/src/category/domain/repos/category_repo.dart';

class AddCategory extends UseCaseWithParams<void, Category> {
  AddCategory(this._repo);

  final CategoryRepo _repo;

  @override
  ResultFuture<void> call(Category params) => _repo.addCategory(params);
}
