import 'dart:developer' as dev;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import '../bloc_auth/user_repository.dart';

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
  bool isNewRegEnd = true;
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

      String getRandomString(int length) =>
          String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
      element[3] = getRandomString(6);
      toFirebase.add(
        {
          "firstName": element[0],
          "lastName": element[1],
          "email": element[2],
          "password": element[3],
          "userStatus": element[4],
          "regStatus": '',
        },
      );
    });
    print(toFirebase);
  }

  @override
  void initState() {
    super.initState();
    nameController.text =
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
                       FloatingActionButton.extended(
              onPressed: () {
                parser(nameController.text);
                setState(() {});
              },
              label: Text("Parse"),
              heroTag: "Parsing Button",
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0))
              ),
              backgroundColor: Colors.black,

            ),
            Expanded(
              child: ListView.builder(
                  // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //   crossAxisCount: 1,
                  //   mainAxisSpacing: 10,
                  //   crossAxisSpacing: 20,
                  //   childAspectRatio: 20 / 1,
                  // ),
                  itemCount: toFirebase.length != 0 ? toFirebase.length : 1,
                  itemBuilder: (BuildContext ctx, index) {
                    if (toFirebase.length == 0) {
                      return Container();
                    }
                    var containerColor = Colors.grey.shade500;
                    if (toFirebase[index]["regStatus"] == '') {
                      containerColor = Colors.grey.shade500;
                    } else if (toFirebase[index]["regStatus"] == 'accept') {
                      containerColor = Colors.green.shade100;
                    } else if (toFirebase[index]["regStatus"] == 'emailAlready') {
                      containerColor = Colors.yellow.shade100;
                    } else {
                      containerColor = Colors.redAccent.shade100;
                    }
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Container(
                        alignment: Alignment.center,

                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        width: MediaQuery.of(context).size.width * 0.95,
                        height: 120,
                        decoration: BoxDecoration(color: containerColor, borderRadius: BorderRadius.circular(0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Expanded(
                                    child: Text(
                                        "First & Last Name: " + toFirebase[index]["firstName"] + " " + toFirebase[index]["lastName"])),
                                Expanded(child: Text("email: " + toFirebase[index]["email"])),
                                Expanded(child: Text("Status: " + toFirebase[index]["userStatus"])),
                                Expanded(child: Text("Password: " + toFirebase[index]["password"])),
                                Text("regStatus: " + toFirebase[index]["regStatus"]),
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                            FloatingActionButton.extended(
                              onPressed: !isNewRegEnd
                                  ? () {
                                      dev.log('empty click');
                                    }
                                  : () async {
                                      setState(() {
                                        isNewRegEnd = false;
                                      });

                                      UserRepository userRep = UserRepository();
                                      try {
                                        UserCredential regUserData = await userRep.signUp(
                                          email: toFirebase[index]["email"],
                                          password: toFirebase[index]["password"],
                                          userStatus: toFirebase[index]["userStatus"],
                                          firstName: toFirebase[index]["firstName"],
                                          lastName: toFirebase[index]["lastName"],
                                        );

                                        if (regUserData != null) {
                                          print(regUserData.user.uid);
                                          dev.log(regUserData.user.uid);
                                          toFirebase[index]["regStatus"] = 'accept';
                                        }
                                        isNewRegEnd = await userRep.writeDBUserData(
                                          email: toFirebase[index]["email"],
                                          regUserData: regUserData,
                                          userStatus: toFirebase[index]["userStatus"],
                                          firstName: toFirebase[index]["firstName"],
                                          lastName: toFirebase[index]["lastName"],
                                        );
                                      } on FirebaseAuthException catch (e) {
                                        print('create user error $e');
                                        if (e.message.contains('The email address is already'))
                                          toFirebase[index]["regStatus"] = 'emailAlready';
                                        else
                                          toFirebase[index]["regStatus"] = e.message;
                                      }
                                      Future.delayed(Duration(seconds: 5), () {
                                        userRep.signOut();
                                        setState(() {
                                          isNewRegEnd = true;
                                        });
                                      });
                                    },
                              label: Text("Register"),
                              backgroundColor: isNewRegEnd ? Colors.blue : Colors.grey,
                            ),
                          ],
                        ),
                        // "firstName": element[0],
                        // "lastName": element[1],
                        // "email": element[2],
                        // "password": element[3],
                        // "userStatus": element[4],
                      ),
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
