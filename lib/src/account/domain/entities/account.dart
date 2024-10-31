// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:montra_app/src/account/data/model/account_model.dart';

class Account extends Equatable {
  const Account({
    required this.accountId,
    required this.uid,
    required this.balance,
    required this.description,
    required this.image,
  });

  const Account.empty()
      : this(
          accountId: '',
          uid: '',
          balance: 0,
          description: '',
          image: '',
        );

  AccountModel toModel() {
    return AccountModel(
      accountId: accountId,
      uid: uid,
      balance: balance,
      description: description,
      image: image,
    );
  }

  final String accountId;
  final String uid;
  final double balance;
  final String description;
  final String image;

  @override
  List<Object> get props {
    return [
      accountId,
      uid,
      balance,
      description,
      image,
    ];
  }
}
