part of 'sudents_entery_bloc.dart';

@immutable
abstract class SudentsEnteryState {
  const SudentsEnteryState();
}

class SudentsEnteryInitialState extends SudentsEnteryState {}

class SudentsEnteryLoadedState extends SudentsEnteryState {
  final QuestionModel loadedQuestion;

  const SudentsEnteryLoadedState(this.loadedQuestion);
}

class OnErrorSudentsEnteryState extends SudentsEnteryState {}
