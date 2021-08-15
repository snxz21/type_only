import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TeacherEntryForm extends StatefulWidget {
  @override
  _TeacherEntryFormState createState() => _TeacherEntryFormState();
}

class _TeacherEntryFormState extends State<TeacherEntryForm> {
  TextEditingController uniqueId_1 = TextEditingController();
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();

  double formHeight = 0;

  int minLenAnswer = 0;

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
                      backgroundColor: Colors.black,
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.zero),
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
                                  controller: uniqueId_1,
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
                                      constraints: BoxConstraints.tight(
                                          const Size(60, 30)),
                                      child: TextFormField(
                                        controller: _controller1,
                                        decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                              const Radius.circular(1.0),
                                            ),
                                          ),
                                          filled: true,
                                          hintStyle: new TextStyle(
                                              color: Colors.grey[800],
                                              fontSize: 8),
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
                                      constraints: BoxConstraints.tight(
                                          const Size(60, 30)),
                                      child: TextFormField(
                                        controller: _controller2,
                                        decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                              const Radius.circular(1.0),
                                            ),
                                          ),
                                          filled: true,
                                          hintStyle: new TextStyle(
                                              color: Colors.grey[800],
                                              fontSize: 8),
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
                                      constraints: BoxConstraints.tight(
                                          const Size(60, 30)),
                                      child: TextFormField(
                                        controller: _controller3,
                                        decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                              const Radius.circular(1.0),
                                            ),
                                          ),
                                          filled: true,
                                          hintStyle: new TextStyle(
                                              color: Colors.grey[800],
                                              fontSize: 8),
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
                                        onPressed: () {
                                          setState(() {});
                                        },
                                        label: Text('Save')),
                                  ),
                                ],
                              ),
                            ])))),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0, 0),
                  child: Row(
                    children: [
                      Text("Question ID#:  1234556"),
                      IconButton(
                        icon: Icon(
                          Icons.add_link,
                        ),
                        iconSize: 25,
                        color: Colors.black,
                        splashColor: Colors.purple,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                  child: Row(
                    children: [
                      Container(
                        width: 1000,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(1.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text("What is Apoptosis? "),
                        ),
                      )
                    ],
                  ),
                ),
              ]),
        ));
  }
}
