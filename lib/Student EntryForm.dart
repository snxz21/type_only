import 'dart:async';
import 'dart:math';
import 'package:editing_check/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:editing_check/blocs/models/question_model.dart';
import 'package:editing_check/studentTimeExpiredScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'UniqueIdScreen.dart';
import 'blocs/sudents_entery_bloc/sudents_entery_bloc.dart';

class StudentEntryForm extends StatefulWidget {
  StudentEntryForm();

  // QuestionModel myQuestion;

  @override
  _StudentEntryFormState createState() {
    return _StudentEntryFormState();
  }
}

class _StudentEntryFormState extends State<StudentEntryForm> {
  TextEditingController uniqueAnswerController = TextEditingController();
  int _counter = 10; //nachalnaya ustanovka vremeni taimera
  int _minute = 0; // peremennaya dlya pokaza minut
  int _second = 0; // peremennaya plya pokaza sekund
  bool isEnable = true; //????
  int oldLen = 0; // nachalnaya  ustanowka schetchika proverki copy/paste
  int minLen = 16; //
  int maxLen = 500; // maximalnaya dlina tekstovogo wwoda
  String message = "";
  bool isShow = false;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    // raOQTmgIXkXDYbRDXDGK
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  dynamic endBtn = Container() /*= FloatingActionButton.extended(onPressed: () {}, label: Text(""))*/;

