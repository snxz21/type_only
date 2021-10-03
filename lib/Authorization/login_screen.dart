import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';
//import 'package:flutter/foundation.dart' show kIsWeb;

final FirebaseAuth _auth = FirebaseAuth.instance;

class EmailPasswordForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmailPasswordFormState();
}

class _EmailPasswordFormState extends State<EmailPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Sign in with email and password',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (String value) {
                    if (value.isEmpty) return 'Please enter some text';
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (String value) {
                    if (value.isEmpty) return 'Please enter some text';
                    return null;
                  },
                  obscureText: true,
                ),
                Container(
                  padding: const EdgeInsets.only(top: 16),
                  alignment: Alignment.center,
                  child: SignInButton(
                    buttonType: ButtonType.mail,
                    btnText: 'Sign In',
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await _signInWithEmailAndPassword();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Example code of how to sign in with email and password.
  Future<void> _signInWithEmailAndPassword() async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;

      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('${user.email} signed in'),
        ),
      );
    } catch (e) {
      Scaffold.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to sign in with Email & Password'),
        ),
      );
    }
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:editing_check/Authorization/user_model.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class LoginScreen extends StatefulWidget {
//   static const String id = 'login_screen';
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 24.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             SizedBox(
//               height: 48.0,
//             ),
//             TextField(
//               onChanged: (value) {
//                 //Do something with the user input.
//               },
//               decoration: InputDecoration(
//                 hintText: 'Enter your email',
//                 contentPadding:
//                     EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(32.0)),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide:
//                       BorderSide(color: Colors.lightBlueAccent, width: 1.0),
//                   borderRadius: BorderRadius.all(Radius.circular(32.0)),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide:
//                       BorderSide(color: Colors.lightBlueAccent, width: 2.0),
//                   borderRadius: BorderRadius.all(Radius.circular(32.0)),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 8.0,
//             ),
//             TextField(
//               onChanged: (value) {
//                 //Do something with the user input.
//               },
//               decoration: InputDecoration(
//                 hintText: 'Enter your password.',
//                 contentPadding:
//                     EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(32.0)),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide:
//                       BorderSide(color: Colors.lightBlueAccent, width: 1.0),
//                   borderRadius: BorderRadius.all(Radius.circular(32.0)),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide:
//                       BorderSide(color: Colors.lightBlueAccent, width: 2.0),
//                   borderRadius: BorderRadius.all(Radius.circular(32.0)),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 24.0,
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 16.0),
//               child: Material(
//                 color: Colors.lightBlueAccent,
//                 borderRadius: BorderRadius.all(Radius.circular(30.0)),
//                 elevation: 5.0,
//                 child: MaterialButton(
//                   onPressed: () {
//                     FirebaseFirestore.instance
//                         .collection('users')
//                         .doc()
//                         .snapshots()
//                         .map((snap) => UserModel.fromFirestore(snap));
//                   },
//                   minWidth: 200.0,
//                   height: 42.0,
//                   child: Text(
//                     'Log In',
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
