import 'package:flutter/material.dart';
import 'package:montra_app/core/common/app/providers/user_provider.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';
import 'package:montra_app/core/res/media_res.dart';
import 'package:provider/provider.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (_, provider, __) {
        final user = provider.user;
        final image = user?.profilePic == null || user!.profilePic!.isEmpty
            ? null
            : user.profilePic;
        return Row(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: AppColorsLight.primaryColor,
                  width: 2,
                ),
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: image != null
                      ? NetworkImage(image)
                      : const AssetImage(MediaRes.userIcon) as ImageProvider,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.langauage.userName,
                  style: const TextStyle(
                    color: AppColorsLight.light20Color,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  user?.userName ?? '',
                  style: const TextStyle(
                    color: AppColorsLight.dark75Color,
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 40),
            InkWell(
              onTap: () {},
              child: Image.asset(
                MediaRes.editIcon,
                width: context.width * 0.08,
              ),
            ),
          ],
        );
      },
    );
  }
}
