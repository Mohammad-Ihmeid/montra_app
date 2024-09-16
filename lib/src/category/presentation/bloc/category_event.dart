part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class GetCategoriesEvent extends CategoryEvent {
  const GetCategoriesEvent(this.type);

  final int type;

  @override
  List<Object> get props => [type];
}

class AddCategoryEvent extends CategoryEvent {
  const AddCategoryEvent(this.category);

  final Category category;

  @override
  List<Object> get props => [category];
}

class GetCategoriesIconEvent extends CategoryEvent {
  const GetCategoriesIconEvent();
}

class DeleteCategoryEvent extends CategoryEvent {
  const DeleteCategoryEvent(this.categoryId);

  final String categoryId;

  @override
  List<Object> get props => [categoryId];
}

class EditCategoryEvent extends CategoryEvent {
  const EditCategoryEvent(this.updateCategoryParams);

  final UpdateCategoryParams updateCategoryParams;
}
