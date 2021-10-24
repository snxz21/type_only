part of 'user_bloc.dart';

@immutable
abstract class UserEvent {
  const UserEvent();
}

class UserLoadingEvent extends UserEvent {
  const UserLoadingEvent();
}

class UserLoadedEvent extends UserEvent {
  final UserModel userData;

  const UserLoadedEvent(this.userData);
}

class UserCompleteTaskEvent extends UserEvent {
  final String way;
  final UserModel uid;

  const UserCompleteTaskEvent(this.way, this.uid);
}

class UserAddTransactionEvent extends UserEvent {
  final String date;
  final String token;
  final String orderStatus;
  final UserModel uid;

  const UserAddTransactionEvent(this.date, this.token,this.orderStatus, this.uid);
}
