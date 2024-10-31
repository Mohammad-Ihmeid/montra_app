// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UserInformation extends Equatable {
  const UserInformation({
    required this.userId,
    required this.balance,
  });

  final String userId;
  final double balance;

  const UserInformation.empty()
      : this(
          userId: '',
          balance: 0,
        );

  @override
  List<Object> get props => [balance, userId];
}
