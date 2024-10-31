import 'package:montra_app/core/usecase/usecase.dart';
import 'package:montra_app/core/utils/typedef.dart';
import 'package:montra_app/src/account/domain/repos/account_repo.dart';

class GetAccountsIcon extends UseCaseWithoutParams<List<String>> {
  GetAccountsIcon(this._accountRepo);

  final AccountRepo _accountRepo;

  @override
  ResultFuture<List<String>> call() => _accountRepo.getAccountsIcon();
}
