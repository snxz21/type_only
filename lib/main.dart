import 'package:editing_check/questionModel.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage() ;
  TextEditingController answer = TextEditingController();



  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController answer = TextEditingController();

  // List<String> editingHistory = [];
  bool isEnable = true;

  int oldLen = 0;
  int minLen = 15;
  int maxLen = 20;

  QuestionModel myClass = QuestionModel(question: "String question", answer: "answer");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Question: ${myClass.question}"),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: TextFormField(
                    enabled: isEnable,
                    controller: answer,
                    maxLength: 20,
                    minLines: 10,
                    maxLines: 15,
                    onChanged: (value) {
                      print(value);
                      if (value.length - oldLen > 1) {
                        setState(() {
                          isEnable = false;
                        });
                      } else {
                        setState(() {
                          oldLen = value.length;
                        });
                      }
                    },
                  ),
                ),
                Opacity(
                  opacity: oldLen > minLen && oldLen < maxLen ? 1.0 : 0.5,
                  child: FloatingActionButton.extended(
                      onPressed: oldLen > minLen && oldLen < maxLen
                          ? () {
                              setState(() {
                                isEnable = false;
                              });
                            }
                          : null,
                      label: Row(
                        children: [
                          Text("Save"),
                          Icon(Icons.check),
                        ],
                      )),
                )
              ],
            ),
            Text(
              '$isEnable  my text is ${answer.text}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
