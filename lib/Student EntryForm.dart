import 'dart:async';
import 'dart:math';
import 'package:toast/toast.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:editing_check/questionModel.dart';
import 'package:editing_check/studentTimeExpiredScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'UniqueIdScreen.dart';

class StudentEntryForm extends StatefulWidget {
  StudentEntryForm(this.myQuestion);

  final QuestionModel myQuestion;

  @override
  _StudentEntryFormState createState() {
    return _StudentEntryFormState();
  }
}

class _StudentEntryFormState extends State<StudentEntryForm> {
  TextEditingController uniqueAnswerController = TextEditingController();
  int _counter = 10; //nachalnaya ustanovka vremeni taimera
  int _minute; // peremennaya dlya pokaza minut
  int _second; // peremennaya plya pokaza sekund
  bool isEnable = true; //????
  int oldLen = 0; // nachalnaya  ustanowka schetchika proverki copy/paste
  int minLen = 16; //
  int maxLen = 500; // maximalnaya dlina tekstovogo wwoda
  String message = "";
  bool isShow = false;

  @override
  void initState() {
    super.initState();
    _counter = widget.myQuestion.time;
    minLen = widget.myQuestion.minLen;
    maxLen = widget.myQuestion.maxLen;

    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      // widget taimera
      setState(() {
        _counter--;
        _minute = _counter ~/ 60;
        _second = _counter - (_minute * 60);
        if (_minute == 0 && _second == 0) {
          timer.cancel();

          isEnable = false;
          endButton();
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => StudentTimeExpiredScreen()),
          // );

          //esli wremya zakonchilos to taimer ostanavlivaetsya
          // timer.cancel();
        }
      });
    });
    // Future.delayed(Duration(seconds: _counter), () {
    //   Navigator.pop(context);
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  var endBtn = FloatingActionButton.extended(onPressed: () {}, label: Text(""));

  endButton({isPaste}) {
    if (uniqueAnswerController.text.length > 10) {
      setState(() {
        isShow = true;
        if (message == "" && _counter == 0)
          message = 'Sorry your time is expired to answer this question';
        endBtn = FloatingActionButton.extended(
          //Knopka "Submit"
          backgroundColor: Colors.black,
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
          onPressed: () {
            setState(() {
              _minute = 0;
              _second = 0;
            });
            List<dynamic> tmpStudentsId = widget.myQuestion.listOfStudents;
            var tempId = "tmpStudentsId_${Random().nextInt(5000)}";
            tmpStudentsId.add(tempId);
            FirebaseFirestore.instance
                .collection("Tests")
                .doc(widget.myQuestion.docID)
                .update({
              "ListOfStudents": tmpStudentsId,
            });
            // /users/uid_1/answers/1aDHnkobaejfZ95Ysvz0
            FirebaseFirestore.instance
                .collection("users")
                .doc(tempId)
                .collection("answers")
                .doc(widget.myQuestion.docID)
                .set({
              "TimeCreated": DateTime.now().toString().substring(0, 16),
              "Answer": uniqueAnswerController.text,
            });

            Navigator.pop(context);
            Toast.show("You have submitted answer!", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            // Navigator.push(context, MaterialPageRoute(builder: (_) {
            //   return StudentEntryForm(widget.myQuestion);
            // }));
          },
          label: Text("Submit"),
        );
      });
    }
    if (_counter == 0) {
      setState(() {
        isShow = true;
        isEnable = false;
        if (message == "")
          message = 'Sorry your time is expired to answer this question';
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
        );
      });
    }
    if (isPaste != null) {
      print("yeap");
      setState(() {
        _counter = 1;
        message =
            'Sorry, you pasted text from buffer but it is not allowed! Please start typing your answer again!';
        isEnable = false;
        endBtn = FloatingActionButton.extended(
          //Knopka "Submit"
          backgroundColor: Colors.black,
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return StudentEntryForm(widget.myQuestion);
            }));
          },
          label: Text("Answer Again"),
        );
      });
    }
    // endBtn = FloatingActionButton.extended(onPressed: (){}, label: Text(""));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TypeOnly'),
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
                  Text('Question: ',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      )),
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
                child: Text(widget.myQuestion.question),
              ),
            ),
            Container(width: double.infinity, height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 1, 10, 5),
              child: Row(
                children: [
                  Text(
                      'Time left $_minute minutes : $_second seconds'), // soobshenie na ekrane schetchika vremeni
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 1, 20, 5),
              child: Container(
                width: double.infinity,
                height: 75,
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
                    hintStyle:
                        new TextStyle(color: Colors.black38, fontSize: 18),
                    hintText:
                        "Type your answer here. Important: Do not use copy/paste! ",
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
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Text(message),
              ),
            ),
            Row(
              children: [
                Container(width: 10, height: 10),
                Visibility(
                  visible:
                      isShow, //minimalnaya dlina stroki do pokaza knopki "Submit"
                  child: endBtn,
                ),
              ],
            )
          ],
        ));
  }
}
