import 'package:montra_app/core/utils/typedef.dart';
import 'package:montra_app/src/auth/domain/enities/user_information.dart';

class UserInformationModel extends UserInformation {
  const UserInformationModel({
    required super.userId,
    required super.balance,
  });

  UserInformationModel.fromMap(DataMap map)
      : super(
          userId: map['UserId'] as String,
          balance: (map['Balance'] as num).toDouble(),
        );

  const UserInformationModel.empty()
      : this(
          userId: '',
          balance: 0,
        );

  UserInformationModel copyWith({
    double? balance,
    String? userId,
  }) {
    return UserInformationModel(
      userId: userId ?? this.userId,
      balance: balance ?? this.balance,
    );
  }

  DataMap toMap() {
    return {
      'UserId': userId,
      'Balance': balance,
    };
  }
}
