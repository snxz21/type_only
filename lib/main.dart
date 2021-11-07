//import 'package:editing_check/question_model.dart';
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:editing_check/blocs/sudents_entery_bloc/sudents_entery_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Authorization/user_model.dart';
import 'UniqueIdScreen.dart';
import 'bloc_auth/UserBloc/user_bloc.dart';
import 'bloc_auth/authentication_bloc/authentication_bloc.dart';
import 'bloc_auth/screens/login/login_screen.dart';
import 'bloc_auth/simple_bloc_observer.dart';
import 'bloc_auth/user_repository.dart';
import 'blocs/teacher_entry_bloc/teacher_entry_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  final UserRepository userRepository = UserRepository();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(
            userRepository: userRepository,
          )..add(AuthenticationStarted()),
        ),
        BlocProvider<UserBloc>(
          create: (_) => UserBloc(),
        ),
        BlocProvider<SudentsEnteryBloc>(
          create: (_) => SudentsEnteryBloc(),
        ),
        BlocProvider<TeacherEntryBloc>(
          create: (_) => TeacherEntryBloc(),
        ),
      ],
      child: MyApp(
        userRepository: userRepository,
      ),
    ),
  );
}

UserModel userDataSave = UserModel();

class MyApp extends StatelessWidget {
  final UserRepository _userRepository;

  MyApp({UserRepository userRepository}) : _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    // sendNotification("test","test1",tokenCRM
    //     "ezUkiV9sQa6RwZGVd61xoZ:APA91bEC-DLP2ORP9Xk-TGL7WDPzyWVrCO8AK5I-7SsiGQJOGMLmD1P5tIUKDrkDkscSFvMXfLVR2IiF3_jUr2P1q6wpg9rid5GXdZfa9FrrHE8eRuvsd0hYjYjxhEoxiHO3gWPo-31U"
    // );
    return MaterialApp(
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child,
      ),
      routes: {
        // 'main':(context)=>SideBarMenu(),
        // '/secondLevelItem1': (context) => TestTest(),
      },
      title: 'Type only',
      // theme: ThemeData(
      //   // brightness: Brightness.dark,
      //
      // ),
      // darkTheme: ThemeData(
      //   brightness: Brightness.dark,
      //   // textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(bodyColor: Colors.white),
      // ),
      // themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationFailure) {
            return LoginScreen(
              userRepository: _userRepository,
            );
          }

          if (state is AuthenticationSuccess) {
            BlocProvider.of<UserBloc>(context).add(UserLoadingEvent());

            return UniqueIdScreen();
          }

          return Scaffold(
            appBar: AppBar(),
            body: Container(
              child: Center(child: Text("Loading")),
            ),
          );
        },
      ),
    );
  }
}
// @override
// Widget build(BuildContext context) {
//   return MaterialApp(
//     title: 'TypeInOnly',
//     debugShowCheckedModeBanner: false,
//     theme: ThemeData(
//       primarySwatch: Colors.blue,
//     ),
//     home: UniqueIdScreen(),
//     //routes: {},
//   );
// }
