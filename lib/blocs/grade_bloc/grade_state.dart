part of 'grade_bloc.dart';

@immutable
abstract class GradeState {  const GradeState();
}

class GradeInitialState extends GradeState {}

class GradeLoadedState extends GradeState {
  final Map<UserModel, UserAnswerModel> userAnswers;

  const GradeLoadedState(this.userAnswers);
}

class OnErrorGradeState extends GradeState {}

