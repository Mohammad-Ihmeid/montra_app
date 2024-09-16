import 'package:dartz/dartz.dart';
import 'package:montra_app/core/enums/update_category.dart';
import 'package:montra_app/core/errors/exceptions.dart';
import 'package:montra_app/core/errors/failure.dart';
import 'package:montra_app/core/utils/typedef.dart';
import 'package:montra_app/src/category/data/datasources/category_remote_data_source.dart';
import 'package:montra_app/src/category/domain/entities/category.dart';
import 'package:montra_app/src/category/domain/repos/category_repo.dart';

class CategoryRepoImpl implements CategoryRepo {
  const CategoryRepoImpl(this._remoteDataSrc);

  final CategoryRemoteDataSource _remoteDataSrc;

  @override
  ResultFuture<void> addCategory(Category category) async {
    try {
      await _remoteDataSrc.addCategory(category);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Category>> getCategories(int type) async {
    try {
      final result = await _remoteDataSrc.getCategories(type);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<String>> getCategoriesIcon() async {
    try {
      final result = await _remoteDataSrc.getCategoriesIcon();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultVoid deleteCategory(String categoryId) async {
    try {
      final result = await _remoteDataSrc.deleteCategory(categoryId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultVoid editCategory({
    required String categoryId,
    required UpdateCategoryAction action,
    required dynamic categoryData,
  }) async {
    try {
      final result = await _remoteDataSrc.editCategory(
        categoryId: categoryId,
        action: action,
        categoryData: categoryData,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
