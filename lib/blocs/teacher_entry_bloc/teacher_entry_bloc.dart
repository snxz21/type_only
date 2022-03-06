import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:editing_check/blocs/models/question_model.dart';
import 'package:meta/meta.dart';

import '../../main.dart';

part 'teacher_entry_event.dart';

part 'teacher_entry_state.dart';

part 'question_list_repository.dart';

class TeacherEntryBloc extends Bloc<TeacherEntryEvent, TeacherEntryState> {
  TeacherEntryBloc() : super(TeacherEntryInitialState());
  QuestionListRepository _questionRepository = SingleFirebaseQuestionListRepository();
  StreamSubscription _questionListSubscription;

  @override
  Stream<TeacherEntryState> mapEventToState(TeacherEntryEvent event) async* {
    if (event is TeacherEntryLoadingEvent) {
      try {
        yield* _mapLoadTodosToState();
      } catch (error) {
        yield OnErrorTeacherEntryState();
      }
    } else if (event is TeacherEntryLoadedEvent) {
      yield* _mapTodosUpdateToState(event);
    }
  }

  Stream<TeacherEntryState> _mapLoadTodosToState() async* {
    _questionListSubscription?.cancel();
    _questionListSubscription = _questionRepository.getQuestionList().listen((data) {
      List<QuestionModel> tmp = [];
      data.forEach((element) {
        if (element.teacherUID == userDataSave.uid) {
          tmp.add(element);
        }
      });
      add(TeacherEntryLoadedEvent(tmp));
    });
  }

  Stream<TeacherEntryState> _mapTodosUpdateToState(TeacherEntryLoadedEvent event) async* {
    event.loadedQuestionList.forEach((element) {
      print("element = $element");
    });
    yield TeacherEntryLoadedState(event.loadedQuestionList);
  }
}
