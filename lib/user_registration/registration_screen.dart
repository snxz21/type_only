import 'package:flutter/material.dart';

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
    

    //String str = 'Frank Kunik,1drfrankkdo@aol.com,& Alexey Podcheko,apodcheko@auis.edu,& John Smith,jsmith@auis.edu';

    //split string
    var arr = str.split(',& ');
    print(str);
    for (int i=0; i<arr.length;i++){arr[i]=arr[i].replaceAll(",", " ");};
    // str=str.replaceAll(",", " ");
    //print(str);
    print(arr);
    var X = [];
    arr.forEach((element) {X.add(element.split(' '));});
    finalList=X;
    print(X);
    print (X[0][0]);
    print (X[0][1]);
    print (X[2][0]);




    //final str1 = "Dr. Frank Kunik ,1drfrankkdo@aol.com&Alexey Podcheko,apodcheko@auis.edu&";
    // print(str1.split(new RegExp(r'\s')));
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
                  ),
                  // onChanged: (text) {
                  //   setState(() {
                  //     listOfStudents = text;
                  //     print(nameController.text);
                  //     //you can access nameController in its scope to get
                  //     // the value of text entered as shown below
                  //     //fullName = nameController.text;
                  //   });
                  // },
                )),
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
