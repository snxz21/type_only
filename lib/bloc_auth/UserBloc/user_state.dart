part of 'user_bloc.dart';

@immutable
abstract class UserState {
  const UserState();
}

class UserInitialState extends UserState {}

class UserLoadedState extends UserState {
  final UserModel userData;

  const UserLoadedState(this.userData);
}

class UserOnErrorState extends UserState {}
