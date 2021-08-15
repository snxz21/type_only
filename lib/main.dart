//import 'package:editing_check/questionModel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'UniqueIdScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // if (USE_FIRESTORE_EMULATOR) {
  //   FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  // }
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TypeInOnly',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UniqueIdScreen(),
    );
  }
}


