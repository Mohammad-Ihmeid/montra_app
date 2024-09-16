part of 'add_transaction_bloc.dart';

sealed class AddTransactionState extends Equatable {
  const AddTransactionState();
  
  @override
  List<Object> get props => [];
}

final class AddTransactionInitial extends AddTransactionState {}
