import 'package:equatable/equatable.dart';
import 'package:montra_app/core/enums/update_user_information.dart';
import 'package:montra_app/core/usecase/usecase.dart';
import 'package:montra_app/core/utils/typedef.dart';
import 'package:montra_app/src/auth/domain/repos/auth_repo.dart';

class UpdateUserInformation
    extends UseCaseWithParams<void, UpdateUserInfoParams> {
  UpdateUserInformation(this._authRepo);

  final AuthRepo _authRepo;

  @override
  ResultFuture<void> call(UpdateUserInfoParams params) {
    return _authRepo.updateUserInformation(
      action: params.action,
      userData: params.userInfoData,
    );
  }
}

class UpdateUserInfoParams extends Equatable {
  const UpdateUserInfoParams({
    required this.action,
    required this.userInfoData,
  });

  const UpdateUserInfoParams.empty()
      : this(
          action: UpdateUserInfoAction.balance,
          userInfoData: 0,
        );

  final UpdateUserInfoAction action;
  final dynamic userInfoData;

  @override
  List<dynamic> get props => [action, userInfoData];
}
