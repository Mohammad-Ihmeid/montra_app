import 'package:equatable/equatable.dart';
import 'package:montra_app/core/usecase/usecase.dart';
import 'package:montra_app/core/utils/typedef.dart';
import 'package:montra_app/src/auth/domain/enities/user.dart';
import 'package:montra_app/src/auth/domain/repos/auth_repo.dart';

class SignIn extends UseCaseWithParams<LocalUser, SignInParams> {
  const SignIn(this._authRepo);

  final AuthRepo _authRepo;

  @override
  ResultFuture<LocalUser> call(SignInParams params) async {
    return _authRepo.signIn(
      email: params.email,
      password: params.password,
    );
  }
}

class SignInParams extends Equatable {
  const SignInParams({required this.email, required this.password});

  const SignInParams.empty() : this(email: '', password: '');

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}
