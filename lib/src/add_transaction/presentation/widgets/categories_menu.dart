import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_app/core/enums/enums.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';
import 'package:montra_app/src/category/domain/entities/category.dart';
import 'package:montra_app/src/category/presentation/bloc/category_bloc.dart';

class CategoriesMenu extends StatefulWidget {
  const CategoriesMenu({
    required this.type,
    required this.onDiscChange,
    super.key,
  });

  final int type;
  final void Function(Category) onDiscChange;

  @override
  State<CategoriesMenu> createState() => _CategoriesMenuState();
}

class _CategoriesMenuState extends State<CategoriesMenu> {
  @override
  void initState() {
    context.read<CategoryBloc>().add(GetCategoriesEvent(widget.type));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        switch (state.getCategoriesState) {
          case RequestState.loading:
            return Icon(
              Icons.downloading_outlined,
              color: AppColorsLight.light20Color,
              size: context.width * 0.08,
            );
          case RequestState.error:
            return Icon(
              Icons.error,
              color: AppColorsLight.light20Color,
              size: context.width * 0.08,
            );
          case RequestState.loaded:
            return PopupMenuButton(
              icon: Icon(
                Icons.keyboard_arrow_down_outlined,
                color: AppColorsLight.light20Color,
                size: context.width * 0.08,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              itemBuilder: (_) => state.categoriesList
                  .map(
                    (element) => PopupMenuItem<void>(
                      child: Text(
                        element.description,
                        textAlign: TextAlign.center,
                      ),
                      onTap: () {
                        widget.onDiscChange(element);
                      },
                    ),
                  )
                  .toList(),
            );
        }
      },
    );
  }
}
