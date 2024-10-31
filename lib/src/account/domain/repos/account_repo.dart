import 'package:montra_app/core/enums/update_account.dart';
import 'package:montra_app/core/utils/typedef.dart';
import 'package:montra_app/src/account/domain/entities/account.dart';

abstract class AccountRepo {
  AccountRepo();

  ResultFuture<List<String>> getAccountsIcon();

  ResultVoid addAccount(Account account);

  ResultVoid editAccount({
    required String accountId,
    required UpdateAccountAction action,
    required dynamic accountData,
  });

  ResultFuture<List<Account>> getAccountsByUser();
}
