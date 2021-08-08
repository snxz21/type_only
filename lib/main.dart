//import 'package:editing_check/questionModel.dart';
import 'package:flutter/material.dart';
import 'UniqueIdScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TypeInOnly',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UniqueIdScreen(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage();
//   TextEditingController answer = TextEditingController();
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   TextEditingController answer = TextEditingController();
//
//   // List<String> editingHistory = [];
//   bool isEnable = true;
//
//   int oldLen = 0;
//   int minLen = 16;
//   int maxLen = 500;
//
//   QuestionModel myClass =
//       QuestionModel(question: "What is inflammation?", answer: "answer");
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("TypeInOnly"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Row(
//               children: [
//                 Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(30.0),
//                       child: Text("QUESTION: ${myClass.question}"),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//             Container(
//               width: MediaQuery.of(context).size.width * 0.75,
//               child: TextFormField(
//                 decoration: InputDecoration(
//                     labelText: 'Type answer here',
//                     border: OutlineInputBorder()),
//                 enabled: isEnable,
//                 controller: answer,
//                 maxLength: maxLen,
//                 minLines: 1,
//                 maxLines: 15,
//                 onChanged: (value) {
//                   print(value);
//                   if (value.length - oldLen > 1) {
//                     setState(() {
//                       isEnable = false;
//                     });
//                     print('do not paste');
//                   } else {
//                     setState(() {
//                       oldLen = value.length;
//                     });
//                   }
//                 },
//               ),
//             ),
//             Visibility(
//               visible: !isEnable,
//               child: Container(
//                 margin: const EdgeInsets.all(15.0),
//                 padding: const EdgeInsets.all(3.0),
//                 decoration:
//                     BoxDecoration(border: Border.all(color: Colors.blueAccent)),
//                 child: Text(
//                   'DO NOT COPY/PASTE!',
//                   //'$isEnable  My text is ${answer.text}',
//                   style: Theme.of(context).textTheme.headline4,
//                 ),
//               ),
//             ),
//             Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: Opacity(
//                     opacity: oldLen > minLen && oldLen < maxLen ? 1.0 : 0.5,
//                     child: FloatingActionButton.extended(
//                         onPressed: oldLen > minLen && oldLen < maxLen
//                             ? () {
//                                 setState(() {
//                                   isEnable = false;
//                                 });
//                               }
//                             : null,
//                         label: Row(
//                           children: [
//                             Text("SUBMIT"),
//                             Icon(Icons.check),
//                           ],
//                         )),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
