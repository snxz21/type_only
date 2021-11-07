part of 'teacher_entry_bloc.dart';

@immutable
abstract class TeacherEntryEvent {
  const TeacherEntryEvent();
}

class TeacherEntryLoadingEvent extends TeacherEntryEvent {
  const TeacherEntryLoadingEvent();
}

class TeacherEntryLoadedEvent extends TeacherEntryEvent {
  final List<QuestionModel> loadedQuestionList;
  const TeacherEntryLoadedEvent(this.loadedQuestionList);


  @override
  String toString() {
    return 'loadedQuestionList length = ${loadedQuestionList.length}\n$loadedQuestionList';
  }
}
