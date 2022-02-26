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
  var myFile = File('student.json');
  parser(String str){
    

    //String str = 'Frank Kunik,1drfrankkdo@aol.com,& Alexey Podcheko,apodcheko@auis.edu,& John Smith,jsmith@auis.edu';

    //split string
    var arr = str.split(',& ');
    //print(str);
    for (int i=0; i<arr.length;i++){arr[i]=arr[i].replaceAll(",", " ");};
    // str=str.replaceAll(",", " ");
    //print(str);
    //print(arr);
    var listOfParsedStudents = [];
    arr.forEach((element) {listOfParsedStudents.add(element.split(' '));});
    finalList=listOfParsedStudents;
    print(listOfParsedStudents);
    Map mapOfParsedStudents = {for (var item in listOfParsedStudents) '$item' : 'valueOf$item'};
   print(mapOfParsedStudents);
    var encoder = JsonEncoder.withIndent(' ');
        myFile.writeAsStringSync(encoder.convert(mapOfParsedStudents));
        print(myFile.readAsStringSync());

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

            });}, label: Text("Parse")),


          ]))),


    );

  }

}
