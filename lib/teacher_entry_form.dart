import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:editing_check/blocs/grade_bloc/grade_bloc.dart';
import 'package:editing_check/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/teacher_entry_bloc/teacher_entry_bloc.dart';
import 'gradingScreen.dart';

class TeacherEntryForm extends StatefulWidget {
  @override
  _TeacherEntryFormState createState() => _TeacherEntryFormState();
}

class _TeacherEntryFormState extends State<TeacherEntryForm> {
  TextEditingController _questionController = TextEditingController();
  TextEditingController _minLenController = TextEditingController();
  TextEditingController _maxLenController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  // QuestionModel myQestion = QuestionModel();
  // List<QuestionModel> state.loadedQuestionList = [];
  double formHeight = 0;

  int minLenAnswer = 0;
  var db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    // getQuestionList();
  }

  // getQuestionList() async {
  //   // /Tests/teacherId/TestList/test_1 []
  //   state.loadedQuestionList.clear();
  //   await db.collection("Tests").get().then((value) {
  //     for (int i = 0; i < value.docs.length; i++) {
  //       setState(() {
  //         state.loadedQuestionList.add(QuestionModel(
  //           docID: value.docs[i].id,
  //           question: value.docs[i].data()["question"],
  //           time: value.docs[i].data()["time"],
  //           maxLen: value.docs[i].data()["maxLen"],
  //           minLen: value.docs[i].data()["minLen"],
  //           timeCreated: value.docs[i].data()['TimeCreated'] ?? 1,
  //           listOfStudents: value.docs[i].data()['ListOfStudents'] ?? [],
  //         ));
  //       });
  //     }
  //   });
  //   state.loadedQuestionList.sort((a, b) => b.timeCreated.compareTo(a.timeCreated));
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeacherEntryBloc, TeacherEntryState>(
      builder: (context, state) {
        if (state is TeacherEntryInitialState) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is TeacherEntryLoadedState) {
          return Scaffold(
            appBar: AppBar(
              title: Text('TypeOnly'),
              centerTitle: true,
            ),
            body: Column(
                //verticalDirection: VerticalDirection.down,
                children: [
                  Container(width: double.infinity, height: 20),
                  Container(
                    width: 120,
                    height: 40,
                    child: FloatingActionButton.extended(
                        heroTag: "create new Question",
                        backgroundColor: Colors.black,
                        shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
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
                                      hintStyle: new TextStyle(color: Colors.grey[800], fontSize: 18),
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
                                        constraints: BoxConstraints.tight(const Size(120, 30)),
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
                                            hintStyle: new TextStyle(color: Colors.grey[800], fontSize: 8),
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
                                        constraints: BoxConstraints.tight(const Size(120, 30)),
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
                                            hintStyle: new TextStyle(color: Colors.grey[800], fontSize: 8),
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
                                        constraints: BoxConstraints.tight(const Size(120, 30)),
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
                                            hintStyle: new TextStyle(color: Colors.grey[800], fontSize: 8),
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
                                          heroTag: "getQuestionList",
                                          backgroundColor: Colors.black,
                                          shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
                                          onPressed: () async {
                                            formHeight = 0;
                                            await db.collection("Tests").doc().set({
                                              "question": _questionController.text,
                                              "minLen": int.parse(_minLenController.text),
                                              "maxLen": int.parse(_maxLenController.text),
                                              "time": int.parse(_timeController.text) * 60,
                                              "TimeCreated": DateTime.now().millisecondsSinceEpoch,
                                              "whoCreated": userDataSave.uid
                                            });
                                            // getQuestionList();
                                          },
                                          label: Text('Save')),
                                    ),
                                  ],
                                ),
                              ])))),
                  Expanded(
                    // width: MediaQuery.of(context).size.width * 0.95,
                    // height: 500,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: state.loadedQuestionList.length,
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
                                        Text("Test unique ID: " + state.loadedQuestionList[index].docID),
                                        SizedBox(
                                          width: 50.0,
                                        ),
                                        Container(
                                          width: 80,
                                          height: 30,
                                          child: FloatingActionButton.extended(
                                            heroTag: "Copy question teach form",
                                            backgroundColor: Colors.black,
                                            shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
                                            onPressed: () async {
                                              Clipboard.setData(
                                                  new ClipboardData(text: state.loadedQuestionList[index].docID));
                                              Scaffold.of(context)
                                                  .showSnackBar(SnackBar(content: Text('text copied')));
                                            },
                                            label: Text(
                                              'Copy question\nUnique ID#',
                                              textScaleFactor: 0.6,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20.0,
                                        ),
                                        Container(
                                          width: 80,
                                          height: 30,
                                          child: FloatingActionButton.extended(
                                            heroTag: "edit question",
                                            backgroundColor: Colors.black,
                                            shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
                                            onPressed: () async {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  ///
                                                  ///
                                                  ///TODO
                                                  ///тут создаем локальные контроллеры для TextFormField
                                                  ///
                                                  ///Sozdaem local contollery
                                                  TextEditingController localQuestionController =
                                                      TextEditingController();
                                                 ///controller texta voprosa
                                                  TextEditingController localMaxLenghtController =
                                                  TextEditingController();
                                                  /// controller max dlinny voprosa
                                                  TextEditingController localMinLenghtController =
                                                  TextEditingController();
                                                  /// controller min dlinny voprosa
                                                  TextEditingController localMinTimeController =
                                                  TextEditingController();
                                                  /// controller dlya vremeni  otveta


                                                  /// Zadayem pervonachalniye znacheniya
                                                  localQuestionController.text =
                                                      state.loadedQuestionList[index].question;
                                                  localMaxLenghtController.text =
                                                      state.loadedQuestionList[index].maxLen.toString();
                                                  localMinLenghtController.text =
                                                      state.loadedQuestionList[index].minLen.toString();
                                                  localMinTimeController.text =
                                                     (state.loadedQuestionList[index].time/60).toString();


                                                     return AlertDialog(
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            FirebaseFirestore.instance
                                                                .collection("Tests")
                                                                .doc(state.loadedQuestionList[index].docID)
                                                                .update({
                                                              /// Ukazyvaem nazvanie w baze "questoin"
                                                              /// i cherez : peredayem to chto hochet sohranit
                                                              'question': localQuestionController.text,
                                                              'maxLen': int.parse(localMaxLenghtController.text),
                                                              'minLen': int.parse(localMinLenghtController.text),
                                                              'time' : int.parse(localMinTimeController.text)*60,
                                                              //state.loadedQuestionList[index].maxLen
                                                              //state.loadedQuestionList[index].minLen
                                                              //state.loadedQuestionList[index].time
                                                              //Peredelat zdes
                                                            });
                                                            Navigator.pop(context);
                                                          },
                                                          style: TextButton.styleFrom(
                                                            primary: Colors.white,
                                                            backgroundColor: Colors.black,
                                                            onSurface: Colors.black,
                                                          ),
                                                          child: Text("Save"))
                                                    ],
                                                    //title: Text('Edit text of the question below:'),
                                                    content: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [

                                                        SizedBox(
                                                          child: TextFormField(

                                                            controller: localQuestionController,
                                                            maxLines: 10,
                                                            minLines: 3,
                                                            decoration: InputDecoration(
                                                              hintText: 'Edit/modify content of the quiestion',
                                                              labelText: 'Edit/modify content of the quiestion',
                                                              border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                                                                                        ),

                                                          ),
                                                          // maximalnaya vysota ne ogranichena
                                                          width: 600,
                                                                                                                   //height: 100,
                                                        ),
                                                  SizedBox(height: 10,),
                                                        SizedBox( // sozdayem formu vvoda
                                                          child: TextFormField(
                                                            decoration: InputDecoration(
                                                              hintText: 'Edit maximal lenght of answer',
                                                              labelText: 'Edit maximal lenght of answer',
                                                  border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                            ),
                                                            /// peredayem nujnii controller
                                                            controller: localMaxLenghtController,

                                                            maxLines: 10,
                                                            minLines: 1,



                                                          ),),
                                                        SizedBox(height: 10,),
                                                        SizedBox( // sozdayem formu vvoda
                                                          child: TextFormField(
                                                            decoration: InputDecoration(
                                                              hintText: 'Edit minimal lenght of answer',
                                                              labelText: 'Edit minimal lenght of answer',
                                                              border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                            ),
                                                            /// peredayem nujnii controller
                                                            controller: localMinLenghtController,

                                                            maxLines: 10,
                                                            minLines: 1,



                                                          ),),SizedBox(height: 10,),
                                                        SizedBox( // sozdayem formu vvoda
                                                          child: TextFormField(
                                                            decoration: InputDecoration(
                                                              hintText: 'Edit alloted time to answer question (in minutes)',
                                                              labelText: 'Edit alloted time to answer question (in minutes)',
                                                              border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                            ),
                                                            /// peredayem nujnii controller
                                                            controller: localMinTimeController,

                                                            maxLines: 10,
                                                            minLines: 1,



                                                          ),),
                                                          ///shirina i vysota ramki conteinera
                                                        // width: 100,
                                                      //    height: 200,

                                                      //  ),
                                                                                                              ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            label: Text(
                                              'Edit question',
                                              textScaleFactor: 0.6,
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
                                      //height: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black,
                                        ),
                                        borderRadius: BorderRadius.circular(1.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child:
                                            Text("Text of Question: " + state.loadedQuestionList[index].question),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      children: [
                                        Text("Alloted time : " +
                                            (state.loadedQuestionList[index].time / 60).toString() +
                                            "min;  "),
                                        Text("Min. # of char.: " +
                                            state.loadedQuestionList[index].minLen.toString() +
                                            ";  "),
                                        Text("Max. # of char.: " +
                                            state.loadedQuestionList[index].maxLen.toString() +
                                            ";"),
                                        SizedBox(
                                          width: 20.0,
                                        ),
                                        Spacer(),
                                        Container(
                                          width: 80,
                                          height: 30,
                                          child: FloatingActionButton.extended(
                                            backgroundColor: Colors.black,
                                            shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
                                            onPressed: () async {
                                              db
                                                  .collection('Tests')
                                                  .doc(state.loadedQuestionList[index].docID)
                                                  .delete();
                                              // getQuestionList();
                                            },
                                            label: Text('Delete Question', textScaleFactor: 0.6),
                                            heroTag: "delete question",
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
                                            shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
                                            onPressed: () async {
                                              BlocProvider.of<GradeBloc>(context).add(GradeLoadingEvent(
                                                  questionID: state.loadedQuestionList[index].docID,
                                                  student: state.loadedQuestionList[index].listOfStudents));
                                              Navigator.push(context, MaterialPageRoute(builder: (_) {
                                                return GradingScreen(state.loadedQuestionList[index]);
                                              }));
                                            },
                                            label: Text(
                                              'Grade Answers',
                                              textScaleFactor: 0.6,
                                            ),
                                            heroTag: "Grade Answersteach form$index",
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
                ]),
          );
        } else if (state is OnErrorTeacherEntryState) {
          return Scaffold(
            body: Center(
              child: Text("Error Load Data.\nTry again."),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Text("Ooops"),
            ),
          );
        }
      },
    );
  }
}
