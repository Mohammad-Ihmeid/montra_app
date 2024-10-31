import 'package:dartz/dartz.dart';
import 'package:montra_app/core/enums/update_account.dart';
import 'package:montra_app/core/errors/exceptions.dart';
import 'package:montra_app/core/errors/failure.dart';
import 'package:montra_app/core/utils/typedef.dart';
import 'package:montra_app/src/account/data/datasources/account_remote_data_source.dart';
import 'package:montra_app/src/account/domain/entities/account.dart';
import 'package:montra_app/src/account/domain/repos/account_repo.dart';

class AccountRepoImpl implements AccountRepo {
  AccountRepoImpl(this._remoteDataSrc);

  final AccountRemoteDataSource _remoteDataSrc;

  @override
  ResultFuture<List<String>> getAccountsIcon() async {
    try {
      final result = await _remoteDataSrc.getAccountsIcon();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultVoid addAccount(Account account) async {
    try {
      final result = await _remoteDataSrc.addAccount(account);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Account>> getAccountsByUser() async {
    try {
      final result = await _remoteDataSrc.getAccountsByUser();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultVoid editAccount({
    required String accountId,
    required UpdateAccountAction action,
    required dynamic accountData,
  }) async {
    try {
      final result = await _remoteDataSrc.editAccount(
        accountId: accountId,
        action: action,
        accountData: accountData,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
