import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_app/core/common/widgets/show_loading_dialog.dart';
import 'package:montra_app/core/enums/enums.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';
import 'package:montra_app/core/utils/core_utils.dart';
import 'package:montra_app/src/category/domain/entities/category.dart';
import 'package:montra_app/src/category/presentation/bloc/category_bloc.dart';
import 'package:montra_app/src/category/presentation/refactors/edit_category_dialog.dart';

class CategorySheet extends StatelessWidget {
  const CategorySheet({required this.category, required this.type, super.key});

  final Category category;
  final int type;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoryBloc, CategoryState>(
      listenWhen: (previous, current) =>
          previous.deleteCategoryState != current.deleteCategoryState ||
          previous.editCategoryState != current.editCategoryState,
      listener: (context, state) {
        if (state.deleteCategoryState == SaveState.loading ||
            state.editCategoryState == SaveState.loading) {
          LoadingDialog.show(context);
        } else if (state.deleteCategoryState == SaveState.error ||
            state.editCategoryState == SaveState.error) {
          LoadingDialog.hide(context);
          Navigator.pop(context, false);
          CoreUtlis.showSnackBar(
            context,
            state.errorRequest,
          );
        } else if (state.deleteCategoryState == SaveState.success ||
            state.editCategoryState == SaveState.success) {
          LoadingDialog.hide(context);
          Navigator.pop(context, true);
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              category.description,
              style: context.theme.textTheme.displayLarge!.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context
                          .read<CategoryBloc>()
                          .add(DeleteCategoryEvent(category.categoryId));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColorsLight.indicatorColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(
                          Icons.delete,
                          color: AppColorsLight.primaryColor,
                        ),
                        Text(
                          context.langauage.delete,
                          style: context.theme.textTheme.displayLarge!.copyWith(
                            color: AppColorsLight.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog<dynamic>(
                        barrierDismissible: false,
                        context: context,
                        builder: (ctx) {
                          return BlocProvider.value(
                            value: context.read<CategoryBloc>(),
                            child: Dialog(
                              backgroundColor: Colors.white,
                              alignment: Alignment.center,
                              insetPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: EditCategoryDialog(
                                categoryType: type,
                                category: category,
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(
                          Icons.edit,
                          color: AppColorsLight.lightColor,
                        ),
                        Text(context.langauage.edit),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
