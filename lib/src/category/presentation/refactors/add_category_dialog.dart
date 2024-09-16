import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_app/core/common/widgets/i_field.dart';
import 'package:montra_app/core/common/widgets/show_loading_dialog.dart';
import 'package:montra_app/core/enums/enums.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';
import 'package:montra_app/core/utils/core_utils.dart';
import 'package:montra_app/src/category/domain/entities/category.dart';
import 'package:montra_app/src/category/presentation/bloc/category_bloc.dart';
import 'package:montra_app/src/category/presentation/widgets/color_picker_dialog.dart';
import 'package:montra_app/src/category/presentation/widgets/image_picker_dialog.dart';

class AddCategoryDialog extends StatefulWidget {
  const AddCategoryDialog({required this.categoryType, super.key});

  final int categoryType;

  @override
  State<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  TextEditingController categoryController = TextEditingController();
  Color categoryColor = Colors.black;
  String categoryImage = '';

  @override
  void dispose() {
    categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoryBloc, CategoryState>(
      listenWhen: (previous, current) =>
          previous.addCategoryState != current.addCategoryState,
      listener: (context, state) {
        if (state.addCategoryState == SaveState.loading) {
          LoadingDialog.show(context);
        } else if (state.addCategoryState == SaveState.error) {
          LoadingDialog.hide(context);
          CoreUtlis.showSnackBar(
            context,
            state.errorRequest,
          );
        } else if (state.addCategoryState == SaveState.success) {
          LoadingDialog.hide(context);
          CoreUtlis.showSnackBar(
            context,
            context.langauage.addCaegorySuccess,
          );
          Navigator.pop(context, true);
        }
      },
      child: Listener(
        onPointerDown: (_) {
          final currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.focusedChild!.unfocus();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.langauage.create_Category,
                  style: context.theme.textTheme.displayLarge!.copyWith(
                    color: AppColorsLight.darkColor,
                  ),
                ),
                SizedBox(height: context.height * 0.01),
                IField(
                  controller: categoryController,
                  hintText: context.langauage.description,
                ),
                SizedBox(height: context.height * 0.03),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: StatefulBuilder(
                        builder: (context, changeImage) {
                          return GestureDetector(
                            onTap: () {
                              showDialog<String>(
                                context: context,
                                builder: (ctx) {
                                  return BlocProvider.value(
                                    value: context.read<CategoryBloc>(),
                                    child: const ImagePickerDialog(),
                                  );
                                },
                              ).then((value) {
                                if (value != null) {
                                  changeImage(() {
                                    categoryImage = value;
                                  });
                                }
                              });
                            },
                            child: Container(
                              height: context.height * 0.20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: AppColorsLight.dark25Color),
                                color: categoryImage == ''
                                    ? Colors.white
                                    : categoryColor.withOpacity(0.2),
                              ),
                              child: Center(
                                child: LayoutBuilder(
                                  builder: (context, constraint) {
                                    return categoryImage == ''
                                        ? Icon(
                                            Icons.add,
                                            size: constraint.biggest.height,
                                            color: AppColorsLight.light20Color,
                                          )
                                        : Image.network(
                                            categoryImage,
                                            color: categoryColor,
                                            width: constraint.biggest.width,
                                            height: constraint.biggest.height,
                                          );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: context.width * 0.04),
                    StatefulBuilder(
                      builder: (context, setState) {
                        final categoryColorHex = categoryColor.value
                            .toRadixString(16)
                            .substring(2)
                            .toUpperCase();
                        return GestureDetector(
                          onTap: () {
                            showDialog<Color?>(
                              context: context,
                              builder: (context) {
                                return ColorPickerDialog(
                                  categoryColor: categoryColor,
                                );
                              },
                            ).then((value) {
                              if (value != null) {
                                setState(() {
                                  categoryColor = value;
                                });
                              }
                            });
                          },
                          child: IntrinsicWidth(
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    'Color : #$categoryColorHex',
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: context.height * 0.08,
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColorsLight.darkColor,
                                    ),
                                  ),
                                  child: ColoredBox(
                                    color: categoryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: context.height * 0.03),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<CategoryBloc>().add(
                                AddCategoryEvent(
                                  Category(
                                    categoryId: '',
                                    description: categoryController.text.trim(),
                                    type: widget.categoryType,
                                    image: categoryImage,
                                    color: categoryColor.value
                                        .toRadixString(16)
                                        .substring(2)
                                        .toUpperCase(),
                                  ),
                                ),
                              );
                        },
                        child: Text(context.langauage.create),
                      ),
                    ),
                    SizedBox(width: context.width * 0.03),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColorsLight.indicatorColor,
                        ),
                        onPressed: () => Navigator.pop(context, false),
                        child: Text(
                          context.langauage.cancel,
                          style: context.theme.textTheme.displayLarge!.copyWith(
                            color: AppColorsLight.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
