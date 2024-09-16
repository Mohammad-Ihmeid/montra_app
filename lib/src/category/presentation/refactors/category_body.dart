import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_app/core/extensions/context_string.dart';
import 'package:montra_app/src/category/domain/entities/category.dart';
import 'package:montra_app/src/category/presentation/bloc/category_bloc.dart';
import 'package:montra_app/src/category/presentation/widgets/category_sheet.dart';

class CategoryBody extends StatelessWidget {
  const CategoryBody({required this.categories, required this.type, super.key});

  final List<Category> categories;
  final int type;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        crossAxisCount: 3,
      ),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return GestureDetector(
          onTap: () {
            showModalBottomSheet<bool?>(
              context: context,
              backgroundColor: Colors.white,
              barrierColor: category.color.hexToColor.withOpacity(0.2),
              showDragHandle: true,
              useSafeArea: true,
              builder: (_) => BlocProvider.value(
                value: context.read<CategoryBloc>(),
                child: CategorySheet(category: category, type: type),
              ),
            ).then((value) {
              if (value != null && value) {
                context.read<CategoryBloc>().add(GetCategoriesEvent(type));
              }
            });
          },
          child: Card(
            surfaceTintColor: category.color.hexToColor.withOpacity(0.2),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Image.network(
                      category.image,
                      color: category.color.hexToColor,
                    ),
                  ),
                  Text(
                    category.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: category.color.hexToColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
