part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

class SignInEvent extends AuthEvent {
  const SignInEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<String> get props => [email, password];
}

class SignUpEvent extends AuthEvent {
  const SignUpEvent({
    required this.email,
    required this.password,
    required this.name,
  });

  final String email;
  final String password;
  final String name;

  @override
  List<String> get props => [email, password, name];
}

class ForgotPasswordEvent extends AuthEvent {
  const ForgotPasswordEvent({required this.email});

  final String email;

  @override
  List<String> get props => [email];
}

class UpdateUserEvent extends AuthEvent {
  UpdateUserEvent({
    required this.action,
    required this.userData,
  }) : assert(
          userData is String || userData is File,
          '[userData] must be either a String or a File, but '
          'was ${userData.runtimeType}',
        );

  final UpdateUserAction action;
  final dynamic userData;

  @override
  List<Object?> get props => [action, userData];
}

class UpdateUserInfoEvent extends AuthEvent {
  UpdateUserInfoEvent({
    required this.action,
    required this.userData,
  }) : assert(
          userData is String || userData is double,
          '[userData] must be either a String or a File, but '
          'was ${userData.runtimeType}',
        );

  final UpdateUserInfoAction action;
  final dynamic userData;

  @override
  List<Object?> get props => [action, userData];
}

class GetUserInfoEvent extends AuthEvent {
  const GetUserInfoEvent();

  @override
  List<Object?> get props => [];
}

class SendEmailVerifyEvent extends AuthEvent {
  const SendEmailVerifyEvent();

  @override
  List<Object> get props => [];
}
