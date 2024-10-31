import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:montra_app/core/enums/update_user.dart';
import 'package:montra_app/core/enums/update_user_information.dart';
import 'package:montra_app/core/errors/exceptions.dart';
import 'package:montra_app/core/utils/constants.dart';
import 'package:montra_app/core/utils/datasource_utils.dart';
import 'package:montra_app/core/utils/typedef.dart';
import 'package:montra_app/src/auth/data/model/user_information_model.dart';
import 'package:montra_app/src/auth/data/model/user_model.dart';

abstract class AuthRemoteDataSource {
  const AuthRemoteDataSource();

  Future<void> forgotPassword(String email);

  Future<LocalUserModel> signIn({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required String email,
    required String fullName,
    required String password,
  });

  Future<void> updateUser({
    required UpdateUserAction action,
    dynamic userData,
  });

  Future<void> sendEmailVerification();

  Future<bool> checkEmailVerify();

  Future<UserInformationModel> getUserInformation();

  Future<void> updateUserInformation({
    required UpdateUserInfoAction action,
    dynamic userInfoData,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({
    required FirebaseAuth authClient,
    required FirebaseFirestore cloudStoreClient,
    required FirebaseStorage dbClient,
  })  : _authClient = authClient,
        _cloudStoreClient = cloudStoreClient,
        _dbClient = dbClient;

  final FirebaseAuth _authClient;
  final FirebaseFirestore _cloudStoreClient;
  final FirebaseStorage _dbClient;

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _authClient.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? '',
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  @override
  Future<LocalUserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _authClient.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = result.user;

      if (user == null) {
        throw const ServerException(
          message: 'Please try again later',
          statusCode: 'Unknown Error',
        );
      }

      var userData = await _getUserData(user.uid);

      if (userData.exists) {
        return LocalUserModel.fromMap(userData.data()!);
      }

      // upload the user
      await _setUserData(user, email);

      userData = await _getUserData(user.uid);
      return LocalUserModel.fromMap(userData.data()!);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? '',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  @override
  Future<void> signUp({
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      final userCred = await _authClient.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCred.user?.updateDisplayName(fullName);
      await userCred.user?.updatePhotoURL(kDefaultAvatar);
      await _setUserData(_authClient.currentUser!, email);

      final userInfoRef =
          _cloudStoreClient.collection('users_information').doc();

      final userInfoModel = const UserInformationModel.empty().copyWith(
        userId: _authClient.currentUser!.uid,
      );

      await userInfoRef.set(userInfoModel.toMap());
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? '',
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  @override
  Future<void> updateUser({
    required UpdateUserAction action,
    dynamic userData,
  }) async {
    try {
      switch (action) {
        case UpdateUserAction.email:
          // await _authClient.currentUser
          //     ?.verifyBeforeUpdateEmail(userData as String);
          await _authClient.currentUser?.updateEmail(userData as String);
          await _updateUserData({'email': userData});
        case UpdateUserAction.displayName:
          await _authClient.currentUser?.updateDisplayName(userData as String);
          await _updateUserData({'fullName': userData});
        case UpdateUserAction.profilePic:
          final ref = _dbClient
              .ref()
              .child('profile_pics/${_authClient.currentUser?.uid}');
          await ref.putFile(userData as File);
          final url = await ref.getDownloadURL();
          await _authClient.currentUser?.updatePhotoURL(url);
          await _updateUserData({'profilePic': url});
        case UpdateUserAction.password:
          if (_authClient.currentUser?.email == null) {
            throw const ServerException(
              message: 'User does not exist',
              statusCode: 'Insufficient Permission',
            );
          }
          final newData = jsonDecode(userData as String) as DataMap;
          await _authClient.currentUser?.reauthenticateWithCredential(
            EmailAuthProvider.credential(
              email: _authClient.currentUser!.email!,
              password: newData['oldPassword'] as String,
            ),
          );

          await _authClient.currentUser
              ?.updatePassword(newData['newPassword'] as String);
      }
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? '',
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    try {
      await DatasourceUtils.authorizeUser(_authClient);

      await _authClient.currentUser!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? '',
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  @override
  Future<bool> checkEmailVerify() async {
    await DatasourceUtils.authorizeUser(_authClient);

    final user = _authClient.currentUser!;

    await user.reload();

    if (user.emailVerified) return true;

    return false;
  }

  @override
  Future<UserInformationModel> getUserInformation() async {
    try {
      await DatasourceUtils.authorizeUser(_authClient);

      final uid = _authClient.currentUser!.uid;

      final querySnapshot = await _cloudStoreClient
          .collection('users_information')
          .where('UID', isEqualTo: _authClient.currentUser!.uid)
          .get();

      if (querySnapshot.docs.first.exists) {
        return UserInformationModel.fromMap(querySnapshot.docs.first.data());
      }

      throw Exception('No user found with UID $uid');
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? '',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  @override
  Future<void> updateUserInformation({
    required UpdateUserInfoAction action,
    dynamic userInfoData,
  }) async {
    try {
      await DatasourceUtils.authorizeUser(_authClient);

      switch (action) {
        case UpdateUserInfoAction.balance:
          await _updateUserInformation({'Balance': userInfoData});
      }
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? '',
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  Future<DocumentSnapshot<DataMap>> _getUserData(String uid) async {
    return _cloudStoreClient.collection('users').doc(uid).get();
  }

  Future<void> _setUserData(User user, String fallbackEmail) async {
    await _cloudStoreClient.collection('users').doc(user.uid).set(
          LocalUserModel(
            uid: user.uid,
            email: user.email ?? fallbackEmail,
            userName: user.displayName ?? '',
            profilePic: user.photoURL ?? '',
          ).toMap(),
        );
  }

  Future<void> _updateUserData(DataMap data) async {
    await _cloudStoreClient
        .collection('users')
        .doc(
          _authClient.currentUser?.uid,
        )
        .update(data);
  }

  Future<void> _updateUserInformation(DataMap data) async {
    await _cloudStoreClient
        .collection('users_information')
        .where('UID', isEqualTo: _authClient.currentUser!.uid)
        .get()
        .then((querySnapshot) {
      // Check if there is a document with the specified UID
      if (querySnapshot.docs.isNotEmpty) {
        // Get the document ID of the first result (assuming only one result)
        final docId = querySnapshot.docs.first.id;

        // Now, update the document using its ID
        _cloudStoreClient
            .collection('users_information')
            .doc(docId)
            .update(data)
            .then((_) {});
      }
    });
  }
}
