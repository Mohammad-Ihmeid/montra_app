import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:montra_app/core/services/injection_container.dart';
import 'package:montra_app/src/account/data/model/account_model.dart';

class AccountUtils {
  const AccountUtils._();

  static Stream<List<AccountModel>> get accountStream => sl<FirebaseFirestore>()
      .collection('accounts')
      .where('UID', isEqualTo: sl<FirebaseAuth>().currentUser!.uid)
      .snapshots()
      .map(
        (value) =>
            value.docs.map((doc) => AccountModel.fromMap(doc.data())).toList(),
      );
}
