import 'package:montra_app/core/usecase/usecase.dart';
import 'package:montra_app/core/utils/typedef.dart';
import 'package:montra_app/src/category/domain/repos/category_repo.dart';

class GetCategoriesIcon extends UseCaseWithoutParams<List<String>> {
  const GetCategoriesIcon(this._repo);

  final CategoryRepo _repo;

  @override
  ResultFuture<List<String>> call() => _repo.getCategoriesIcon();
}
