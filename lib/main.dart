import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/theme_data/theme_data_light.dart';
import 'package:montra_app/core/services/injection_container.dart';
import 'package:montra_app/core/services/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => context.langauage.appName,
      debugShowCheckedModeBanner: false,
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: themeDataLight(),
      onGenerateRoute: generateRoute,
    );
  }
}
