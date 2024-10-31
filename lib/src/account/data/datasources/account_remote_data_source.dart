import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:montra_app/core/enums/update_account.dart';
import 'package:montra_app/core/errors/exceptions.dart';
import 'package:montra_app/core/utils/datasource_utils.dart';
import 'package:montra_app/core/utils/typedef.dart';
import 'package:montra_app/src/account/data/model/account_model.dart';
import 'package:montra_app/src/account/domain/entities/account.dart';

abstract class AccountRemoteDataSource {
  const AccountRemoteDataSource();

  Future<List<String>> getAccountsIcon();

  Future<void> addAccount(Account account);

  Future<void> editAccount({
    required String accountId,
    required UpdateAccountAction action,
    dynamic accountData,
  });

  Future<List<AccountModel>> getAccountsByUser();
}

class AccountRemoteDataSrcImp implements AccountRemoteDataSource {
  AccountRemoteDataSrcImp({
    required FirebaseFirestore firestore,
    required FirebaseStorage storage,
    required FirebaseAuth auth,
  })  : _firestore = firestore,
        _storage = storage,
        _auth = auth;

  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  final FirebaseAuth _auth;

  @override
  Future<List<String>> getAccountsIcon() async {
    try {
      await DatasourceUtils.authorizeUser(_auth);

      final storageRef = _storage.ref().child('AccountsType');

      final result = await storageRef.listAll();

      List<String> urls = [];
      for (final fileRef in result.items) {
        final downloadURL = await fileRef.getDownloadURL();
        urls.add(downloadURL);
      }

      return urls;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<void> addAccount(Account account) async {
    try {
      await DatasourceUtils.authorizeUser(_auth);

      final accountRef = _firestore.collection('accounts').doc();

      final accountyModel = account.toModel().copyWith(
            accountId: accountRef.id,
            uid: _auth.currentUser?.uid,
          );

      await accountRef.set(accountyModel.toMap());
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<List<AccountModel>> getAccountsByUser() async {
    try {
      await DatasourceUtils.authorizeUser(_auth);

      return _firestore
          .collection('accounts')
          .where('UID', isEqualTo: _auth.currentUser?.uid)
          .get()
          .then(
            (value) => value.docs
                .map((doc) => AccountModel.fromMap(doc.data()))
                .toList(),
          );
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<void> editAccount({
    required String accountId,
    required UpdateAccountAction action,
    dynamic accountData,
  }) async {
    try {
      await DatasourceUtils.authorizeUser(_auth);

      switch (action) {
        case UpdateAccountAction.balance:
          await _updateAccountData(
            accountId: accountId,
            data: {'Balance': accountData as double},
          );
        case UpdateAccountAction.description:
          await _updateAccountData(
            accountId: accountId,
            data: {'Description': accountData as String},
          );
        case UpdateAccountAction.image:
          await _updateAccountData(
            accountId: accountId,
            data: {'ImageAccount': accountData as String},
          );
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  Future<void> _updateAccountData({
    required String accountId,
    required DataMap data,
  }) async {
    await _firestore.collection('accounts').doc(accountId).update(data);
  }
}
