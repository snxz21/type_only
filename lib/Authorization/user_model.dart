import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  // field
  String firstName;
  String lastName;
  String email;
  String userStatus;

  UserModel({this.email, this.firstName, this.lastName, this.userStatus});
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();

    return UserModel(
      firstName: data['firstName'],
      lastName: data['lastName'],
      email: data['email'],
      userStatus: data['userStatus'],
    );
  }
}
