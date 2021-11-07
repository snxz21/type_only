part of 'teacher_entry_bloc.dart';

abstract class QuestionListRepository {
  Stream<List<QuestionModel>> getQuestionList();
}

class SingleFirebaseQuestionListRepository implements QuestionListRepository {

  @override
  Stream<List<QuestionModel>> getQuestionList() {
    return FirebaseFirestore.instance.collection('Tests').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => QuestionModel.fromFirestore(doc)).toList();
    });
  }
}
