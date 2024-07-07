import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:montra_app/core/common/app/providers/user_provider.dart';
import 'package:montra_app/core/extensions/context_extension.dart';
import 'package:montra_app/core/res/theme_data/theme_data_light.dart';
import 'package:montra_app/core/services/injection_container.dart';
import 'package:montra_app/core/services/router.dart';
import 'package:montra_app/firebase_options.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        onGenerateTitle: (context) => context.langauage.appName,
        debugShowCheckedModeBanner: false,
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: themeDataLight(),
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
