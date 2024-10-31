import 'package:flutter/material.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';
import 'package:montra_app/core/res/media_res.dart';
import 'package:montra_app/src/account/presentation/views/account_screen.dart';
import 'package:montra_app/src/profile/presentation/widgets/logout_sheet.dart';
import 'package:montra_app/src/profile/presentation/widgets/profile_info_card.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          ProfileInfoCard(
            image: MediaRes.walletIcon,
            iconColor: AppColorsLight.primaryColor,
            label: context.langauage.account,
            color: AppColorsLight.indicatorColor,
            onTap: () => Navigator.pushNamed(context, AccountScreen.routeName),
          ),
          ProfileInfoCard(
            image: MediaRes.settingsIcon,
            iconColor: AppColorsLight.primaryColor,
            label: context.langauage.settings,
            color: AppColorsLight.indicatorColor,
            borderColor: AppColorsLight.light60Color,
            onTap: () {},
          ),
          ProfileInfoCard(
            image: MediaRes.uploadIcon,
            iconColor: AppColorsLight.primaryColor,
            label: context.langauage.exportData,
            color: AppColorsLight.indicatorColor,
            borderColor: AppColorsLight.light60Color,
            onTap: () {},
          ),
          ProfileInfoCard(
            image: MediaRes.logoutIcon,
            iconColor: AppColorsLight.redColor,
            label: context.langauage.logout,
            color: AppColorsLight.logoutBackground,
            borderColor: AppColorsLight.light60Color,
            onTap: () {
              showModalBottomSheet<void>(
                context: context,
                backgroundColor: Colors.white,
                showDragHandle: true,
                useSafeArea: true,
                builder: (_) => const LogoutSheet(),
              );
            },
          ),
        ],
      ),
    );
  }
}
