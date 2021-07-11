class QuestionModel {
  String question;
  String answer;

  QuestionModel({
    this.question,
    this.answer,
  });

  factory QuestionModel.fromFirestore(doc) {
    return QuestionModel(
      question: doc["question from question class"],
      answer: doc["answer from answer class"],
    );
  }
}
