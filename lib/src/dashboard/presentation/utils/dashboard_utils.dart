import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:montra_app/core/services/injection_container.dart';
import 'package:montra_app/src/auth/data/model/user_information_model.dart';
import 'package:montra_app/src/auth/data/model/user_model.dart';
import 'package:rxdart/rxdart.dart';

class DashboardUtils {
  DashboardUtils._();

  static final combinedStream = Rx.combineLatest2(
    userDataStream,
    userInfoStream,
    (LocalUserModel userDataStream, UserInformationModel userInfoStream) {
      return CombinedData(
        userDataStream: userDataStream,
        userInfoStream: userInfoStream,
      );
    },
  );

  static Stream<LocalUserModel> get userDataStream => sl<FirebaseFirestore>()
      .collection('users')
      .doc(sl<FirebaseAuth>().currentUser!.uid)
      .snapshots()
      .map((event) => LocalUserModel.fromMap(event.data()!));

  static Stream<UserInformationModel> get userInfoStream =>
      sl<FirebaseFirestore>()
          .collection('users_information')
          .where('UserId', isEqualTo: sl<FirebaseAuth>().currentUser!.uid)
          .snapshots()
          .map(
            (value) => UserInformationModel.fromMap(value.docs.first.data()),
          );
}

class CombinedData {
  CombinedData({
    required this.userDataStream,
    required this.userInfoStream,
  });
  final LocalUserModel? userDataStream;
  final UserInformationModel? userInfoStream;
}
