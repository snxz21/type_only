part of 'sudents_entery_bloc.dart';

@immutable
abstract class SudentsEnteryEvent {
  const SudentsEnteryEvent();
}

class SudentsEnteryLoadingEvent extends SudentsEnteryEvent {
  final String questionID;

  const SudentsEnteryLoadingEvent(this.questionID);
}

class SudentsEnteryLoadedEvent extends SudentsEnteryEvent {
  final QuestionModel loadedQuestion;

  const SudentsEnteryLoadedEvent(this.loadedQuestion);
}