  void checkMinLenAnswer(SudentsEnteryLoadedState state) {
    if (uniqueAnswerController.text.length > state.loadedQuestion.minLen) {
      setState(() {
        isShow = true;
        if (message == "" && _counter == 0) message = 'Sorry your time is expired to answer this question1';
        endBtn = OutlinedButton(
          //Knopka "Submit"
          child: Text(
            "Submit",
            style: TextStyle(color: Colors.white),
          ),
          style: TextButton.styleFrom(backgroundColor: Colors.black),
          onPressed: () {
            setState(() {
              _minute = 0;
              _second = 0;
            });
            // List<dynamic> tmpStudentsId = state.loadedQuestion.listOfStudents;
            // tmpStudentsId.add(userDataSave.uid);
            // FirebaseFirestore.instance.collection("Tests").doc(state.loadedQuestion.docID).update({
            //   "ListOfStudents": tmpStudentsId,
            // });
            // // /users/uid_1/answers/1aDHnkobaejfZ95Ysvz0
            // FirebaseFirestore.instance
            //     .collection("users")
            //     .doc(tempId)
            //     .collection("answers")
            //     .doc(state.loadedQuestion.docID)
            //     .set({
            //   "TimeCreated": DateTime.now().toString().substring(0, 16),
            //   "Answer": uniqueAnswerController.text,
            // });
            BlocProvider.of<SudentsEnteryBloc>(context).add(SudentsEnterySendAnswerEvent(
              loadedQuestion: state.loadedQuestion,
              timeCreated: DateTime.now().toString().substring(0, 16),
              answer: uniqueAnswerController.text,
            ));
            Navigator.pop(context);
            Toast.show("You have submitted answer!", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            // Navigator.push(context, MaterialPageRoute(builder: (_) {
            //   return StudentEntryForm(widget.myQuestion);
            // }));
          },
        );
      });
    }
  }

  endButton({isPaste}) {
    if (_counter == 0) {
      setState(() {
        isShow = true;
        isEnable = false;
        if (message == "") message = 'Sorry your time is expired to answer this question';
        endBtn = FloatingActionButton.extended(
          //Knopka "Submit"
          backgroundColor: Colors.black,
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
          onPressed: () {
            Navigator.pop(context);
            // Navigator.push(context, MaterialPageRoute(builder: (_) {
            //   return StudentEntryForm();
            // }));
          },
          label: Text("Answer Again"),
          heroTag: "Answer Again stud form",
        );
      });
    }
    if (isPaste != null) {
      print("yeap");
      setState(() {
        _counter = 1;
        message = 'Sorry, you pasted text from buffer but it is not allowed! Please start typing your answer again!';
        isEnable = false;
        endBtn = FloatingActionButton.extended(
          //Knopka "Submit"
          backgroundColor: Colors.black,
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
          onPressed: () {
            // Navigator.push(context, MaterialPageRoute(builder: (_) {
            //   return StudentEntryForm(widget.myQuestion);
            // }));
          },
          label: Text("Answer Again"),
          heroTag: "Answer Again stud form2",
        );
      });
    }
    // endBtn = FloatingActionButton.extended(onPressed: (){}, label: Text(""));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SudentsEnteryBloc, SudentsEnteryState>(
      builder: (context, state) {
        if (state is SudentsEnteryInitialState) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is SudentsEnteryLoadedState) {
          if (_timer == null) {
            Future.delayed(Duration.zero, () {

              setState(() {
                _counter = state.loadedQuestion.time;
                minLen = state.loadedQuestion.minLen;
                maxLen = state.loadedQuestion.maxLen;
              });
              setState(() {
                _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
                  // widget taimera
                  setState(() {
                    _counter--;
                    _minute = _counter ~/ 60;
                    _second = _counter - (_minute * 60);
                    if (_minute <= 0 && _second <= 0) {
                      _timer.cancel();
                      isEnable = false;
                      endButton();
                    }
                  });
                });
              });
            });
          }
          return Scaffold(
              appBar: AppBar(
                title: Text('TypeOnly'),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    BlocProvider.of<SudentsEnteryBloc>(context).add(
                      SudentsEnteryDropStateEvent(),
                    );

                  },
                  icon: Icon(Icons.arrow_back),
                ),
                centerTitle: true,
              ),
              body: Column(
                verticalDirection: VerticalDirection.down,
                children: [
                  Container(width: double.infinity, height: 100),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'Question: ',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 1, 10, 5),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(1.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(state.loadedQuestion.question),
                    ),
                  ),
                  Container(width: double.infinity, height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 1, 10, 5),
                    child: Row(
                      children: [
                        Text('Time left $_minute minutes : $_second seconds',
                        style: TextStyle(color: Colors.red)),
                        Visibility(visible: state.loadedQuestion.minLen >= uniqueAnswerController.text.length,
                          child: Text('Symbols  left ${state.loadedQuestion.minLen-uniqueAnswerController.text.length}',
                              style: TextStyle(color: Colors.red)),
                        ),
                        // soobshenie na ekrane schetchika vremeni
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 1, 20, 5),
                    child: Container(
                      width: double.infinity,
                      //height: 75,
                      child: TextFormField(
                        //Pole formy wwoda otveta studentom
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
                          hintStyle: new TextStyle(color: Colors.black, fontSize: 16),
                          hintText: "Type your answer here. DO NOT USE COPY/PASTE or your answer will not be submitted! Keep attention to the timer and do not exceed the allotted time! Note: If you exceed the time -  you will have to retype your entire answer again!"
                              " Important: make a screenshot of your work after you finished typing and save it to your device! Good luck!",
                          fillColor: Colors.white,
                        ),
                        enabled: isEnable,
                        controller: uniqueAnswerController,
                        maxLength: maxLen,
                        minLines: 1,
                        maxLines: 15,
                        onChanged: (value) {
                          print(value);

                          endButton();
                          checkMinLenAnswer(state);
                          if (value.length - oldLen > 1) {
                            endButton(isPaste: true);
                            print('do not paste');
                          } else {
                            setState(() {
                              oldLen = value.length;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isShow,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(10, 1, 5, 5),
                      padding: const EdgeInsets.fromLTRB(10, 1, 5, 5),
                      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                      child: Text(message),
                    ),
                  ),
                  Row(
                    children: [
                      Container(width: 10, height: 10),
                      Visibility(
                        visible: isShow, //minimalnaya dlina stroki do pokaza knopki "Submit"
                        child: endBtn,
                      ),
                    ],
                  )
                ],
              ));
        } else if (state is OnErrorSudentsEnteryState) {
          return Scaffold(
            body: Center(
              child: Text("Error load question, try again."),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Text("Error load question, try again."),
            ),
          );
        }
      },
    );
  }
}
