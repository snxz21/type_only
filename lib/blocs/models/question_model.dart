import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionModel {
  final String docID;
  final String question;
  final String teacherUID;
  final List<dynamic> listOfStudents;
  final int maxLen;
  final int minLen;
  final int time;
  final int timeCreated;

  QuestionModel({
    this.docID,
    this.question = "",
    this.teacherUID = "",
    this.maxLen = 0,
    this.minLen = 0,
    this.time = 0,
    this.listOfStudents,
    this.timeCreated,
  });

  factory QuestionModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();

    return QuestionModel(
      docID: doc.id??"",
      question: data["question"]??"",
      teacherUID: data["teacherUID"] ?? "",
      time: data["time"] ??10,
      maxLen: data["maxLen"] ?? 10,
      minLen: data["minLen"]?? 10,
      listOfStudents: data["ListOfStudents"] ?? [],
      timeCreated: data['TimeCreated'] ?? 1,

    );
  }

  @override
  String toString() {
    return '$question\n$time';
  }
}
