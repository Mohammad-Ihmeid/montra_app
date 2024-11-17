import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:montra_app/core/enums/enums.dart';
import 'package:montra_app/src/account/domain/entities/account.dart';
import 'package:montra_app/src/account/domain/usecases/add_account.dart';
import 'package:montra_app/src/account/domain/usecases/get_accounts_by_user.dart';
import 'package:montra_app/src/account/domain/usecases/get_accounts_icon.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc({
    required GetAccountsIcon getAccountsIcon,
    required GetAccountsByUser getAccountsByUser,
    required AddAccount addAccount,
  })  : _getAccountsIcon = getAccountsIcon,
        _getAccountsByUser = getAccountsByUser,
        _addAccount = addAccount,
        super(const AccountState()) {
    on<GetAccountsIconEvent>(_getAccountsIconHandler);

    on<AddAccountEvent>(_addAccountHandler);
  }

  final GetAccountsIcon _getAccountsIcon;
  final GetAccountsByUser _getAccountsByUser;
  final AddAccount _addAccount;

  FutureOr<void> _addAccountHandler(
    AddAccountEvent event,
    Emitter<AccountState> emit,
  ) async {
    emit(state.copyWith(addAccountState: SaveState.loading));

    final result = await _addAccount(
      Account(
        accountId: '',
        uid: '',
        balance: event.balance,
        description: event.description,
        image: event.image,
      ),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          addAccountState: SaveState.error,
          errorMessage: failure.errorMessage,
        ),
      ),
      (_) => emit(state.copyWith(addAccountState: SaveState.success)),
    );
  }

  FutureOr<void> _getAccountsIconHandler(
    GetAccountsIconEvent event,
    Emitter<AccountState> emit,
  ) async {
    emit(state.copyWith(getAccountsIconState: RequestState.loading));

    final result = await _getAccountsIcon();

    result.fold(
      (failure) => emit(
        state.copyWith(
          getAccountsIconState: RequestState.error,
          errorMessage: failure.errorMessage,
        ),
      ),
      (icon) => emit(
        state.copyWith(
          getAccountsIconState: RequestState.loaded,
          accountsIcon: icon,
        ),
      ),
    );
  }

  FutureOr<void> _getAccountHandler() {}
}
