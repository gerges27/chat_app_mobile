import 'package:chat_app/auth/bloc/user_cubit.dart';
import 'package:chat_app/auth/screens/home_screen.dart';
import 'package:chat_app/core/utils/app_styles.dart';
import 'package:chat_app/core/widgets/form_filed_widget.dart';
import 'package:chat_app/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(),
      child: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserLoginSuccess) {
            Get.offAll(() => const HomeScreen());
          }
          if (state is UserLoginError) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(state.error),
                );
              },
            );
          }
        },
        builder: (context, state) {
          UserCubit userCubit = UserCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: Container(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 40),
                    Text(
                      "SignUp",
                      style: AppStyles.primary20Bold
                          .copyWith(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    FormFiledWidget(
                      label: "Email",
                      hintText: "jonSmith@gmail.com",
                      controller: emailController,
                    ),
                    const SizedBox(height: 15),
                    FormFiledWidget(
                      isMandatory: true,
                      isPassword: true,
                      label: "password",
                      hintText: "**********",
                      controller: passwordController,
                    ),
                    const SizedBox(height: 15),
                    FormFiledWidget(
                      isMandatory: true,
                      isPassword: true,
                      label: "password-confirm",
                      hintText: "**********",
                      controller: passwordConfirmController,
                    ),
                    const SizedBox(height: 20),
                    PrimaryButton(
                      isLoading: state is UserLoginLoading,
                      title: "Sign Up",
                      onPressed: () {
                        if (passwordController.text == passwordConfirmController.text) {
                          userCubit.register(
                            email: emailController.text,
                            password: passwordController.text,
                            passwordConfirm: passwordConfirmController.text,
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                title: Text("passwords don't match"),
                              );
                            },
                          );
                        }
                      },
                    ),
                    // const SizedBox(height: 20),
                    /* --------------------------- Don't have account --------------------------- */
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       "don't have account? ",
                    //       style: AppStyles.hintStyle,
                    //     ),
                    //     const SizedBox(width: 10),
                    //     InkWell(
                    //       onTap: () {},
                    //       child: Text(
                    //         "SignUp",
                    //         style: AppStyles.subtitleBlack12Regular.copyWith(
                    //           fontWeight: FontWeight.w600,
                    //           color: HexColor.fromHex("#3F6E8C"),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
