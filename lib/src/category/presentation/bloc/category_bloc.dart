import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:montra_app/core/enums/enums.dart';
import 'package:montra_app/src/category/domain/entities/category.dart';
import 'package:montra_app/src/category/domain/usecases/add_category.dart';
import 'package:montra_app/src/category/domain/usecases/delete_category.dart';
import 'package:montra_app/src/category/domain/usecases/edit_category.dart';
import 'package:montra_app/src/category/domain/usecases/get_categories.dart';
import 'package:montra_app/src/category/domain/usecases/get_categories_icon.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({
    required AddCategory addCategory,
    required GetCategories getCategories,
    required GetCategoriesIcon getCategoriesIcon,
    required DeleteCategory deleteCategory,
    required EditCategory editCategory,
  })  : _addCategory = addCategory,
        _getCategories = getCategories,
        _getCategoriesIcon = getCategoriesIcon,
        _deleteCategory = deleteCategory,
        _editCategory = editCategory,
        super(const CategoryState()) {
    on<GetCategoriesEvent>(_getCategoriesHandler);

    on<AddCategoryEvent>(_addCategoryHandler);

    on<GetCategoriesIconEvent>(_getCategoriesIconHandler);

    on<DeleteCategoryEvent>(_deleteCategoryHandler);

    on<EditCategoryEvent>(_editCategoryHandler);
  }

  final AddCategory _addCategory;
  final GetCategories _getCategories;
  final GetCategoriesIcon _getCategoriesIcon;
  final DeleteCategory _deleteCategory;
  final EditCategory _editCategory;

  FutureOr<void> _getCategoriesHandler(
    GetCategoriesEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(getCategoriesState: RequestState.loading));

    final result = await _getCategories(event.type);

    result.fold(
      (failure) => emit(
        state.copyWith(
          getCategoriesState: RequestState.error,
          errorRequest: failure.errorMessage,
        ),
      ),
      (categories) => emit(
        state.copyWith(
          getCategoriesState: RequestState.loaded,
          categoriesList: categories,
        ),
      ),
    );
  }

  FutureOr<void> _addCategoryHandler(
    AddCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(addCategoryState: SaveState.loading));

    final result = await _addCategory(event.category);

    result.fold(
      (failure) => emit(
        state.copyWith(
          addCategoryState: SaveState.error,
          errorRequest: failure.errorMessage,
        ),
      ),
      (_) => emit(state.copyWith(addCategoryState: SaveState.success)),
    );
  }

  FutureOr<void> _getCategoriesIconHandler(
    GetCategoriesIconEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(getCategoriesIconState: RequestState.loading));

    final result = await _getCategoriesIcon();

    result.fold(
      (failure) => emit(
        state.copyWith(
          getCategoriesIconState: RequestState.loaded,
          errorRequest: failure.errorMessage,
        ),
      ),
      (categoriesIcon) => emit(
        state.copyWith(
          getCategoriesIconState: RequestState.loaded,
          categoriesIcon: categoriesIcon,
        ),
      ),
    );
  }

  FutureOr<void> _deleteCategoryHandler(
    DeleteCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(deleteCategoryState: SaveState.loading));

    final result = await _deleteCategory(event.categoryId);

    result.fold(
      (failure) => emit(
        state.copyWith(
          deleteCategoryState: SaveState.error,
          errorRequest: failure.errorMessage,
        ),
      ),
      (_) => emit(state.copyWith(deleteCategoryState: SaveState.success)),
    );
  }

  Future<void> _editCategoryHandler(
    EditCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(editCategoryState: SaveState.loading));

    final result = await _editCategory(event.updateCategoryParams);

    result.fold(
      (failure) => emit(
        state.copyWith(
          editCategoryState: SaveState.error,
          errorRequest: failure.errorMessage,
        ),
      ),
      (_) => emit(state.copyWith(editCategoryState: SaveState.success)),
    );
  }
}
