import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:editing_check/teacher_entry_form.dart';
import 'package:editing_check/blocs/models/question_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Authorization/registration_screen.dart';
import 'Student EntryForm.dart';
import 'bloc_auth/UserBloc/user_bloc.dart';
import 'blocs/sudents_entery_bloc/sudents_entery_bloc.dart';
import 'blocs/teacher_entry_bloc/teacher_entry_bloc.dart';
import 'gradingScreen.dart';
import 'Authorization/login_screen.dart';
import 'main.dart';

class UniqueIdScreen extends StatefulWidget {
  @override
  _UniqueIdScreenState createState() => _UniqueIdScreenState();
}

class _UniqueIdScreenState extends State<UniqueIdScreen> {
  TextEditingController uniqueId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserInitialState) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is UserLoadedState) {
          userDataSave = state.userData;
          return Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('TypeOnly'),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //CircleAvatar(
                     //   radius: 20,),
                      Text(" " + state.userData.firstName + " " + state.userData.lastName),
                    ],
                  )
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Visibility(
                    visible: userDataSave.userStatus=='Teacher',
                    child: FloatingActionButton.extended(
                      backgroundColor: Colors.black,
                      shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
                      onPressed: () {
                        BlocProvider.of<TeacherEntryBloc>(context).add(TeacherEntryLoadingEvent());
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return TeacherEntryForm();
                        }));
                      },
                      heroTag: "TeacherEntryForm",
                      label: Text("Click here to create new question or grade submitted questions"),
                    ),

                  ),
                  SizedBox(width: double.infinity, height: 50),
                  // TextButton(
                  //     onPressed: () async {
                  //       var db = FirebaseFirestore.instance;
                  //      try{
                  //        await db.collection('mail').doc().set({
                  //          'to':['snxz21@mail.ru'],
                  //          'message': {
                  //            'subject': 'Hello from Firebase!',
                  //            'text': 'This is the plaintext section of the email body.',
                  //            // 'html': 'This is the <code>HTML</code> section of the email body.',
                  //          }
                  //        });
                  //      }
                  //      catch(e){
                  //        print(e);
                  //      }
                  //     },
                  //     child: Text("testtest")),
                  Text('PASTE UNIQUE  QUESTION ID# (you can find it in the message from your teacher)',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      )),
                  SizedBox(width: double.infinity, height: 50),
                  Row(
                    children: [
                      Flexible(
                        //height: 80,
                        //width: MediaQuery.of(context).size.width * 0.7,
                        child: TextFormField(
                          controller: uniqueId,
                          decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(15.0),
                              ),
                            ),
                            filled: true,
                            hintStyle: new TextStyle(color: Colors.grey[800], fontSize: 18),
                            hintText: "Question UNIQUE ID ",
                            fillColor: Colors.white24,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Container(
                            height: 35,
                            child: OutlinedButton(
                              child: Text(
                                "Submit",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                if (uniqueId.text.length == 20) {
                                  BlocProvider.of<SudentsEnteryBloc>(context).add(
                                    SudentsEnteryLoadingEvent(uniqueId.text),
                                  );
                                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                                    return StudentEntryForm();
                                  }));
                                  // setState(() {
                                  //   uniqueId.text = '';
                                  // });
                                } else {
                                  print(uniqueId.text.length == 20);
                                  print(uniqueId.text.length);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text('Incorrect UNIQUE ID, try again'),
                                          Icon(Icons.error),
                                        ],
                                      ),
                                      backgroundColor: Colors.redAccent,
                                    ),
                                  );
                                }
                              },
                              style: TextButton.styleFrom(backgroundColor: Colors.black),
                            ),
                          )
                          // FloatingActionButton.extended(
                          //   backgroundColor: Colors.black,
                          //   heroTag: "submit id",
                          //   shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
                          //   onPressed: () async {
                          //     QuestionModel myQuestion = QuestionModel();
                          //     await FirebaseFirestore.instance.collection("Tests").doc(uniqueId.text).get().then((value) {
                          //       myQuestion = QuestionModel(
                          //         docID: value.id,
                          //         question: value.data()["question"],
                          //         time: value.data()["time"],
                          //         maxLen: value.data()["maxLen"],
                          //         minLen: value.data()["minLen"],
                          //         listOfStudents: value.data()["ListOfStudents"] ?? [],
                          //         timeCreated: value.data()['TimeCreated'] ?? 1,
                          //       );
                          //     });
                          //     if (myQuestion.listOfStudents.contains('tmpStudentsId_3002'))
                          //       print('ERROR');
                          //     else
                          //       Navigator.push(context, MaterialPageRoute(builder: (_) {
                          //         return StudentEntryForm(myQuestion);
                          //       }));
                          //     setState(() {
                          //       uniqueId.text = '';
                          //     });
                          //   },
                          //   label: Text("Submit"),
                          // ),
                          ),
                    ],
                  ),
                ],
              ),
            ),

          );
        } else {
          return Container();
        }
      },
    );
  }
}
