import 'package:flutter/material.dart';
import 'package:montra_app/core/common/widgets/i_field.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';
import 'package:montra_app/core/res/media_res.dart';
import 'package:montra_app/src/add_transaction/presentation/widgets/add_transaction_background.dart';
import 'package:montra_app/src/add_transaction/presentation/widgets/attachment_button.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  static const routeName = '/transfer';

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  TextEditingController transferController = TextEditingController();

  @override
  void dispose() {
    transferController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AddTransactionBackground(
      backgroundColor: AppColorsLight.blueColor,
      valueController: transferController,
      appBarTitle: context.langauage.transfer,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: IField(
                    controller: TextEditingController(),
                    readOnly: true,
                    hintText: context.langauage.from,
                    hintStyle: const TextStyle(
                      color: AppColorsLight.light20Color,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: IField(
                    controller: TextEditingController(),
                    hintText: context.langauage.to,
                    hintStyle: const TextStyle(
                      color: AppColorsLight.light20Color,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColorsLight.light80Color,
                border: Border.all(
                  color: AppColorsLight.light60Color,
                ),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                MediaRes.transactionColoredIcon,
                width: context.width * 0.08,
              ),
            ),
          ],
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
        const AttachmentButton(),
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
