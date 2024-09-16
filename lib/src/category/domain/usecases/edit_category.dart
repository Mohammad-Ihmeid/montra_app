import 'package:equatable/equatable.dart';
import 'package:montra_app/core/enums/update_category.dart';
import 'package:montra_app/core/usecase/usecase.dart';
import 'package:montra_app/core/utils/typedef.dart';
import 'package:montra_app/src/category/domain/repos/category_repo.dart';

class EditCategory extends UseCaseWithParams<void, UpdateCategoryParams> {
  const EditCategory(this._repo);

  final CategoryRepo _repo;

  @override
  ResultFuture<void> call(UpdateCategoryParams params) {
    return _repo.editCategory(
      categoryId: params.categoryId,
      action: params.action,
      categoryData: params.categoryData,
    );
  }
}

class UpdateCategoryParams extends Equatable {
  const UpdateCategoryParams({
    required this.categoryId,
    required this.action,
    required this.categoryData,
  });

  const UpdateCategoryParams.empty()
      : this(
          categoryId: '',
          action: UpdateCategoryAction.description,
          categoryData: '',
        );

  final String categoryId;
  final UpdateCategoryAction action;
  final dynamic categoryData;

  @override
  List<dynamic> get props => [categoryId, action, categoryData];
}
