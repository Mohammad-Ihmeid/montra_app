import 'package:montra_app/core/usecase/usecase.dart';
import 'package:montra_app/core/utils/typedef.dart';
import 'package:montra_app/src/category/domain/repos/category_repo.dart';

class DeleteCategory extends UseCaseWithParams<void, String> {
  const DeleteCategory(this._repo);

  final CategoryRepo _repo;

  @override
  ResultFuture<void> call(String params) => _repo.deleteCategory(params);
}
