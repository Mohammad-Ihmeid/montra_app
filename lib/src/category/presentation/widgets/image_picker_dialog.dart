import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_app/core/common/views/loading_view.dart';
import 'package:montra_app/core/enums/enums.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';
import 'package:montra_app/core/res/media_res.dart';
import 'package:montra_app/src/category/presentation/bloc/category_bloc.dart';

class ImagePickerDialog extends StatefulWidget {
  const ImagePickerDialog({super.key});

  @override
  State<ImagePickerDialog> createState() => _ImagePickerDialogState();
}

class _ImagePickerDialogState extends State<ImagePickerDialog> {
  List<String> images = <String>[
    MediaRes.shoppingIcon,
    MediaRes.recurringBillIcon,
  ];

  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(const GetCategoriesIconEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      buildWhen: (previous, current) =>
          previous.getCategoriesIconState != current.getCategoriesIconState,
      builder: (context, state) {
        return Dialog(
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                switch (state.getCategoriesIconState) {
                  case RequestState.loaded:
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 15,
                              crossAxisCount: 2,
                            ),
                            shrinkWrap: true,
                            itemCount: state.categoriesIcon.length,
                            itemBuilder: (_, index) {
                              final image = state.categoriesIcon[index];
                              return GestureDetector(
                                onTap: () => Navigator.pop(context, image),
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColorsLight.primaryColor,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Image.network(image),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: context.height * 0.05),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColorsLight.indicatorColor,
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            context.langauage.cancel,
                            style:
                                context.theme.textTheme.displayLarge!.copyWith(
                              color: AppColorsLight.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    );
                  case RequestState.loading:
                    return const LoadingView(
                      color: AppColorsLight.primaryColor,
                    );
                  case RequestState.error:
                    return Container();
                }
              },
            ),
          ),
        );
      },
    );
  }
}
