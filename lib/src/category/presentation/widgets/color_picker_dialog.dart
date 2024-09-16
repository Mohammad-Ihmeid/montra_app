import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';

class ColorPickerDialog extends StatelessWidget {
  const ColorPickerDialog({
    required this.categoryColor,
    super.key,
  });

  final Color categoryColor;

  @override
  Widget build(BuildContext context) {
    Color? colorPicked;
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: categoryColor,
          onColorChanged: (colorPick) {
            colorPicked = colorPick;
          },
        ),
      ),
      actionsPadding: const EdgeInsets.only(
        bottom: 10,
        left: 5,
        right: 5,
      ),
      actions: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, colorPicked);
                },
                child: Text(context.langauage.choose),
              ),
            ),
            SizedBox(width: context.width * 0.04),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColorsLight.indicatorColor,
                ),
                onPressed: () => Navigator.pop(context),
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
    );
  }
}
