import 'package:chat_app/auth/bloc/user_cubit.dart';
import 'package:chat_app/auth/screens/home_screen.dart';
import 'package:chat_app/auth/screens/register_screen.dart';
import 'package:chat_app/core/theme/theme_provider.dart';
import 'package:chat_app/core/utils/app_styles.dart';
import 'package:chat_app/core/utils/colors.dart';
import 'package:chat_app/core/widgets/form_filed_widget.dart';
import 'package:chat_app/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                  },
                  icon: Provider.of<ThemeProvider>(context, listen: false).isDarkMode
                      ? const Icon(Icons.light_mode, color: kButtonsColor)
                      : const Icon(Icons.dark_mode, color: kButtonsColor),
                ),
              ],
            ),
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: Container(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 40),
                    Text(
                      "Login",
                      style: AppStyles.primary20Bold.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
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
                    const SizedBox(height: 20),
                    PrimaryButton(
                      isLoading: state is UserLoginLoading,
                      title: "Login",
                      onPressed: () {
                        userCubit.login(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    /* --------------------------- Don't have account --------------------------- */
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "don't have account? ",
                          style: AppStyles.hintStyle,
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            Get.to(() => const RegisterScreen());
                          },
                          child: Text(
                            "SignUp",
                            style: AppStyles.subtitleBlack12Regular.copyWith(
                              fontWeight: FontWeight.w600,
                              color: HexColor.fromHex("#3F6E8C"),
                            ),
                          ),
                        ),
                      ],
                    )
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
