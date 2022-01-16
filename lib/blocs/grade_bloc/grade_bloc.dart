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
      // FirebaseFirestore.instance.collection("Tests").doc(event.loadedQuestion.docID).update({
      //   "ListOfStudents": tmpListStudents,
      // });
      print("studentList ${event.studentList}");
      print("studentList.runtimeType ${event.studentList.runtimeType}");

      FirebaseFirestore.instance
          .collection("users")
          .doc(event.sudentsID)
          .collection("answers")
          .doc(event.quesionID)
          .update({
        "Mark": event.mark,
        "Comment": event.teachersComment,
        "Status": event.statusList,
      });
      //
      // yield GradeInitialState();
      // Future.delayed(Duration(milliseconds: 200), () {
      //   add(GradeLoadingEvent(questionID: event.sudentsID, student: event.studentList));
      // });

    }
  }

  var db = FirebaseFirestore.instance;

  Stream<GradeState> _mapLoadTodosToState(String questionID, List students) async* {
    Map<UserModel, UserAnswerModel> userAnswers = {};
    students.forEach((student) async {
      await db.collection("users").doc(student).collection("answers").doc(questionID).get().then((value) {
        print("value = ${value.data()}");
        print("value = ${value.data()["Answer"]}");
        print("value = ${value.data()["TimeCreated"]}");
        UserModel userData;
        db.collection('users').doc(student).get().then((value1) {
          userData = UserModel.fromFirestore(value1);

          print("userData = $userData");
          // .map((snap) => UserModel.fromFirestore(snap));
          userAnswers[userData] = UserAnswerModel(
            answer: value.data()["Answer"] ?? "",
            timeCreated: value.data()["TimeCreated"] ?? "",
            userID: student,
            mark: value.data()["Mark"] ?? 0,
            comment: value.data()["Comment"] ?? '',
            statusList: value.data()['Status'] ?? [],
          );
        });
      });
      // print("len = ${userAnswers.keys.length}");
    });

    Future.delayed(Duration(milliseconds: 2000), () {
      add(GradeLoadedEvent(userAnswers));
    });
  }

  Stream<GradeState> _mapTodosUpdateToState(GradeLoadedEvent event) async* {
    print(event.userAnswers.length);
    yield GradeLoadedState(event.userAnswers);
  }
}
