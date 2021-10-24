class UserAnswerModel {
  final String answer;
  final String timeCreated;
  final String userID;
  int mark;
  List statusList;
  String comment;

  UserAnswerModel({this.answer, this.timeCreated, this.userID, this.mark, this.statusList, this.comment});
}