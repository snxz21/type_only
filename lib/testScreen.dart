import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TeacherEntryForm extends StatefulWidget {
  @override
  _TeacherEntryFormState createState() => _TeacherEntryFormState();
}

class _TeacherEntryFormState extends State<TeacherEntryForm> {
  TextEditingController uniqueId_1 = TextEditingController();

  double formHeight = 0;

  int minLenAnswer = 0;

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
            Container(
              child: FloatingActionButton.extended(
                  onPressed: () {
                    setState(() {
                      formHeight = 300;
                    });
                  },
                  label: Text('New question')),
            ),
            AnimatedContainer(
              height: formHeight,
              duration: Duration(milliseconds: 800),
              child: Card(
                elevation: 7,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 100,
                        child: TextFormField(
                          controller: uniqueId_1,
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
                            hintText: "Type your question here ",
                            fillColor: Colors.white24,
                          ),
                          maxLines: 3,
                        ),
                      ),
                      Row(
                        children: [
                          Text("Minimal length of answer (char):"),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  minLenAnswer -= 10;
                                });
                              },
                              icon: Icon(Icons.arrow_back_rounded)),
                          Text(minLenAnswer.toString()),
                          IconButton(onPressed: () { setState(() {
                            minLenAnswer += 10;
                          });}, icon: Icon(Icons.add)),
                        ],
                      ),
                      Text("Maximal length of answer (char):  100"),
                      Text("Maximal time of answer (min):    10"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FloatingActionButton.extended(
                              backgroundColor: Colors.black,
                              shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) {
                                  return TeacherEntryForm();
                                }));
                              },
                              label: Text("Submit"),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(width: double.infinity, height: 100),
            Text('Sorry, you do not have questons, please add question',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                )),
            Container(width: double.infinity, height: 50),
            Flexible(
              //height: 80,
              //width: MediaQuery.of(context).size.width * 0.7,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 1, 10, 10),
                child: TextFormField(
                  controller: uniqueId_1,
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
                    hintText: "Type your question here ",
                    fillColor: Colors.white24,
                  ),
                  maxLines: 1,
                ),
              ),
            ),
            Container(width: double.infinity, height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton.extended(
                    backgroundColor: Colors.black,
                    shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return TeacherEntryForm();
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
