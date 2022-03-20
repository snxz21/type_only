
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:editing_check/bloc_auth/register_bloc/register_event.dart';
import 'package:editing_check/bloc_auth/register_bloc/register_state.dart';

import '../user_repository.dart';
import '../validators.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc({UserRepository userRepository})
      : _userRepository = userRepository,
        super(RegisterState.initial());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterEmailChanged) {
      yield* _mapRegisterEmailChangeToState(event.email);
    } else if (event is RegisterPasswordChanged) {
      yield* _mapRegisterPasswordChangeToState(event.password);
    } else if (event is RegisterSubmitted) {
      yield* _mapRegisterSubmittedToState(
          email: event.email, password: event.password, name: event.name, phone: event.phone);
    }
  }

  Stream<RegisterState> _mapRegisterEmailChangeToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<RegisterState> _mapRegisterPasswordChangeToState(String password) async* {
    yield state.update(isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<RegisterState> _mapRegisterSubmittedToState({
    String email,
    String password,
    String name,
    String phone,
  }) async* {
    yield RegisterState.loading();
    try {
      await _userRepository.signUp(email: email, password: password, firstName: "", lastName: "", userStatus: "");
      // await _userRepository.signUp(email, password, name, phone);
      yield RegisterState.success();
    } catch (error) {
      print(error);
      yield RegisterState.failure();
    }
  }
}
