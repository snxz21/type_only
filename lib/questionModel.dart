class QuestionModel {
  final String docID;
  final String question;
  final int maxLen;
  final int minLen;
  final int time;

  QuestionModel({
    this.docID,
    this.question = "",
    this.maxLen = 0,
    this.minLen = 0,
    this.time = 0,
  });
  //
  // factory QuestionModel.fromFirestore(doc) {
  //   return QuestionModel(
  //     question: doc["question from question class"],
  //     answer: doc["answer from answer class"],
  //   );
  // }
}
