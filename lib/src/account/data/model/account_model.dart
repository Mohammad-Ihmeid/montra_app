import 'package:montra_app/core/utils/typedef.dart';
import 'package:montra_app/src/account/domain/entities/account.dart';

class AccountModel extends Account {
  const AccountModel({
    required super.accountId,
    required super.uid,
    required super.balance,
    required super.description,
    required super.image,
  });

  const AccountModel.empty()
      : this(
          accountId: '',
          uid: '',
          balance: 0,
          description: '',
          image: '',
        );

  AccountModel.fromMap(DataMap map)
      : super(
          accountId: map['AccountID'] as String,
          uid: map['UID'] as String,
          balance: (map['Balance'] as num).toDouble(),
          description: map['Description'] as String,
          image: map['ImageAccount'] as String,
        );

  AccountModel copyWith({
    String? accountId,
    String? uid,
    double? balance,
    String? description,
    String? image,
  }) {
    return AccountModel(
      accountId: accountId ?? this.accountId,
      uid: uid ?? this.uid,
      balance: balance ?? this.balance,
      description: description ?? this.description,
      image: image ?? this.image,
    );
  }

  DataMap toMap() {
    return {
      'AccountID': accountId,
      'UID': uid,
      'Balance': balance,
      'Description': description,
      'ImageAccount': image,
    };
  }
}
