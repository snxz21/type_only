import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:editing_check/blocs/models/question_model.dart';

abstract class QuestionRepository {
  Stream<QuestionModel> getQuestion(String questionID);
}

class SingleFirebaseQuestionRepository implements QuestionRepository {
  @override
  Stream<QuestionModel> getQuestion(String questionID) {
    return FirebaseFirestore.instance
        .collection('Tests')
        .doc(questionID)
        .snapshots()
        .map((snap) => QuestionModel.fromFirestore(snap));
  }
}
