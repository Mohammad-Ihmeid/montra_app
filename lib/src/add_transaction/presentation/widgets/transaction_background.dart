import 'package:flutter/material.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';
import 'package:montra_app/core/res/media_res.dart';
import 'package:montra_app/src/add_transaction/presentation/widgets/add_transaction_app_bar.dart';

class TransactionBackground extends StatefulWidget {
  const TransactionBackground({
    required this.appBarTitle,
    required this.valueController,
    required this.children,
    this.backgroundColor,
    this.bodyTitle,
    super.key,
  });

  final String appBarTitle;
  final Color? backgroundColor;
  final String? bodyTitle;
  final TextEditingController valueController;
  final List<Widget> children;

  @override
  State<TransactionBackground> createState() => _TransactionBackgroundState();
}

class _TransactionBackgroundState extends State<TransactionBackground> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: widget.backgroundColor,
      appBar: AddTransactionAppBar(title: widget.appBarTitle),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: Text(
              widget.bodyTitle ?? context.langauage.howMuch,
              style: const TextStyle(
                color: AppColorsLight.light80Color,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  MediaRes.dollarSignIcon,
                  width: context.width * 0.06,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: TextField(
                    controller: widget.valueController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    onTap: () {},
                    onTapOutside: (_) {
                      FocusScope.of(context).unfocus();
                    },
                    style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w600,
                      color: AppColorsLight.light80Color,
                      decoration: TextDecoration.none,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      hintText: '0',
                      hintStyle: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w600,
                        color: AppColorsLight.light80Color,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            decoration: const BoxDecoration(
              color: AppColorsLight.lightColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            child: Column(
              children: widget.children,
            ),
          ),
        ],
      ),
    );
  }
}
