part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _initAccount();
  await _initCategory();
  await _initOnBoarding();
  await _initAuth();
}

Future<void> _initAccount() async {
  sl
    ..registerFactory(
      () => AccountBloc(
        getAccountsIcon: sl(),
        getAccountsByUser: sl(),
        addAccount: sl(),
      ),
    )
    ..registerLazySingleton(() => GetAccountsIcon(sl()))
    ..registerLazySingleton(() => GetAccountsByUser(sl()))
    ..registerLazySingleton(() => AddAccount(sl()))
    ..registerLazySingleton<AccountRepo>(() => AccountRepoImpl(sl()))
    ..registerLazySingleton<AccountRemoteDataSource>(
      () => AccountRemoteDataSrcImp(firestore: sl(), storage: sl(), auth: sl()),
    );
}

Future<void> _initCategory() async {
  sl
    ..registerFactory(
      () => CategoryBloc(
        addCategory: sl(),
        getCategories: sl(),
        getCategoriesIcon: sl(),
        deleteCategory: sl(),
        editCategory: sl(),
      ),
    )
    ..registerLazySingleton(() => AddCategory(sl()))
    ..registerLazySingleton(() => GetCategories(sl()))
    ..registerLazySingleton(() => GetCategoriesIcon(sl()))
    ..registerLazySingleton(() => DeleteCategory(sl()))
    ..registerLazySingleton(() => EditCategory(sl()))
    ..registerLazySingleton<CategoryRepo>(() => CategoryRepoImpl(sl()))
    ..registerLazySingleton<CategoryRemoteDataSource>(
      () =>
          CategoryRemoteDataSrcImp(firestore: sl(), storage: sl(), auth: sl()),
    );
}

Future<void> _initAuth() async {
  sl
    ..registerFactory(
      () => AuthBloc(
        signIn: sl(),
        signUp: sl(),
        forgotPassword: sl(),
        updateUser: sl(),
        getUserInfo: sl(),
        updateUserInfo: sl(),
        sendEmailVerification: sl(),
      ),
    )
    ..registerLazySingleton(() => SignIn(sl()))
    ..registerLazySingleton(() => SignUp(sl()))
    ..registerLazySingleton(() => ForgotPassword(sl()))
    ..registerLazySingleton(() => UpdateUser(sl()))
    ..registerLazySingleton(() => GetUserInfoInformation(sl()))
    ..registerLazySingleton(() => UpdateUserInformation(sl()))
    ..registerLazySingleton(() => SendEmailVerify(sl()))
    ..registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl()))
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        authClient: sl(),
        cloudStoreClient: sl(),
        dbClient: sl(),
      ),
    )
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => FirebaseStorage.instance);
  /* مسجلات من قبل في ال Auth */
  // ..registerLazySingleton(() => FirebaseAuth.instance)
  // ..registerLazySingleton(() => FirebaseFirestore.instance)
  // ..registerLazySingleton(() => FirebaseStorage.instance);
}

Future<void> _initOnBoarding() async {
  final prefs = await SharedPreferences.getInstance();
  // Feature --> OnBoarding
  // Business Logic
  sl
    ..registerFactory(
      () =>
          OnBoardingCubit(cacheFirstTimer: sl(), checkIfUserIsFirstTimer: sl()),
    )
    ..registerLazySingleton(() => CacheFirstTimer(sl()))
    ..registerLazySingleton(() => CheckIfUserIsFirstTimer(sl()))
    ..registerLazySingleton<OnBoardingRepo>(() => OnBoardingRepoImpl(sl()))
    ..registerLazySingleton<OnBoardingLocalDataSource>(
      () => OnBoardingLocalDataSrcImpl(sl()),
    )
    ..registerLazySingleton(() => prefs);
}
