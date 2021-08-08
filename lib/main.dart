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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UniqueIdScreen(),
    );
  }
}


