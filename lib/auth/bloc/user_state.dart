part of 'user_cubit.dart';

abstract class UserState {}

class AuthInitial extends UserState {}

class ToggleViewPassword extends UserState {}

class UserLoginLoading extends UserState {}

class UserLoginSuccess extends UserState {}

class UserLoginError extends UserState {
  final String error;

  UserLoginError({required this.error});
}
