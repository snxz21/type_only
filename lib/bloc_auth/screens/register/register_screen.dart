// import 'package:logopediya174/blocs/register_bloc/register_bloc.dart';
// import 'package:logopediya174/repositories/user_repository.dart';
// import 'package:logopediya174/screens/register/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:editing_check/bloc_auth/register_bloc/register_bloc.dart';
import 'package:editing_check/bloc_auth/screens/register/register_form.dart';

import '../../user_repository.dart';

class RegisterScreen extends StatelessWidget {
  final UserRepository _userRepository;

  const RegisterScreen({Key key, UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterBloc>(
      create: (context) => RegisterBloc(userRepository: _userRepository),
      child: Container(
        margin: const EdgeInsets.only(top: 230),
        child: RegisterForm(),
      ),
    );
  }
}
