import 'package:flutter/material.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';
import 'package:montra_app/core/res/media_res.dart';
import 'package:montra_app/src/add_transaction/presentation/widgets/add_transaction_app_bar.dart';

class AddTransactionBackground extends StatefulWidget {
  const AddTransactionBackground({
    required this.valueController,
    required this.appBarTitle,
    required this.children,
    this.bodyTitle,
    this.backgroundColor,
    this.changeHeight,
    super.key,
  });

  final Color? backgroundColor;
  final String appBarTitle;
  final String? bodyTitle;
  final TextEditingController valueController;
  final List<Widget> children;
  final ValueNotifier<bool>? changeHeight;

  @override
  State<AddTransactionBackground> createState() =>
      _AddTransactionBackgroundState();
}

class _AddTransactionBackgroundState extends State<AddTransactionBackground>
    with WidgetsBindingObserver {
  double bottomSheetHeight = 0;
  final bottomSheetKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    if (widget.changeHeight != null) {
      widget.changeHeight!.addListener(() => _updateBottomSheetHeight);
    }

    // Measure the height of the bottom sheet after the first frame is rendered.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateBottomSheetHeight();
    });
  }

  void _updateBottomSheetHeight() {
    Future.delayed(const Duration(milliseconds: 300), () {
      final sheetHeight = bottomSheetKey.currentContext?.size?.height ?? 0;
      if (sheetHeight != bottomSheetHeight) {
        setState(() {
          bottomSheetHeight = sheetHeight;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: AddTransactionAppBar(title: widget.appBarTitle),
      body: Padding(
        padding: EdgeInsets.only(
          bottom: bottomSheetHeight,
          left: 16,
          right: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              widget.bodyTitle ?? context.langauage.howMuch,
              style: const TextStyle(
                color: AppColorsLight.light80Color,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            Row(
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
                    onTap: () {
                      if (widget.changeHeight != null) {
                        widget.changeHeight!.value = false;
                      }
                    },
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
          ],
        ),
      ),
      bottomSheet: Padding(
        key: bottomSheetKey,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: widget.children,
          ),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant AddTransactionBackground oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update the bottom sheet height if the children or content changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateBottomSheetHeight();
    });
  }
}
