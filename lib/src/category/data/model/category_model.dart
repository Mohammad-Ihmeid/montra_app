import 'package:montra_app/core/utils/typedef.dart';
import 'package:montra_app/src/category/domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required super.categoryId,
    required super.description,
    required super.type,
    required super.image,
    required super.color,
  });

  const CategoryModel.empty()
      : this(
          categoryId: '',
          description: '',
          type: 0,
          image: '',
          color: '',
        );

  CategoryModel.fromMap(DataMap map)
      : super(
          categoryId: map['CategoryId'] as String,
          description: map['Description'] as String,
          type: map['Type'] as int,
          image: map['Image'] as String,
          color: map['Color'] as String,
        );

  CategoryModel copyWith({
    String? categoryId,
    String? description,
    int? type,
    String? image,
    String? color,
  }) {
    return CategoryModel(
      categoryId: categoryId ?? this.categoryId,
      description: description ?? this.description,
      type: type ?? this.type,
      image: image ?? this.image,
      color: color ?? this.color,
    );
  }

  DataMap toMap() => {
        'CategoryId': categoryId,
        'Description': description,
        'Type': type,
        'Image': image,
        'Color': color,
      };
}
