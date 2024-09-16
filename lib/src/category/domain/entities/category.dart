// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:montra_app/src/category/data/model/category_model.dart';

class Category extends Equatable {
  const Category({
    required this.categoryId,
    required this.description,
    required this.type,
    required this.image,
    required this.color,
  });

  const Category.empty()
      : this(
          categoryId: '',
          description: '',
          type: 0,
          image: '',
          color: '',
        );

  CategoryModel toModel() {
    return CategoryModel(
      categoryId: categoryId,
      description: description,
      type: type,
      image: image,
      color: color,
    );
  }

  final String categoryId;
  final String description;
  final int type;
  final String image;
  final String color;

  @override
  List<Object> get props {
    return [
      categoryId,
      description,
      type,
      image,
      color,
    ];
  }
}
