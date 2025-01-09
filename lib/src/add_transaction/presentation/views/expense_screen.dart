import 'package:flutter/material.dart';
import 'package:montra_app/core/common/widgets/i_field.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';
import 'package:montra_app/src/add_transaction/presentation/widgets/attachment_button.dart';
import 'package:montra_app/src/add_transaction/presentation/widgets/categories_menu.dart';
import 'package:montra_app/src/add_transaction/presentation/widgets/repeat_button.dart';
import 'package:montra_app/src/add_transaction/presentation/widgets/transaction_background.dart';
import 'package:montra_app/src/category/domain/entities/category.dart';
import 'package:montra_app/src/category/presentation/views/category_screen.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  static const routeName = '/expense';

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  @override
  void dispose() {
    expenseController.dispose();
    descriptionController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  void onDiscChange(Category category) {
    categoryController.text = category.description;
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild!.unfocus();
        }
      },
      child: TransactionBackground(
        backgroundColor: AppColorsLight.redColor,
        valueController: expenseController,
        appBarTitle: context.langauage.expense,
        children: [
          IField(
            controller: categoryController,
            readOnly: true,
            hintText: context.langauage.category,
            hintStyle: const TextStyle(
              color: AppColorsLight.light20Color,
              fontSize: 16,
            ),
            suffixIcon: CategoriesMenu(
              type: 1,
              onDiscChange: onDiscChange,
            ),
            prefixIcon: IconButton(
              onPressed: () => Navigator.pushNamed(
                context,
                CategoryScreen.routeName,
                arguments: 1,
              ),
              icon: Icon(
                Icons.add,
                color: AppColorsLight.light20Color,
                size: context.width * 0.08,
              ),
            ),
          ),
          const SizedBox(height: 16),
          IField(
            controller: descriptionController,
            hintText: context.langauage.description,
            hintStyle: const TextStyle(
              color: AppColorsLight.light20Color,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          IField(
            controller: TextEditingController(),
            readOnly: true,
            hintText: context.langauage.wallet,
            hintStyle: const TextStyle(
              color: AppColorsLight.light20Color,
              fontSize: 16,
            ),
            suffixIcon: Icon(
              Icons.keyboard_arrow_down_outlined,
              color: AppColorsLight.light20Color,
              size: context.width * 0.08,
            ),
          ),
          const SizedBox(height: 16),
          const AttachmentButton(),
          const SizedBox(height: 16),
          const RepeatButton(),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            child: Text(context.langauage.continues),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
