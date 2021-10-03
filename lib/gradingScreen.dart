import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:editing_check/questionModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GradingScreen extends StatefulWidget {
  GradingScreen(this.question);

  final QuestionModel question;

  @override
  _GradingScreenState createState() => _GradingScreenState();
}

class _GradingScreenState extends State<GradingScreen> {
  bool _value = false;
  // int val = -1;
  var db = FirebaseFirestore.instance;
  List<UserAnswerModel> usersAnswers = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      print(widget.question.listOfStudents);
      print(widget.question.docID);
      getAllUsersAnswer(widget.question.listOfStudents, widget.question.docID);
    });
  }

  ///users/uid_1/answers/OiosQ1cij9kPSpvxR9g1
  getAllUsersAnswer(List users, String questionId) async {
    users.forEach((element) async {
      await db
          .collection("users")
          .doc(element)
          .collection("answers")
          .doc(questionId)
          .get()
          .then((value) {
        setState(() {
          usersAnswers.add(
            UserAnswerModel(
              answer: value.data()["Answer"],
              timeCreated: value.data()["TimeCreated"],
              userID: element,
              mark: value.data()["Mark"] ?? 0,
              comment: value.data()["Comment"] ?? '',
              statusList: value.data()['Status'] ?? [],
            ),
          );
        });
      });
    });
    setState(() {
      usersAnswers = usersAnswers.reversed.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TypeOnly'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(children: [
          SizedBox(
            height: 50.0,
          ),
          Center(
              child: Text(
                  'Students responses to Question  ID #: ${widget.question.docID}')),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 40,
            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(1.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(widget.question.question),
            ),
          ),
          Flexible(
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: usersAnswers.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Card(
                      color: Colors.grey[300],
                      elevation: 8.0,
                      margin: EdgeInsets.all(20),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                                'Answer from student: ${usersAnswers[index].userID}; email: jsmith@gmail.com; submitted:${usersAnswers[index].timeCreated}'),
                            SizedBox(
                              width: 50.0,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(1.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text("${usersAnswers[index].answer}"),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(children: [
                              Text("Teacher's Feedback"),
                              SizedBox(
                                width: 20.0,
                              ),
                              Column(
                                children: [
                                  Text('1'),
                                  Radio(
                                    value: 1,
                                    groupValue: usersAnswers[index].mark,
                                    onChanged: (value) {
                                      setState(() {
                                        usersAnswers[index].mark = value;
                                      });
                                    },
                                    activeColor: Colors.green,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text('2'),
                                  Radio(
                                    value: 2,
                                    groupValue: usersAnswers[index].mark,
                                    onChanged: (value) {
                                      setState(() {
                                        usersAnswers[index].mark = value;
                                      });
                                    },
                                    activeColor: Colors.green,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text('3'),
                                  Radio(
                                    value: 3,
                                    groupValue: usersAnswers[index].mark,
                                    onChanged: (value) {
                                      setState(() {
                                        usersAnswers[index].mark = value;
                                      });
                                    },
                                    activeColor: Colors.green,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text('4'),
                                  Radio(
                                    value: 4,
                                    groupValue: usersAnswers[index].mark,
                                    onChanged: (value) {
                                      setState(() {
                                        usersAnswers[index].mark = value;
                                      });
                                    },
                                    activeColor: Colors.green,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text('5'),
                                  Radio(
                                    value: 5,
                                    groupValue: usersAnswers[index].mark,
                                    onChanged: (value) {
                                      setState(() {
                                        usersAnswers[index].mark = value;
                                      });
                                    },
                                    activeColor: Colors.green,
                                  ),
                                ],
                              ),
                            ]),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                      flex: 20,
                                      child: Text('Teacher Comments')),
                                  Expanded(
                                    flex: 80,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(1.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text("Teachers Comments here "),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: 80,
                                  height: 30,
                                  child: FloatingActionButton.extended(
                                    backgroundColor: Colors.black,
                                    shape: BeveledRectangleBorder(
                                        borderRadius: BorderRadius.zero),
                                    onPressed: () async {
                                      await db
                                          .collection("users")
                                          .doc(usersAnswers[index].userID)
                                          .collection("answers")
                                          .doc();
                                      //.update();
                                    },
                                    label: Text(
                                      'Submit Feedback',
                                      textScaleFactor: 0.55,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          )
        ]),
      ),
    );
  }
}
