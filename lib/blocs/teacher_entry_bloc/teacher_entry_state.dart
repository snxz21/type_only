part of 'teacher_entry_bloc.dart';

@immutable
abstract class TeacherEntryState {  const TeacherEntryState();
}

class TeacherEntryInitialState extends TeacherEntryState {}

class TeacherEntryLoadedState extends TeacherEntryState {
  final List<QuestionModel> loadedQuestionList;

  const TeacherEntryLoadedState(this.loadedQuestionList);
}

class OnErrorTeacherEntryState extends TeacherEntryState {}
