import 'package:montra_app/core/usecase/usecase.dart';
import 'package:montra_app/core/utils/typedef.dart';
import 'package:montra_app/src/account/domain/entities/account.dart';
import 'package:montra_app/src/account/domain/repos/account_repo.dart';

class GetAccountsByUser extends UseCaseWithoutParams<List<Account>> {
  const GetAccountsByUser(this._accountRepo);

  final AccountRepo _accountRepo;

  @override
  ResultFuture<List<Account>> call() => _accountRepo.getAccountsByUser();
}
