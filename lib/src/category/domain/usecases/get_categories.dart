import 'package:montra_app/core/usecase/usecase.dart';
import 'package:montra_app/core/utils/typedef.dart';
import 'package:montra_app/src/category/domain/entities/category.dart';
import 'package:montra_app/src/category/domain/repos/category_repo.dart';

class GetCategories extends UseCaseWithParams<List<Category>, int> {
  GetCategories(this._repo);

  final CategoryRepo _repo;

  @override
  ResultFuture<List<Category>> call(int params) => _repo.getCategories(params);
}
