import 'package:editing_check/TeacherEntryForm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Student EntryForm.dart';

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
        title: Text('TypeOnly'),
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
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return StudentEntryForm();
                    }));
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
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return TeacherEntryForm();
            // return StudentEntryForm();
            // return StudentTimeExpiredScreen();
          }));
        },
        label: Text("TestScreen"),
      ),
    );
  }
}
