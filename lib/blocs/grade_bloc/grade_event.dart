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
  final Map<String, UserAnswerModel> userAnswers;

  const GradeLoadedEvent(this.userAnswers);
}

class GradeSendAnswerEvent extends GradeEvent {
  const GradeSendAnswerEvent();
}
