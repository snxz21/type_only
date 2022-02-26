import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:editing_check/blocs/models/question_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/grade_bloc/grade_bloc.dart';
import 'blocs/models/user_answer_model.dart';

class GradingScreen extends StatefulWidget {
  GradingScreen(this.question);

  final QuestionModel question;

  @override
  _GradingScreenState createState() => _GradingScreenState();
}

class _GradingScreenState extends State<GradingScreen> {
  // var db = FirebaseFirestore.instance;
  // List<UserAnswerModel> usersAnswers = [];

  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration(seconds: 2), () {
    //   print(widget.question.listOfStudents);
    //   print(widget.question.docID);
    //   getAllUsersAnswer(widget.question.listOfStudents, widget.question.docID);
    // });
  }

  ///users/uid_1/answers/OiosQ1cij9kPSpvxR9g1
  // getAllUsersAnswer(List users, String questionId) async {
  //   users.forEach((element) async {
  //     await db
  //         .collection("users")
  //         .doc(element)
  //         .collection("answers")
  //         .doc(questionId)
  //         .get()
  //         .then((value) {
  //       setState(() {
  //         usersAnswers.add(
  //           UserAnswerModel(
  //             answer: value.data()["Answer"],
  //             timeCreated: value.data()["TimeCreated"],
  //             userID: element,
  //             mark: value.data()["Mark"] ?? 0,
  //             comment: value.data()["Comment"] ?? '',
  //             statusList: value.data()['Status'] ?? [],
  //           ),
  //         );
  //       });
  //     });
  //   });
  //   setState(() {
  //     usersAnswers = usersAnswers.reversed.toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GradeBloc, GradeState>(builder: (context, state) {
      if (state is GradeInitialState) {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state is GradeLoadedState) {
        return Scaffold(
          appBar: AppBar(
            title: Text('TypeOnly'),
            centerTitle: true,
          ),
          body: Column(children: [
            SizedBox(
              height: 50.0,
            ),
            Center(child: Text('Students responses to Question  ID #: ${widget.question.docID}')),
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
            Expanded(
              // height: 500,
              // width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: state.userAnswers.keys.length,
                  itemBuilder: (context, index) {
                    TextEditingController teacherUniqueController = TextEditingController();

                    if (teacherUniqueController.text == "") {
                      teacherUniqueController.text = state.userAnswers.values.elementAt(index).comment;
                    }
                    // return Container(child: Text(state.userAnswers.values.elementAt(index).answer),);
                    return Card(
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
                                'Answer from student: ${state.userAnswers.keys.elementAt(index).firstName}'
                                    ' ${state.userAnswers.keys.elementAt(index).lastName}\n'
                                'email: ${state.userAnswers.keys.elementAt(index).email}\n'
                                'submitted:${state.userAnswers.values.elementAt(index).timeCreated}'),
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
                                child: Text("${state.userAnswers.values.elementAt(index).answer}"),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                Text("Teacher's Feedback"),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Column(
                                  children: [
                                    Text('1'),
                                    Radio(
                                      value: 1,
                                      groupValue: state.userAnswers.values.elementAt(index).mark,
                                      onChanged: (value) {
                                        setState(() {
                                          state.userAnswers.values.elementAt(index).mark = value;
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
                                      groupValue: state.userAnswers.values.elementAt(index).mark,
                                      onChanged: (value) {
                                        setState(() {
                                          state.userAnswers.values.elementAt(index).mark = value;
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
                                      groupValue: state.userAnswers.values.elementAt(index).mark,
                                      onChanged: (value) {
                                        setState(() {
                                          state.userAnswers.values.elementAt(index).mark = value;
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
                                      groupValue: state.userAnswers.values.elementAt(index).mark,
                                      onChanged: (value) {
                                        setState(() {
                                          state.userAnswers.values.elementAt(index).mark = value;
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
                                      groupValue: state.userAnswers.values.elementAt(index).mark,
                                      onChanged: (value) {
                                        setState(() {
                                          state.userAnswers.values.elementAt(index).mark = value;
                                        });
                                      },
                                      activeColor: Colors.green,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              // height: 40,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Teacher Comments'),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 1, 20, 5),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.9,
                                      // height: 200,
                                      child: TextFormField(
                                          //Pole formy wwoda otveta studentom
                                          minLines: 3,
                                          // any number you need (It works as the rows for the textarea)
                                          keyboardType: TextInputType.multiline,
                                          maxLines: null,
                                          decoration: new InputDecoration(
                                            border: new OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.black,
                                              ),
                                              borderRadius: const BorderRadius.all(
                                                const Radius.circular(1.0),
                                              ),
                                            ),
                                            filled: true,
                                            hintStyle: new TextStyle(color: Colors.black38, fontSize: 18),
                                            hintText: "Some text",
                                            fillColor: Colors.white,
                                          ),
                                          controller: teacherUniqueController,
                                          onChanged: (value) {}),
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
                                    shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
                                    onPressed: () {
                                      state.userAnswers.values.elementAt(index).statusList.add("verifyed");
                                      BlocProvider.of<GradeBloc>(context).add(GradeSendAnswerEvent(
                                        mark: state.userAnswers.values.elementAt(index).mark,
                                        teachersComment: teacherUniqueController.text,
                                        sudentsID: state.userAnswers.keys.elementAt(index).uid,
                                        quesionID: widget.question.docID,
                                        statusList: state.userAnswers.values.elementAt(index).statusList,
                                        studentList: state.userAnswers.keys.toList(),
                                      ));
                                      final snackBar = SnackBar(
                                        content: const Text('Feedback is submitted'),
                                        action: SnackBarAction(
                                          label: 'Undo',
                                          onPressed: () {
                                            // Some code to undo the change.
                                          },
                                        ),
                                      );

                                      // Find the ScaffoldMessenger in the widget tree
                                      // and use it to show a SnackBar.
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                      // await db
                                      //     .collection("users")
                                      //     .doc(usersAnswers[index].userID)
                                      //     .collection("answers")
                                      //     .doc();
                                      //.update();
                                    },
                                    label: Text(
                                      'Submit Feedback',
                                      textScaleFactor: 0.55,
                                    ),
                                    heroTag: "ascv213safadfbsfh",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ]),
        );
      }
      return Container();
    });
  }
}
