import 'package:flutter/material.dart';
import 'package:montra_app/core/common/widgets/i_field.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';
import 'package:montra_app/src/add_transaction/presentation/widgets/add_transaction_background.dart';
import 'package:montra_app/src/add_transaction/presentation/widgets/attachment_button.dart';
import 'package:montra_app/src/add_transaction/presentation/widgets/repeat_button.dart';

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({super.key});

  static const routeName = '/income';

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  TextEditingController incomeController = TextEditingController();

  @override
  void dispose() {
    incomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AddTransactionBackground(
      backgroundColor: AppColorsLight.greenColor,
      valueController: incomeController,
      appBarTitle: context.langauage.income,
      children: [
        IField(
          controller: TextEditingController(),
          readOnly: true,
          hintText: context.langauage.category,
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
        IField(
          controller: TextEditingController(),
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
    );
  }
}
