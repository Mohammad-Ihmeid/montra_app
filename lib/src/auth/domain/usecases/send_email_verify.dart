import 'package:montra_app/core/usecase/usecase.dart';
import 'package:montra_app/core/utils/typedef.dart';
import 'package:montra_app/src/auth/domain/repos/auth_repo.dart';

class SendEmailVerify extends UseCaseWithoutParams<void> {
  SendEmailVerify(this._authRepo);

  final AuthRepo _authRepo;

  @override
  ResultFuture<void> call() => _authRepo.sendEmailVerify();
}
