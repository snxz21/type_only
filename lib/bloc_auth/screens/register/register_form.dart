import 'package:hexcolor/hexcolor.dart';
// import 'package:logopediya174/blocs/authentication_bloc/authentication_bloc.dart';
// import 'package:logopediya174/blocs/authentication_bloc/authentication_event.dart';
// import 'package:logopediya174/blocs/register_bloc/register_bloc.dart';
// import 'package:logopediya174/blocs/register_bloc/register_event.dart';
// import 'package:logopediya174/blocs/register_bloc/register_state.dart';
// import 'package:logopediya174/repositories/user_repository.dart';
// import 'package:logopediya174/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:editing_check/bloc_auth/authentication_bloc/authentication_bloc.dart';
import 'package:editing_check/bloc_auth/register_bloc/register_bloc.dart';
import 'package:editing_check/bloc_auth/register_bloc/register_event.dart';
import 'package:editing_check/bloc_auth/register_bloc/register_state.dart';
import 'package:editing_check/bloc_auth/screens/login/login_screen.dart';

import '../../user_repository.dart';

class RegisterForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  RegisterBloc _registerBloc;

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChange);
    _passwordController.addListener(_onPasswordChange);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
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
                    Text('Register Failure'),
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
                    Text('Registering...'),
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
          // qwe();
          // FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
          // Future.delayed(Duration(seconds: 1), () {
          //   _firebaseFirestore.collection("users").doc(uid).set({
          //     "isPayment": false,
          //     "email": _emailController,
          //     "name": _nameController,
          //     "phone": _phoneController,
          //   });
          // });

          Navigator.pop(context);
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 56,
                    child: TextField(
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            color: Colors.grey[800], fontSize: 25),
                        decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(15.0),
                              ),
                            ),
                            filled: true,
                            hintStyle: new TextStyle(
                                color: Colors.grey[800], fontSize: 25),
                            hintText: "Name",
                            fillColor: Colors.white70),
                        controller: _nameController),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 56,
                    child: TextField(
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            color: Colors.grey[800], fontSize: 25),
                        decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(15.0),
                              ),
                            ),
                            filled: true,
                            hintStyle: new TextStyle(
                                color: Colors.grey[800], fontSize: 25),
                            hintText: "Номер телефона",
                            fillColor: Colors.white70),
                        controller: _phoneController),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: state.isEmailValid ? 56 : 80,
                    child: TextFormField(
                      controller: _emailController,
                      textAlign: TextAlign.center,
                      style:
                          new TextStyle(color: Colors.grey[800], fontSize: 25),
                      decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(15.0),
                          ),
                        ),
                        filled: true,
                        hintStyle: new TextStyle(
                            color: Colors.grey[800], fontSize: 25),
                        hintText: "E-mail",
                        fillColor: Colors.white70,
                        // counterText: "",
                        // counterStyle: TextStyle(fontSize: 0)
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.always,
                      autocorrect: false,
                      validator: (_) {
                        return !state.isEmailValid ? 'Incorrect email' : null;
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
                      style:
                          new TextStyle(color: Colors.grey[800], fontSize: 25),
                      decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(15.0),
                            ),
                          ),
                          filled: true,
                          hintStyle: new TextStyle(
                              color: Colors.grey[800], fontSize: 25),
                          hintText: "Password",
                          fillColor: Colors.white70),
                      obscureText: true,
                      // autovalidate: true,
                      autocorrect: false,
                      validator: (_) {
                        return !state.isPasswordValid
                            ? 'Incorrect Password'
                            : null;
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
                        if (isButtonEnabled(state)) {
                          _onFormSubmitted();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return LoginScreen(
                              userRepository: UserRepository(),
                            );
                          }));
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      backgroundColor: HexColor("fcc535"),
                      label: Text(
                        'Create Account',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
                      ),
                      heroTag: "ascvdsdbsdbfbsfh",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onEmailChange() {
    _registerBloc.add(RegisterEmailChanged(email: _emailController.text));
  }

  void _onPasswordChange() {
    _registerBloc
        .add(RegisterPasswordChanged(password: _passwordController.text));
  }

  void _onFormSubmitted() {
    _registerBloc.add(RegisterSubmitted(
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
      phone: _phoneController.text,
    ));
  }
}
