import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';
import 'package:montra_app/core/res/media_res.dart';

class AttachmentButton extends StatelessWidget {
  const AttachmentButton({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: AppColorsLight.light60Color,
      dashPattern: const [12, 6],
      radius: const Radius.circular(16),
      borderType: BorderType.RRect,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            MediaRes.attachmentIcon,
            width: context.width * 0.08,
            color: AppColorsLight.light20Color,
          ),
          const SizedBox(width: 5),
          Text(
            '${context.langauage.add} ${context.langauage.attachment}',
            style: const TextStyle(
              color: AppColorsLight.light20Color,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
