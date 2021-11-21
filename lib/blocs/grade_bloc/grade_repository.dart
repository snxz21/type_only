part of 'grade_bloc.dart';

abstract class GradeRepository {
  Stream getGrade(questionID, List students);
}

class SingleFirebaseGradeRepository implements GradeRepository {


  @override
  Stream getGrade(questionID, List students) {
    Map<String, UserAnswerModel> userAnswer;
    return FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .map((snapshot) {
      snapshot.docs.forEach((element) {
        students.forEach((student) async {
          if (element.id == student) {
            userAnswer[element.id] = await element.reference
                .collection("answers")
                .doc(questionID)
                .get()
                .then((value) => UserAnswerModel.fromFirestore(value));
          }
        });

        // userAnswer.add(element);
      });
      return userAnswer;
    });
  }
}
