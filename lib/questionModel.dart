class QuestionModel {
  String question;
  String answer;

  QuestionModel({
    this.question,
    this.answer,
  });

  factory QuestionModel.fromFirestore(doc) {
    return QuestionModel(
      question: doc["question"],
      answer: doc["answer"],
    );
  }
}
