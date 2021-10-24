part of 'user_bloc.dart';

abstract class SingleUserRepository {
  Stream<UserModel> getUserInfo(uid);
}

class SingleFirebaseUserRepository implements SingleUserRepository {
  @override
  Stream<UserModel> getUserInfo(uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((snap) => UserModel.fromFirestore(snap));
  }
}
