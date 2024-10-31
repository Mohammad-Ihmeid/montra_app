part of 'account_bloc.dart';

sealed class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class GetAccountsIconEvent extends AccountEvent {
  const GetAccountsIconEvent();
}

class AddAccountEvent extends AccountEvent {
  const AddAccountEvent({
    required this.balance,
    required this.description,
    required this.image,
  });

  final double balance;
  final String description;
  final String image;

  @override
  List<Object> get props => [balance, description, image];
}
