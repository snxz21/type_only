import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'UniqueIdScreen.dart';

class StudentTimeExpiredScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TypeOnly'),
        centerTitle: true,
      ),
      body: Column(
        verticalDirection: VerticalDirection.down,
        children: [
          Container(width: double.infinity, height: 100),
          Text('Sorry your time is expired to answer this question',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
            child: FloatingActionButton.extended(
              backgroundColor: Colors.black,
              shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
              onPressed: () {
                // ignore: missing_return
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return UniqueIdScreen();
                }));
              },
              label: Text("Answer Again"),
            ),
          ),
        ],
      ),
    );
  }
}
