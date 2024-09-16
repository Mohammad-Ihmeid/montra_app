import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_app/core/common/views/loading_view.dart';
import 'package:montra_app/core/enums/enums.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';
import 'package:montra_app/src/category/presentation/bloc/category_bloc.dart';
import 'package:montra_app/src/category/presentation/refactors/add_category_dialog.dart';
import 'package:montra_app/src/category/presentation/refactors/category_body.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen(this.type, {super.key});
  final int type;
  static const routeName = '/category';

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(GetCategoriesEvent(widget.type));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          context.langauage.category,
          style: context.theme.textTheme.displayLarge,
        ),
        iconTheme: const IconThemeData(
          color: AppColorsLight.lightColor,
        ),
        backgroundColor: AppColorsLight.primaryColor,
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        buildWhen: (previous, current) =>
            previous.getCategoriesState != current.getCategoriesState,
        builder: (context, state) {
          switch (state.getCategoriesState) {
            case RequestState.loading:
              return const LoadingView(color: AppColorsLight.primaryColor);
            case RequestState.loaded:
              return CategoryBody(
                categories: state.categoriesList,
                type: widget.type,
              );
            case RequestState.error:
              return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog<dynamic>(
          barrierDismissible: false,
          context: context,
          builder: (ctx) {
            return BlocProvider.value(
              value: context.read<CategoryBloc>(),
              child: Dialog(
                backgroundColor: Colors.white,
                alignment: Alignment.center,
                insetPadding: const EdgeInsets.symmetric(horizontal: 20),
                child: AddCategoryDialog(categoryType: widget.type),
              ),
            );
          },
        ).then((value) {
          value as bool?;
          if (value != null && value) {
            context.read<CategoryBloc>().add(GetCategoriesEvent(widget.type));
          }
        }),
        backgroundColor: AppColorsLight.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
