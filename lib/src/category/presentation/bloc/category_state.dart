part of 'category_bloc.dart';

class CategoryState extends Equatable {
  const CategoryState({
    this.categoriesList = const [],
    this.getCategoriesState = RequestState.loading,
    this.categoriesIcon = const [],
    this.getCategoriesIconState = RequestState.loading,
    this.errorRequest = '',
    this.addCategoryState = SaveState.normal,
    this.deleteCategoryState = SaveState.normal,
    this.editCategoryState = SaveState.normal,
  });

  final List<Category> categoriesList;
  final RequestState getCategoriesState;
  ///////////////////////////////////////////////
  final List<String> categoriesIcon;
  final RequestState getCategoriesIconState;
  ///////////////////////////////////////////////
  final SaveState addCategoryState;
  ///////////////////////////////////////////////
  final SaveState deleteCategoryState;
  ///////////////////////////////////////////////
  final SaveState editCategoryState;
  ///////////////////////////////////////////////
  final String errorRequest;

  CategoryState copyWith({
    List<Category>? categoriesList,
    RequestState? getCategoriesState,
    List<String>? categoriesIcon,
    RequestState? getCategoriesIconState,
    SaveState? addCategoryState,
    String? errorRequest,
    SaveState? deleteCategoryState,
    SaveState? editCategoryState,
  }) {
    return CategoryState(
      categoriesList: categoriesList ?? this.categoriesList,
      getCategoriesState: getCategoriesState ?? this.getCategoriesState,
      categoriesIcon: categoriesIcon ?? this.categoriesIcon,
      getCategoriesIconState:
          getCategoriesIconState ?? this.getCategoriesIconState,
      errorRequest: errorRequest ?? this.errorRequest,
      addCategoryState: addCategoryState ?? this.addCategoryState,
      deleteCategoryState: deleteCategoryState ?? this.deleteCategoryState,
      editCategoryState: editCategoryState ?? this.editCategoryState,
    );
  }

  @override
  List<Object> get props => [
        categoriesList,
        getCategoriesState,
        categoriesIcon,
        getCategoriesIconState,
        addCategoryState,
        errorRequest,
        deleteCategoryState,
        editCategoryState,
      ];
}
