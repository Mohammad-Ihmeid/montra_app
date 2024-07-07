import 'package:montra_app/core/utils/typedef.dart';
import 'package:montra_app/src/auth/domain/enities/user.dart';

class LocalUserModel extends LocalUser {
  const LocalUserModel({
    required super.uid,
    required super.email,
    required super.userName,
    super.profilePic,
  });

  LocalUserModel.fromMap(DataMap map)
      : super(
          uid: map['UID'] as String,
          email: map['Email'] as String,
          userName: map['UserName'] as String,
          profilePic: map['ProfilePicture'] as String?,
        );

  const LocalUserModel.empty()
      : this(
          uid: '',
          email: '',
          userName: '',
        );

  LocalUserModel copyWith({
    String? uid,
    String? email,
    String? userName,
    String? profilePic,
  }) {
    return LocalUserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      userName: userName ?? this.userName,
      profilePic: profilePic ?? this.profilePic,
    );
  }

  DataMap toMap() {
    return {
      'UID': uid,
      'Email': email,
      'UserName': userName,
      'ProfilePicture': profilePic,
    };
  }
}
