import 'dart:developer';

import 'package:chat_app/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(AuthInitial());

  static UserCubit get(context) => BlocProvider.of(context);

  void login(
      {required String email, required String password, required BuildContext context}) async {
    final authService = AuthService();
    emit(UserLoginLoading());

    await authService.signInWithEmailPassword(email: email, password: password).then((response) {
      log("response is $response");
      emit(UserLoginSuccess());
    }).catchError((onError, trace) {
      emit(UserLoginError(error: onError.toString()));
    });
  }

  void register(
      {required String email, required String password, required BuildContext context}) async {
    final authService = AuthService();
    try {
      await authService.signUpWithEmailPassword(email: email, password: password);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(e.toString()),
          );
        },
      );
    }
  }
}
