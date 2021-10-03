import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:editing_check/TeacherEntryForm.dart';
import 'package:editing_check/questionModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Authorization/registration_screen.dart';
import 'Student EntryForm.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('TypeOnly'),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        verticalDirection: VerticalDirection.down,
        children: [
          Container(width: double.infinity, height: 100),
          Text(
              'PASTE UNIQUE  QUESTION ID# (you can find it in the message from your teacher)',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
          Container(width: double.infinity, height: 50),
          Row(
            children: [
              Flexible(
                //height: 80,
                //width: MediaQuery.of(context).size.width * 0.7,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                  ),
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
                      hintStyle:
                          new TextStyle(color: Colors.grey[800], fontSize: 18),
                      hintText: "Question UNIQUE ID ",
                      fillColor: Colors.white24,
                    ),
                    maxLines: 1,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: FloatingActionButton.extended(
                  backgroundColor: Colors.black,
                  heroTag: "submit id",
                  shape:
                      BeveledRectangleBorder(borderRadius: BorderRadius.zero),
                  onPressed: () async {
                    QuestionModel myQuestion = QuestionModel();
                    await FirebaseFirestore.instance
                        .collection("Tests")
                        .doc(uniqueId.text)
                        .get()
                        .then((value) {
                      myQuestion = QuestionModel(
                        docID: value.id,
                        question: value.data()["question"],
                        time: value.data()["time"],
                        maxLen: value.data()["maxLen"],
                        minLen: value.data()["minLen"],
                        listOfStudents: value.data()["ListOfStudents"] ?? [],
                        timeCreated: value.data()['TimeCreated'] ?? 1,
                      );
                    });
                    if (myQuestion.listOfStudents
                        .contains('tmpStudentsId_3002'))
                      print('ERROR');
                    else
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return StudentEntryForm(myQuestion);
                      }));
                    setState(() {
                      uniqueId.text = '';
                    });
                  },
                  label: Text("Submit"),
                ),
              ),
            ],
          ),
          // Container(width: double.infinity, height: 10),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: FloatingActionButton.extended(
          //         backgroundColor: Colors.black,
          //         shape:
          //             BeveledRectangleBorder(borderRadius: BorderRadius.zero),
          //         onPressed: () {
          //           Navigator.push(context, MaterialPageRoute(builder: (_) {
          //             return TeacherEntryForm();
          //           }));
          //         },
          //         label: Text("Submit"),
          //       ),
          //     ),
          //   ],
          // )
        ],
      ),
      floatingActionButton: Row(
        children: [
          FloatingActionButton.extended(
            backgroundColor: Colors.black,
            shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return TeacherEntryForm();
                // return StudentEntryForm();
                // return StudentTimeExpiredScreen();
              }));
            },
            heroTag: "TeacherEntryForm",
            label: Text("TeacherEntryForm"),
          ),
          FloatingActionButton.extended(
            backgroundColor: Colors.black,
            shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(builder: (_) {
              //   // return GradingScreen();
              //   // return StudentEntryForm();
              //   // return StudentTimeExpiredScreen();
              // }));
            },
            heroTag: "GradingScreen",
            label: Text("GradingScreen"),
          ),
          FloatingActionButton.extended(
            backgroundColor: Colors.black,
            shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return RegisterPage();
                //   // return StudentEntryForm();
                // return StudentTimeExpiredScreen();
              }));
            },
            heroTag: "RegistrationScreen",
            label: Text("Registration Screen"),
          ),
          FloatingActionButton.extended(
            backgroundColor: Colors.black,
            shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return EmailPasswordForm();
                //   // return StudentEntryForm();
                // return StudentTimeExpiredScreen();
              }));
            },
            heroTag: "LoginScreen",
            label: Text("Login Screen"),
          ),
          InkWell(
            child: Text(userDataSave.email ?? "email"),
            onTap: (){
              setState(() {
                print(userDataSave.email);
              });
            },
          ),
          InkWell(
            child: Text(userDataSave.firstName ?? "name"),
            onTap: (){
              setState(() {
                print(userDataSave.firstName + " "+userDataSave.lastName);
              });
            },
          )
        ],
      ),
    );
  }
}
