import 'dart:async';

import 'package:editing_check/studentTimeExpiredScreen.dart';
import 'package:flutter/material.dart';
import 'UniqueIdScreen.dart';

class StudentEntryForm extends StatefulWidget {
  StudentEntryForm({Key key}) : super(key: key);

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
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      // widget taimera
      setState(() {
        _counter--;
        _minute = _counter ~/ 60;
        _second = _counter - (_minute * 60);
        if (_minute == 0 && _second == 0) {
          timer.cancel();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StudentTimeExpiredScreen()),
          );

          //esli wremya zakonchilos to taimer ostanavlivaetsya
          // timer.cancel();
        }
      });
    });
    Future.delayed(Duration(seconds: _counter), () {
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    super.dispose();
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
                child: Center(
                  child: Text(
                      'What is Apoptosis sdfhgsdfgsdfgsdfgsdfgsdfgds ?'), //text voprosa po sootvetstvuyushemu ID
                ),
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
              child: Flexible(
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
                    hintStyle: new TextStyle(color: Colors.black, fontSize: 18),
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
                    if (value.length - oldLen > 1) {
                      setState(() {
                        isEnable = false;
                      });
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
              visible: !isEnable,
              child: Container(
                margin: const EdgeInsets.fromLTRB(10, 1, 5, 5),
                padding: const EdgeInsets.fromLTRB(10, 1, 5, 5),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Text(
                    'Sorry, you pasted text from buffer but it is not allowed! Please start typing your answer again!'),
              ),
            ),
            Row(
              children: [
                Container(width: 10, height: 10),
                Visibility(
                  visible: uniqueAnswerController.text.length >
                      10, //minimalnaya dlina stroki do pokaza knopki "Submit"
                  child: FloatingActionButton.extended(
                    //Knopka "Submit"
                    backgroundColor: Colors.black,
                    shape:
                        BeveledRectangleBorder(borderRadius: BorderRadius.zero),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return StudentEntryForm();
                      }));
                    },
                    label: Text("Submit"),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}

class StudentTimeExpiredScreen extends StatelessWidget {
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
          Text('Sorry your time is expired to answer this question',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
            child: FloatingActionButton.extended(
              backgroundColor: Colors.black,
              shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
              onPressed: () {
                // ignore: missing_return
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return UniqueIdScreen();
                }));
              },
              label: Text("Answer Again"),
            ),
          ),
        ],
      ),
    );
  }
}
