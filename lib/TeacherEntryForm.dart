import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:editing_check/questionModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TeacherEntryForm extends StatefulWidget {
  @override
  _TeacherEntryFormState createState() => _TeacherEntryFormState();
}

class _TeacherEntryFormState extends State<TeacherEntryForm> {
  TextEditingController _questionController = TextEditingController();
  TextEditingController _minLenController = TextEditingController();
  TextEditingController _maxLenController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  QuestionModel myQestion = QuestionModel();
  List<QuestionModel> myQestionList = [];
  double formHeight = 0;

  int minLenAnswer = 0;
  var db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    getQuestionList();
  }

  getQuestionList() async {
    // /Tests/teacherId/TestList/test_1 []
    myQestionList.clear();
    await db.collection("Tests").get().then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        setState(() {
          myQestionList.add(QuestionModel(
            docID: value.docs[i].id,
            question: value.docs[i].data()["question"],
            time: value.docs[i].data()["time"],
            maxLen: value.docs[i].data()["maxLen"],
            minLen: value.docs[i].data()["minLen"],
          ));
        });
      }
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
          child: Column(
              //verticalDirection: VerticalDirection.down,
              children: [
            Container(width: double.infinity, height: 20),
            Container(
              width: 120,
              height: 40,
              child: FloatingActionButton.extended(
                  heroTag: "create new Question",
                  backgroundColor: Colors.black,
                  shape:
                      BeveledRectangleBorder(borderRadius: BorderRadius.zero),
                  onPressed: () {
                    setState(() {
                      formHeight = 360;
                    });
                  },
                  label: Text('New Question')),
            ),
            Container(width: double.infinity, height: 20),
            AnimatedContainer(
                height: formHeight,
                duration: Duration(milliseconds: 100),
                child: Card(
                    elevation: 7,
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(1.0),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          Container(
                            width: double.infinity,
                            height: 100,
                            child: TextFormField(
                              controller: _questionController,
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
                                hintStyle: new TextStyle(
                                    color: Colors.grey[800], fontSize: 18),
                                hintText: "Type your question here ",
                                fillColor: Colors.white24,
                              ),
                              maxLines: 3,
                            ),
                          ),
                          Container(width: double.infinity, height: 20),
                          Row(
                            children: [
                              Text("Minimal length of answer (char): "),
                              Container(
                                child: ConstrainedBox(
                                  constraints:
                                      BoxConstraints.tight(const Size(60, 30)),
                                  child: TextFormField(
                                    controller: _minLenController,
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
                                      hintStyle: new TextStyle(
                                          color: Colors.grey[800], fontSize: 8),
                                      hintText: "",
                                      fillColor: Colors.white24,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                              ),

                              //TextFormField()
                            ],
                          ),
                          Container(width: double.infinity, height: 20),
                          Row(
                            children: [
                              Text("Maximal length of answer (char): "),
                              Container(
                                child: ConstrainedBox(
                                  constraints:
                                      BoxConstraints.tight(const Size(60, 30)),
                                  child: TextFormField(
                                    controller: _maxLenController,
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
                                      hintStyle: new TextStyle(
                                          color: Colors.grey[800], fontSize: 8),
                                      hintText: "",
                                      fillColor: Colors.white24,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                              ),

                              //TextFormField()
                            ],
                          ),
                          Container(width: double.infinity, height: 20),
                          Row(
                            children: [
                              Text("Maximal time  of answer (min):  "),
                              Container(
                                child: ConstrainedBox(
                                  constraints:
                                      BoxConstraints.tight(const Size(60, 30)),
                                  child: TextFormField(
                                    controller: _timeController,
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
                                      hintStyle: new TextStyle(
                                          color: Colors.grey[800], fontSize: 8),
                                      hintText: "",
                                      fillColor: Colors.white24,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                              ),

                              //TextFormField()
                            ],
                          ),
                          Container(width: double.infinity, height: 20),
                          Row(
                            children: [
                              Container(
                                width: 100,
                                height: 40,
                                child: FloatingActionButton.extended(
                                    backgroundColor: Colors.black,
                                    shape: BeveledRectangleBorder(
                                        borderRadius: BorderRadius.zero),
                                    onPressed: () async {
                                      formHeight = 0;
                                      await db.collection("Tests").doc().set({
                                        "question": _questionController.text,
                                        "minLen":
                                            int.parse(_minLenController.text),
                                        "maxLen":
                                            int.parse(_maxLenController.text),
                                        "time": int.parse(_timeController.text),
                                      });
                                      getQuestionList();
                                    },
                                    label: Text('Save')),
                              ),
                            ],
                          ),
                        ])))),
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: 500,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: myQestionList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text("Test uniq ID: " +
                                      myQestionList[index].docID),
                                  SizedBox(
                                    width: 50.0,
                                  ),
                                  Container(
                                    width: 80,
                                    height: 30,
                                    child: FloatingActionButton.extended(
                                      backgroundColor: Colors.black,
                                      shape: BeveledRectangleBorder(
                                          borderRadius: BorderRadius.zero),
                                      onPressed: () async {},
                                      label: Text(
                                        'Copy Link',
                                        textScaleFactor: 0.8,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
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
                                  child: Text("Text of Question: " +
                                      myQestionList[index].question),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  Text("Time: " +
                                      myQestionList[index].time.toString()),
                                  Text("MinLen: " +
                                      myQestionList[index].minLen.toString()),
                                  Text("MaxLen: " +
                                      myQestionList[index].maxLen.toString()),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Spacer(),
                                  Container(
                                    width: 80,
                                    height: 30,
                                    child: FloatingActionButton.extended(
                                      backgroundColor: Colors.black,
                                      shape: BeveledRectangleBorder(
                                          borderRadius: BorderRadius.zero),
                                      onPressed: () async {},
                                      label: Text('Delete Question',
                                          textScaleFactor: 0.6),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Container(
                                    width: 80,
                                    height: 30,
                                    child: FloatingActionButton.extended(
                                      backgroundColor: Colors.black,
                                      shape: BeveledRectangleBorder(
                                          borderRadius: BorderRadius.zero),
                                      onPressed: () async {},
                                      label: Text(
                                        'Grade Answers',
                                        textScaleFactor: 0.6,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ])),
    );
    //         Padding(
    //           padding: const EdgeInsets.fromLTRB(15.0, 0, 15, 0),
    //           child: Container(
    //             width: MediaQuery.of(context).size.width,
    //             height: 40,
    //             decoration: BoxDecoration(
    //               border: Border.all(
    //                 color: Colors.black,
    //               ),
    //               borderRadius: BorderRadius.circular(1.0),
    //             ),
    //             child: Padding(
    //               padding: const EdgeInsets.all(2.0),
    //               child: Text("What is Apoptosis? "),
    //             ),
    //           ),
    //         ),
    //       ]),
    // ));
  }
}
