import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:editing_check/blocs/models/question_model.dart';
import 'package:editing_check/blocs/sudents_entery_bloc/question_repository.dart';
import 'package:editing_check/main.dart';
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
    } else if (event is SudentsEnterySendAnswerEvent) {
      var tmpListStudents = event.loadedQuestion.listOfStudents;
      tmpListStudents.add(userDataSave.uid);
      FirebaseFirestore.instance.collection("Tests").doc(event.loadedQuestion.docID).update({
        "ListOfStudents": tmpListStudents,
      });
      FirebaseFirestore.instance
          .collection("users")
          .doc(userDataSave.uid)
          .collection("answers")
          .doc(event.loadedQuestion.docID)
          .set({
        "TimeCreated": DateTime.now().toString().substring(0, 16),
        "Answer": event.answer,
      });
      var db = FirebaseFirestore.instance;
      try{
        await db.collection('mail').doc().set({
          'to':[userDataSave.email],
          'message': {
            'subject': 'You have submitted the answer!',
            'text': "You have submitted the answer on the question: " + event.answer + "\nThis is an automated message, please do not reply ",
            // 'html': 'This is the <code>HTML</code> section of the email body.',
          }
        });
      }
      catch(e){
        print(e);
      }

    }
    else if(event is SudentsEnteryDropStateEvent){
      yield SudentsEnteryInitialState();
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
