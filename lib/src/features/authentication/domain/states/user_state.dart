import '../models/user.dart';

sealed class UserState {}

class UserInitial extends UserState {}

class UserUnauthenticated extends UserState {}

class UserAuthenticated extends UserState {
  UserAuthenticated(this.user);
  final UserModel user;
}
