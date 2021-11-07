import 'package:editing_check/bloc_auth/login_bloc/login_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../user_repository.dart';
import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository _userRepository;

  const LoginScreen({Key key, UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(userRepository: _userRepository),
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Container(
                margin: const EdgeInsets.only(top: 230),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  // height: MediaQuery.of(context).size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 3,
                        child: Container(),
                      ),
                      Flexible(
                        flex: 3,
                        child: LoginForm(
                          userRepository: _userRepository,
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Container(),
                      ),
                    ],
                  ),
                ),
              ),
              color: HexColor("fbfdff"),
            ),
          ],
        ),
      ),
    );
  }
}
