part of 'grade_bloc.dart';

@immutable
abstract class GradeEvent {
  const GradeEvent();
}

class GradeLoadingEvent extends GradeEvent {
  final String questionID;
  final List student;

  const GradeLoadingEvent({this.questionID, this.student});
}

class GradeLoadedEvent extends GradeEvent {
  final Map<UserModel, UserAnswerModel> userAnswers;
  // final UserModel userModel;

  const GradeLoadedEvent(this.userAnswers);
}

class GradeSendAnswerEvent extends GradeEvent {
  final int mark;
  final String teachersComment;
  final String sudentsID;
  final String quesionID;
  final List statusList;
  final List studentList;

  const GradeSendAnswerEvent({this.mark, this.teachersComment, this.sudentsID, this.quesionID, this.statusList,this.studentList});
}
