import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musically/presentation/bloc/authentication/login/login_bloc.dart';
import 'package:musically/presentation/bloc/authentication/login/login_event.dart';
import 'package:musically/presentation/bloc/authentication/login/login_state.dart';
import 'package:musically/presentation/screeens/authentication/signup_page.dart';
import 'package:musically/presentation/screeens/homepage.dart';
import 'package:musically/presentation/screeens/jumping_icon.dart';
import 'package:musically/presentation/screeens/songs_upload_screen.dart';

import 'package:musically/presentation/widgets/custom_elevated_button.dart';
import 'package:musically/presentation/widgets/custom_text.dart';
import 'package:musically/presentation/widgets/custome_snackbar.dart';
import 'package:musically/presentation/widgets/custometextformfield.dart';
import 'package:musically/presentation/widgets/validations%20copy.dart';
import 'package:musically/utilities/constants/constants.dart';

import 'package:shared_preferences/shared_preferences.dart';







class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
          body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            customSnackbar(context, 'Logged In Successfully', green);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return Homepage();
            }));
          } else if (state is LoginErrorState) {
            customSnackbar(context, state.error, red);
          }
        },
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    h100,
                    h50,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            JumpingIcon(
                              iconsdata: Icon(
                                Icons.music_note,
                                size: 60,
                              ),
                            ),
                          ],
                        ),
                        h50,

                        CustomTextFormField(
                          labelText: 'Email',
                          hintText: 'Enter your email address',
                          icon: Icons.email_outlined,
                          controller: _emailController,
                          validator: validateEmail,
                        ),
                        h20,

                        CustomTextFormField(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          icon: Icons.lock,
                          controller: _passwordController,
                          obscureText: true,
                          validator: validatePassword,
                        ),
                        h20,
                      ],
                    ),
                    h20,
                    BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                      if (state is LoginLoadingState) {
                        return const CircularProgressIndicator();
                      }
                      return CustomGradientButton(
                        text: 'Log in',
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            context.read<LoginBloc>().add(UserLoginEvent(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                ));
                          }
                        },
                        width: 250,
                        height: 60,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        gradientColors: const [Colors.blue, Colors.purple],
                      );
                    }),
                    const SizedBox(height: 20),
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        if (state is GoogleLoginLoadingState) {
                          return const CircularProgressIndicator();
                        }
                        return GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/g_logo.png',
                                width: 0.12.sw,
                                height: 0.07.sh,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                width: 0.02.sw,
                              ),
                              const Text("Sign in with Google"),
                            ],
                          ),
                          onTap: () async {
                            context
                                .read<LoginBloc>()
                                .add(UserGoogleLoginEvent());

                            print("google button pressed");
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CustomText(
                          text: "Don't have an account? ",
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                        const SizedBox(width: 5),
                        CustomText(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()),
                            );
                          },
                          text: "Sign up",
                          fontSize: 20,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }

  void saveUserLoginStatus(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool('isLoggedIn', isLoggedIn);
  }
}
