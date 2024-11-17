part of 'router.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return _pageBuilder(
        (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<OnBoardingCubit>()),
            BlocProvider(create: (_) => sl<AuthBloc>()),
          ],
          child: const SplashScreen(),
        ),
        settings: settings,
      );
    case OnBoardingScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<OnBoardingCubit>(),
          child: const OnBoardingScreen(),
        ),
        settings: settings,
      );
    case SignUpScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const SignUpScreen(),
        ),
        settings: settings,
      );
    case SignInScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const SignInScreen(),
        ),
        settings: settings,
      );
    case EmailVerifyScreen.routeName:
      return _pageBuilder(
        (context) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: EmailVerifyScreen(
            settings.arguments! as String,
          ),
        ),
        settings: settings,
      );
    case Dashboard.routeName:
      return _pageBuilder(
        (context) => const Dashboard(),
        settings: settings,
      );
    case ExpenseScreen.routeName:
      return _pageBuilder(
        (context) => BlocProvider(
          create: (context) => sl<CategoryBloc>(),
          child: const ExpenseScreen(),
        ),
        settings: settings,
      );
    case IncomeScreen.routeName:
      return _pageBuilder(
        (context) => const IncomeScreen(),
        settings: settings,
      );
    case TransferScreen.routeName:
      return _pageBuilder(
        (context) => const TransferScreen(),
        settings: settings,
      );
    case CategoryScreen.routeName:
      return _pageBuilder(
        (context) => BlocProvider(
          create: (_) => sl<CategoryBloc>(),
          child: CategoryScreen(settings.arguments! as int),
        ),
        settings: settings,
      );
    case AccountScreen.routeName:
      return _pageBuilder(
        (context) => const AccountScreen(),
        settings: settings,
      );
    case AddAccountScreen.routeName:
      return _pageBuilder(
        (context) => MultiBlocProvider(
          providers: <SingleChildWidget>[
            BlocProvider<AccountBloc>(create: (dynamic _) => sl<AccountBloc>()),
            BlocProvider<AuthBloc>(create: (dynamic _) => sl<AuthBloc>()),
          ],
          child: const AddAccountScreen(),
        ),
        settings: settings,
      );
    default:
      return _pageBuilder(
        (_) => const PageUnderConstruction(),
        settings: settings,
      );
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    settings: settings,
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
    pageBuilder: (context, _, __) => page(context),
  );
}
