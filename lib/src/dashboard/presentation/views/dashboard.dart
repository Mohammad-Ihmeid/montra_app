import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:montra_app/core/common/app/providers/user_provider.dart';
import 'package:montra_app/core/common/widgets/icon_bottom_app_bar.dart';
import 'package:montra_app/core/res/app_color/app_color_light.dart';
import 'package:montra_app/core/res/media_res.dart';
import 'package:montra_app/src/auth/data/model/user_model.dart';
import 'package:montra_app/src/dashboard/presentation/providers/dashboard_controller.dart';
import 'package:montra_app/src/dashboard/presentation/utils/dashboard_utils.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  static const routeName = '/dashboard';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LocalUserModel>(
      stream: DashboardUtils.userDataStream,
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data is LocalUserModel) {
          context.read<UserProvider>().user = snapshot.data;
        }
        return Consumer<DashboardController>(
          builder: (_, controller, __) {
            return Scaffold(
              body: IndexedStack(
                index: controller.currentIndex,
                children: controller.screen,
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
                backgroundColor: AppColorsLight.primaryColor,
                shape: const CircleBorder(),
                child: const Icon(Icons.add, size: 40),
              ),
              bottomNavigationBar: BottomAppBar(
                shape: const CircularNotchedRectangle(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconBottomAppBar(
                      selectedIcon: controller.currentIndex == 0,
                      icon: MediaRes.homeIcon,
                      label: 'Home',
                      onTap: () => controller.changeIndex(0),
                    ),
                    IconBottomAppBar(
                      selectedIcon: controller.currentIndex == 1,
                      icon: MediaRes.transactionIcon,
                      label: 'Transaction',
                      onTap: () => controller.changeIndex(1),
                    ),
                    const Icon(Icons.home, color: Colors.white),
                    IconBottomAppBar(
                      selectedIcon: controller.currentIndex == 2,
                      icon: MediaRes.pieChartIcon,
                      label: 'Budget',
                      onTap: () => controller.changeIndex(2),
                    ),
                    IconBottomAppBar(
                      selectedIcon: controller.currentIndex == 3,
                      icon: MediaRes.userIcon,
                      label: 'Profile',
                      onTap: () => controller.changeIndex(3),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
