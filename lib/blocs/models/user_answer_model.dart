import 'package:cloud_firestore/cloud_firestore.dart';

class UserAnswerModel {
  final String answer;
  final String timeCreated;
  final String userID;
  int mark;
  List statusList;
  String comment;

  UserAnswerModel(
      {this.answer,
      this.timeCreated,
      this.userID,
      this.mark,
      this.statusList,
      this.comment});

  factory UserAnswerModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();

    return UserAnswerModel(
      answer: data["answer"] ?? "",
      timeCreated: data["timeCreated"] ?? "",
      userID: data["userID"] ?? 10,
      mark: data["mark"] ?? 10,
      statusList: data["statusList"] ?? 10,
      comment: data["comment"] ?? [],
    );
  }
}
