import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:editing_check/bloc_auth/UserBloc/user_bloc.dart';
import 'package:editing_check/blocs/models/question_model.dart';
import 'package:editing_check/blocs/models/user_answer_model.dart';
import 'package:meta/meta.dart';

part 'grade_event.dart';

part 'grade_state.dart';

part 'grade_repository.dart';

class GradeBloc extends Bloc<GradeEvent, GradeState> {
  GradeBloc() : super(GradeInitialState());
  StreamSubscription _questionSubscription;
  GradeRepository _gradeRepository = SingleFirebaseGradeRepository();

  @override
  Stream<GradeState> mapEventToState(GradeEvent event) async* {
    if (event is GradeLoadingEvent) {
      try {
        yield* _mapLoadTodosToState(event.questionID, event.student);
      } catch (error) {
        yield OnErrorGradeState();
      }
    } else if (event is GradeLoadedEvent) {
      yield* _mapTodosUpdateToState(event);
    } else if (event is GradeSendAnswerEvent) {
      // var tmpListStudents = event.loadedQuestion.listOfStudents;
      // tmpListStudents.add(userDataSave.uid);
      // FirebaseFirestore.instance.collection("Tests").doc(event.loadedQuestion.docID).update({
      //   "ListOfStudents": tmpListStudents,
      // });
      // FirebaseFirestore.instance
      //     .collection("users")
      //     .doc(userDataSave.uid)
      //     .collection("answers")
      //     .doc(event.loadedQuestion.docID)
      //     .set({
      //   "TimeCreated": DateTime.now().toString().substring(0, 16),
      //   "Answer": event.answer,
      // });

    }
  }

  var db = FirebaseFirestore.instance;

  Stream<GradeState> _mapLoadTodosToState(
      String questionID, List students) async* {
    Map<String, UserAnswerModel> userAnswers;
    students.forEach((student) async {
      await db
          .collection("users")
          .doc(student)
          .collection("answers")
          .doc(questionID)
          .get()
          .then((value) {
        print("value = ${value.data()}");
        userAnswers[student] = UserAnswerModel(
          answer: value.data()["Answer"] ?? "",
          timeCreated: value.data()["TimeCreated"] ?? "",
          // userID: student,
          // mark: value.data()["Mark"] ?? 0,
          // comment: value.data()["Comment"] ?? '',
          // statusList: value.data()['Status'] ?? [],
        );

      });
      print("len = ${userAnswers.keys.length}");
      add(GradeLoadedEvent(userAnswers));

    });


  }

  Stream<GradeState> _mapTodosUpdateToState(GradeLoadedEvent event) async* {

    yield GradeLoadedState(event.userAnswers);
  }
}
