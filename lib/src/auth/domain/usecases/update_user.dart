import 'package:equatable/equatable.dart';
import 'package:montra_app/core/enums/update_user.dart';
import 'package:montra_app/core/usecase/usecase.dart';
import 'package:montra_app/core/utils/typedef.dart';
import 'package:montra_app/src/auth/domain/repos/auth_repo.dart';

class UpdateUser extends UseCaseWithParams<void, UpdateUserParams> {
  const UpdateUser(this._authRepo);

  final AuthRepo _authRepo;

  @override
  ResultFuture<void> call(UpdateUserParams params) {
    return _authRepo.updateUser(
      action: params.action,
      userData: params.userData,
    );
  }
}

class UpdateUserParams extends Equatable {
  const UpdateUserParams({required this.action, required this.userData});

  const UpdateUserParams.empty()
      : this(
          action: UpdateUserAction.displayName,
          userData: '',
        );

  final UpdateUserAction action;
  final dynamic userData;

  @override
  List<dynamic> get props => [action, userData];
}
