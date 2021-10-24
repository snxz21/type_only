import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:editing_check/blocs/models/question_model.dart';
import 'package:editing_check/blocs/sudents_entery_bloc/question_repository.dart';
import 'package:meta/meta.dart';

part 'sudents_entery_event.dart';

part 'sudents_entery_state.dart';

class SudentsEnteryBloc extends Bloc<SudentsEnteryEvent, SudentsEnteryState> {
  SudentsEnteryBloc() : super(SudentsEnteryInitialState());

  QuestionRepository _questionRepository = SingleFirebaseQuestionRepository();
  StreamSubscription _questionSubscription;

  @override
  Stream<SudentsEnteryState> mapEventToState(SudentsEnteryEvent event) async* {
    if (event is SudentsEnteryLoadingEvent) {
      try {
        yield* _mapLoadTodosToState(event.questionID);
      } catch (error) {
        yield OnErrorSudentsEnteryState();
      }
    } else if (event is SudentsEnteryLoadedEvent) {
      yield* _mapTodosUpdateToState(event);
    }
  }

  Stream<SudentsEnteryState> _mapLoadTodosToState(String questionID) async* {
    _questionSubscription?.cancel();
    _questionSubscription = _questionRepository.getQuestion(questionID).listen((data) {
      print(data);
      add(SudentsEnteryLoadedEvent(data));
    });
  }

  Stream<SudentsEnteryState> _mapTodosUpdateToState(SudentsEnteryLoadedEvent event) async* {
    yield SudentsEnteryLoadedState(event.loadedQuestion);
  }
}
