part of 'sudents_entery_bloc.dart';

@immutable
abstract class SudentsEnteryEvent {
  const SudentsEnteryEvent();
}

class SudentsEnteryDropStateEvent extends SudentsEnteryEvent {
  const SudentsEnteryDropStateEvent();
}

class SudentsEnteryLoadingEvent extends SudentsEnteryEvent {
  final String questionID;

  const SudentsEnteryLoadingEvent(this.questionID);
}

class SudentsEnteryLoadedEvent extends SudentsEnteryEvent {
  final QuestionModel loadedQuestion;

  const SudentsEnteryLoadedEvent(this.loadedQuestion);
}

class SudentsEnterySendAnswerEvent extends SudentsEnteryEvent {
  final QuestionModel loadedQuestion;
  final String timeCreated;
  final String answer;

  const SudentsEnterySendAnswerEvent({this.loadedQuestion, this.timeCreated, this.answer});
}
