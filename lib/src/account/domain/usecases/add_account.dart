import 'package:montra_app/core/usecase/usecase.dart';
import 'package:montra_app/core/utils/typedef.dart';
import 'package:montra_app/src/account/domain/entities/account.dart';
import 'package:montra_app/src/account/domain/repos/account_repo.dart';

class AddAccount extends UseCaseWithParams<void, Account> {
  AddAccount(this._accountRepo);

  final AccountRepo _accountRepo;

  @override
  ResultFuture<void> call(Account params) => _accountRepo.addAccount(params);
}
