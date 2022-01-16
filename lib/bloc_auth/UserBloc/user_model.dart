part of 'user_bloc.dart';


class UserModel {
  String firstName;
  String lastName;
  String email;
  String userStatus;
  String uid;

  UserModel({this.email, this.firstName, this.lastName, this.userStatus,this.uid});

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    print("value123 = ${data}");
    return UserModel(
      firstName: data['firstName'],
      lastName: data['lastName'],
      email: data['email'],
      userStatus: data['userStatus'],
      uid: doc.id,
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return "firstName: $firstName, lastName: $lastName, email: $email,userStatus $userStatus, uid $uid";

  }
}

