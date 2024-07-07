// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class LocalUser extends Equatable {
  const LocalUser({
    required this.uid,
    required this.email,
    required this.userName,
    this.profilePic,
  });

  const LocalUser.empty()
      : this(
          uid: '',
          email: '',
          userName: '',
        );

  final String uid;
  final String email;
  final String? profilePic;
  final String userName;

  @override
  List<Object?> get props => [
        uid,
        email,
        profilePic,
        userName,
      ];

  @override
  String toString() {
    return 'LocalUser{uid: $uid, email: $email, fullName: $userName}';
  }
}
