import 'package:flutter/material.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';
import 'package:montra_app/src/profile/presentation/refactors/profile_body.dart';
import 'package:montra_app/src/profile/presentation/refactors/profile_header.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColorsLight.profileBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ProfileHeader(),
              SizedBox(height: 50),
              Expanded(child: ProfileBody()),
            ],
          ),
        ),
      ),
    );
  }
}
