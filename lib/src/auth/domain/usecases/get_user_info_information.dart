import 'package:montra_app/core/usecase/usecase.dart';
import 'package:montra_app/core/utils/typedef.dart';
import 'package:montra_app/src/auth/domain/enities/user_information.dart';
import 'package:montra_app/src/auth/domain/repos/auth_repo.dart';

class GetUserInfoInformation extends UseCaseWithoutParams<UserInformation> {
  GetUserInfoInformation(this._authRepo);

  final AuthRepo _authRepo;

  @override
  ResultFuture<UserInformation> call() async {
    return _authRepo.getUserInformation();
  }
}
