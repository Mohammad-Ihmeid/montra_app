import 'package:montra_app/core/enums/update_user.dart';
import 'package:montra_app/core/enums/update_user_information.dart';
import 'package:montra_app/core/utils/typedef.dart';
import 'package:montra_app/src/auth/domain/enities/user.dart';
import 'package:montra_app/src/auth/domain/enities/user_information.dart';

abstract class AuthRepo {
  AuthRepo();

  ResultFuture<void> forgotPassword(String email);

  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  });

  ResultFuture<void> signUp({
    required String email,
    required String fullName,
    required String password,
  });

  ResultFuture<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  });

  ResultFuture<void> sendEmailVerify();

  ResultFuture<UserInformation> getUserInformation();

  ResultFuture<void> updateUserInformation({
    required UpdateUserInfoAction action,
    required dynamic userData,
  });
}
