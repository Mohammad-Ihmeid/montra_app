import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_app/core/enums/update_user.dart';
import 'package:montra_app/core/enums/update_user_information.dart';
import 'package:montra_app/src/auth/domain/enities/user.dart';
import 'package:montra_app/src/auth/domain/enities/user_information.dart';
import 'package:montra_app/src/auth/domain/usecases/forgot_password.dart';
import 'package:montra_app/src/auth/domain/usecases/get_user_info_information.dart';
import 'package:montra_app/src/auth/domain/usecases/send_email_verify.dart';
import 'package:montra_app/src/auth/domain/usecases/sign_in.dart';
import 'package:montra_app/src/auth/domain/usecases/sign_up.dart';
import 'package:montra_app/src/auth/domain/usecases/update_user.dart';
import 'package:montra_app/src/auth/domain/usecases/update_user_information.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required SignIn signIn,
    required SignUp signUp,
    required ForgotPassword forgotPassword,
    required UpdateUser updateUser,
    required GetUserInfoInformation getUserInfo,
    required UpdateUserInformation updateUserInfo,
    required SendEmailVerify sendEmailVerification,
  })  : _signIn = signIn,
        _signUp = signUp,
        _forgotPassword = forgotPassword,
        _updateUser = updateUser,
        _getUserInfo = getUserInfo,
        _updateUserInfo = updateUserInfo,
        _sendEmailVerification = sendEmailVerification,
        super(const AuthInitial()) {
    // on<AuthEvent>((event, emit) {
    //   emit(const AuthLoading());
    // });

    on<SignInEvent>(_signInHandler);

    on<SignUpEvent>(_signUpHandler);

    on<ForgotPasswordEvent>(_forgotPasswordHandler);

    on<SendEmailVerifyEvent>(_sendEmailVerifyHandler);

    on(_updateUserHandler);

    on<UpdateUserInfoEvent>(_updateUserInfoHandler);
  }

  final SignIn _signIn;
  final SignUp _signUp;
  final ForgotPassword _forgotPassword;
  final UpdateUser _updateUser;
  final GetUserInfoInformation _getUserInfo;
  final UpdateUserInformation _updateUserInfo;
  final SendEmailVerify _sendEmailVerification;

  FutureOr<void> _signInHandler(
    SignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await _signIn(
      SignInParams(
        email: event.email,
        password: event.password,
      ),
    );

    final dataUser = await _getUserInfo();

    result.fold(
      (faliure) => emit(AuthError(faliure.errorMessage)),
      (user) {
        dataUser.fold(
          (faliure) => emit(AuthError(faliure.errorMessage)),
          (userData) => emit(SignedIn(user, userData)),
        );
      },
    );
  }

  FutureOr<void> _signUpHandler(
    SignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await _signUp(
      SignUpParams(
        email: event.email,
        fullName: event.name,
        password: event.password,
      ),
    );

    result.fold(
      (faliure) => emit(AuthError(faliure.errorMessage)),
      (_) => emit(const SignedUp()),
    );
  }

  FutureOr<void> _forgotPasswordHandler(
    ForgotPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _forgotPassword(event.email);

    result.fold(
      (faliure) => emit(AuthError(faliure.errorMessage)),
      (_) => emit(const ForgotPasswordSent()),
    );
  }

  FutureOr<void> _updateUserHandler(
    UpdateUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _updateUser(
      UpdateUserParams(
        action: event.action,
        userData: event.userData,
      ),
    );

    result.fold(
      (faliure) => emit(AuthError(faliure.errorMessage)),
      (_) => emit(const UserUpdated()),
    );
  }

  FutureOr<void> _updateUserInfoHandler(
    UpdateUserInfoEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _updateUserInfo(
      UpdateUserInfoParams(
        action: event.action,
        userInfoData: event.userData,
      ),
    );

    result.fold(
      (faliure) => emit(AuthError(faliure.errorMessage)),
      (_) => emit(const UserUpdated()),
    );
  }

  FutureOr<void> _sendEmailVerifyHandler(
    SendEmailVerifyEvent event,
    Emitter<AuthState> emit,
  ) async {
    await _sendEmailVerification();
  }
}
