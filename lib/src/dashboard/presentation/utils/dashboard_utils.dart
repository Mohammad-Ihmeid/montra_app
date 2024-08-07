import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:montra_app/core/services/injection_container.dart';
import 'package:montra_app/src/auth/data/model/user_model.dart';

class DashboardUtils {
  const DashboardUtils._();

  static Stream<LocalUserModel> get userDataStream => sl<FirebaseFirestore>()
      .collection('users')
      .doc(sl<FirebaseAuth>().currentUser!.uid)
      .snapshots()
      .map((event) => LocalUserModel.fromMap(event.data()!));
}
