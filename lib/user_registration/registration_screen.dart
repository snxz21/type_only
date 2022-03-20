import 'package:flutter/material.dart';
import 'dart:math';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ParserScreen());
  }
}

class ParserScreen extends StatefulWidget {
  ParserScreen({Key key}) : super(key: key);

  @override
  _ParserScreenState createState() {
    return _ParserScreenState();
  }
}

class _ParserScreenState extends State<ParserScreen> {
  TextEditingController nameController = TextEditingController();
  String listOfStudents = '';
  var finalList = [];
  List<Map<String, String>> toFirebase = [];

  parser(String str) {
    var arr = str.split(',& ');
    for (int i = 0; i < arr.length; i++) {
      arr[i] = arr[i].replaceAll(",", " ");
    }
    ;
    var listOfParsedStudents = [];
    arr.forEach((element) {
      listOfParsedStudents.add(element.split(' '));
    });
    finalList = listOfParsedStudents;
    //print(listOfParsedStudents);
    toFirebase.clear();
    listOfParsedStudents.forEach((element) {
      const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
      Random _rnd = Random();

      String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
          length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
      element [3]=getRandomString(6);
      toFirebase.add(
        {
          "firstName": element[0],
          "lastName": element[1],
          "email": element[2],
          "password": element[3],
          "userStatus": element[4],
        },
      );
    });
    print(toFirebase);
  }

  @override
  void initState() {
    super.initState();
    nameController.text="Frank Kunik,1drfrankkdo@aol.com,asdfg,Teacher,& "
    "Alexey Podcheko,apodcheko@auis.edu,123456,Student,& "
    "John Smith,jsmith11@auis.edu,456567,Student";
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('TypeOnly Registration'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.all(20),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Paste student names and emails from CSV file here',
                  ),
                )),
            Container(
              margin: EdgeInsets.all(20),
              child: Text(finalList.toString()),
            ),
            FloatingActionButton.extended(
              onPressed: () {
                parser(nameController.text);
                setState(() {});
              },
              label: Text("Parse"),
              heroTag: "ljndsfbkljndsbflkjnzdbfkjn",
            ),
            Expanded(
                  child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 20,
                    childAspectRatio: 20/1,
                  ),
                  itemCount: toFirebase.length != 0 ? toFirebase.length : 1,
                  itemBuilder: (BuildContext ctx, index) {
                    if (toFirebase.length == 0) {
                      return Container();
                    }
                    return Container(
                      alignment: Alignment.center,
                      padding:EdgeInsets.symmetric(horizontal: 10),
                                                                                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                          Column(

                            children: [
                              Expanded(child: Text("First & Last Name: " + toFirebase[index]["firstName"]+" " + toFirebase[index]["lastName"])),
                              Expanded(child: Text("email: " + toFirebase[index]["email"])),
                              Expanded(child: Text("Status: "+ toFirebase[index]["userStatus"])),
                              Expanded(child: Text("Password: "+ toFirebase[index]["password"])),
                            ],
                          ),
                          FloatingActionButton.extended(onPressed: (){}, label: Text("Register")),
                                                  ],
                      ),
                      // "firstName": element[0],
                      // "lastName": element[1],
                      // "email": element[2],
                      // "password": element[3],
                      // "userStatus": element[4],
                      decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(0)),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     const title = 'Grid List';
//
//     return MaterialApp(
//       title: title,
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text(title),
//         ),
//         body: GridView.count(
//           // Create a grid with columns. If you change the scrollDirection to
//           // horizontal, this produces 2 rows.
//           crossAxisCount: 3,
//           // Generate 100 widgets that display their index in the List.
//           children: List.generate(100, (index) {
//             return Center(
//               child: Text(
//                 'Student $index',
//                 style: Theme.of(context).textTheme.headline5,
//               ),
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }
