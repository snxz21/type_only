import 'package:hexcolor/hexcolor.dart';
// import 'package:logopediya174/blocs/authentication_bloc/authentication_bloc.dart';
// import 'package:logopediya174/blocs/authentication_bloc/authentication_event.dart';
// import 'package:logopediya174/blocs/login_bloc/login_bloc.dart';
// import 'package:logopediya174/blocs/login_bloc/login_event.dart';
// import 'package:logopediya174/blocs/login_bloc/login_state.dart';
// import 'package:logopediya174/blocs/register_bloc/register_bloc.dart';
// import 'package:logopediya174/repositories/user_repository.dart';
// import 'package:logopediya174/screens/register/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:editing_check/bloc_auth/authentication_bloc/authentication_bloc.dart';
import 'package:editing_check/bloc_auth/login_bloc/login_bloc.dart';
import 'package:editing_check/bloc_auth/register_bloc/register_bloc.dart';
import 'package:editing_check/bloc_auth/screens/register/register_form.dart';

import '../../user_repository.dart';


class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;

  const LoginForm({Key key, UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLogin = true;

  bool get isPopulated => _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChange);
    _passwordController.addListener(_onPasswordChange);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            // ignore: deprecated_member_use
            ..removeCurrentSnackBar()
            // ignore: deprecated_member_use
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Ошибка логина'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Color(0xffffae88),
              ),
            );
        }

        if (state.isSubmitting) {
          Scaffold.of(context)
            // ignore: deprecated_member_use
            ..removeCurrentSnackBar()
            // ignore: deprecated_member_use
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Логин...'),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  ],
                ),
                backgroundColor: Color(0xffffae88),
              ),
            );
        }

        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(
            AuthenticationLoggedIn(),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              child: Column(
                children: <Widget>[
                  // Container(
                  //   width: MediaQuery.of(context).size.width * 0.8,
                  //   height: 56,
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       setState(() {
                  //         isLogin = !isLogin;
                  //       });
                  //     },
                  //     child: Center(
                  //       child: Text(
                  //         "Вход/Регистрация",
                  //         style: TextStyle(fontSize: 25, color: Colors.black),
                  //       ),
                  //     ),
                  //     style: ButtonStyle(
                  //         // minimumSize: ,
                  //         elevation: MaterialStateProperty.all(0),
                  //         shape:
                  //             MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(15.0),
                  //           // side: BorderSide(color: Colors.red)
                  //         )),
                  //         backgroundColor: MaterialStateProperty.all<Color>(HexColor("0cbbe2"))),
                  //   ),
                  // ),
                  isLogin
                      ? Column(
                          children: [
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: state.isEmailValid ? 56 : 80,
                              child: TextFormField(
                                controller: _emailController,
                                textAlign: TextAlign.center,
                                style: new TextStyle(color: Colors.grey[800], fontSize: 25),
                                decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(15.0),
                                    ),
                                  ),
                                  filled: true,
                                  hintStyle: new TextStyle(color: Colors.grey[800], fontSize: 25),
                                  hintText: "E-mail",
                                  fillColor: Colors.white70,
                                  // counterText: "",
                                  // counterStyle: TextStyle(fontSize: 0)
                                ),
                                keyboardType: TextInputType.emailAddress,
                                autovalidateMode: AutovalidateMode.always,
                                autocorrect: false,
                                validator: (_) {
                                  return !state.isEmailValid ? 'Не корректный email' : null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: state.isPasswordValid ? 56 : 80,
                              child: TextFormField(
                                controller: _passwordController,
                                textAlign: TextAlign.center,
                                style: new TextStyle(color: Colors.grey[800], fontSize: 25),
                                decoration: new InputDecoration(
                                    border: new OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(15.0),
                                      ),
                                    ),
                                    filled: true,
                                    hintStyle: new TextStyle(color: Colors.grey[800], fontSize: 25),
                                    hintText: "Пароль",
                                    fillColor: Colors.white70),
                                obscureText: true,
                                // autovalidate: true,
                                autocorrect: false,
                                validator: (_) {
                                  return !state.isPasswordValid ? 'Не корректный пароль' : null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 56,
                              child: FloatingActionButton.extended(
                                onPressed:
                                    /*!isLogin
                          ? () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) {
                                return LoginScreen(
                                  userRepository: widget._userRepository,
                                );
                              }));
                            }
                          :*/
                                    () {
                                  // if (isButtonEnabled(state)) {
                                    _onFormSubmitted();
                                  // }
                                },
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                backgroundColor: HexColor("fcc535"),
                                label: Text(
                                  isLogin ? "Войти" : 'Создать аккаунт',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        )
                      : BlocProvider<RegisterBloc>(
                          create: (context) => RegisterBloc(userRepository: widget._userRepository),
                          child: Container(
                            // margin: const EdgeInsets.only(top: 230),/
                            child: RegisterForm(),
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChange() {
    _loginBloc.add(LoginEmailChange(email: _emailController.text));
  }

  void _onPasswordChange() {
    _loginBloc.add(LoginPasswordChanged(password: _passwordController.text));
  }

  void _onFormSubmitted() {
    _loginBloc.add(
        LoginWithCredentialsPressed(email: _emailController.text, password: _passwordController.text));
  }
}
