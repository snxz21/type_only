import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import '../user_repository.dart';

part 'user_event.dart';

part 'user_state.dart';

part 'user_model.dart';

part 'user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitialState());
  SingleUserRepository _singleUserRepository = SingleFirebaseUserRepository() as SingleUserRepository;
  UserRepository _userRepository = UserRepository();
  StreamSubscription _todosSubscription;

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UserLoadingEvent) {
      try {
        yield* _mapLoadTodosToState();
      } catch (_) {
        yield UserOnErrorState();
      }
    } else if (event is UserLoadedEvent) {
      yield* _mapTodosUpdateToState(event);
    }
  }

  Stream<UserState> _mapLoadTodosToState() async* {
    var user = await _userRepository.getUser();



    _todosSubscription?.cancel();
    _todosSubscription = _singleUserRepository.getUserInfo(user.uid).listen(
          (data) => add(UserLoadedEvent(data)),
        );
  }

  Stream<UserState> _mapTodosUpdateToState(UserLoadedEvent event) async* {
    yield UserLoadedState(
      event.userData,
    );
  }
}
