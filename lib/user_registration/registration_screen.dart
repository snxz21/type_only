import 'package:flutter/material.dart';
//import 'package:filter_list/filter_list.dart';
import 'dart:io';
import 'dart:convert';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController nameController = TextEditingController();
  String listOfStudents = '';
  var finalList=[];
    parser(String str){
    var arr = str.split(',& ');
    for (int i=0; i<arr.length;i++){arr[i]=arr[i].replaceAll(",", " ");};
    var listOfParsedStudents = [];
    arr.forEach((element) {listOfParsedStudents.add(element.split(' '));});
    finalList=listOfParsedStudents;
    //print(listOfParsedStudents);
    List<Map<String,String>> toFirebase = [];
listOfParsedStudents.forEach((element) { toFirebase.add( {
  "firstName": element[0],
  "lastName": element[1],
  "email": element[2],
  "password": element[3],
  "userStatus":element[4],
},);});
print(toFirebase);

  }
  
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('TypeOnly Registration'),
          ),
          body: Center(child: Column(children: <Widget>[
            Container(
                margin: EdgeInsets.all(20),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Paste student names and emails from CSV file here',
                  ),                )),
            Container(
              margin: EdgeInsets.all(20),
              child: Text(finalList.toString()),

            ),
            FloatingActionButton.extended(onPressed: (){parser(nameController.text); setState(() {

            });}, label: Text("Parse"), heroTag: "ljndsfbkljndsbflkjnzdbfkjn",),


          ]))),


    );

  }

}
