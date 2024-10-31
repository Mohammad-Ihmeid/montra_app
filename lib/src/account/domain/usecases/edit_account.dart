import 'package:equatable/equatable.dart';
import 'package:montra_app/core/enums/update_account.dart';
import 'package:montra_app/core/usecase/usecase.dart';
import 'package:montra_app/core/utils/typedef.dart';
import 'package:montra_app/src/account/domain/repos/account_repo.dart';

class EditAccount extends UseCaseWithParams<void, UpdateAccountParams> {
  const EditAccount(this._accountRepo);

  final AccountRepo _accountRepo;

  @override
  ResultFuture<void> call(UpdateAccountParams params) {
    return _accountRepo.editAccount(
      accountId: params.accountId,
      action: params.action,
      accountData: params.accountData,
    );
  }
}

class UpdateAccountParams extends Equatable {
  const UpdateAccountParams({
    required this.accountId,
    required this.action,
    required this.accountData,
  });

  const UpdateAccountParams.empty()
      : this(
          accountId: '',
          action: UpdateAccountAction.description,
          accountData: '',
        );

  final String accountId;
  final UpdateAccountAction action;
  final dynamic accountData;

  @override
  List<dynamic> get props => [accountId, action, accountData];
}
