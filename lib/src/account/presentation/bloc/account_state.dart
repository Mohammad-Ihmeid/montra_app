part of 'account_bloc.dart';

class AccountState extends Equatable {
  const AccountState({
    this.accountsIcon = const [],
    this.getAccountsIconState = RequestState.loading,
    this.addAccountState = SaveState.normal,
    this.accounts = const [],
    this.errorMessage = '',
  });

  final List<String> accountsIcon;
  final RequestState getAccountsIconState;
  /////////////////////////////////////////////////////
  final SaveState addAccountState;
  /////////////////////////////////////////////////////
  final List<Account> accounts;
  /////////////////////////////////////////////////////
  final String errorMessage;

  AccountState copyWith({
    List<String>? accountsIcon,
    RequestState? getAccountsIconState,
    SaveState? addAccountState,
    String? errorMessage,
    List<Account>? accounts,
  }) {
    return AccountState(
      accountsIcon: accountsIcon ?? this.accountsIcon,
      getAccountsIconState: getAccountsIconState ?? this.getAccountsIconState,
      addAccountState: addAccountState ?? this.addAccountState,
      errorMessage: errorMessage ?? this.errorMessage,
      accounts: accounts ?? this.accounts,
    );
  }

  @override
  List<Object> get props => [
        accountsIcon,
        getAccountsIconState,
        addAccountState,
        accounts,
        errorMessage,
      ];
}
