import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:musically/data/models/user_data_model.dart';
import 'package:musically/presentation/bloc/authentication/signup/signup_bloc.dart';
import 'package:musically/presentation/screeens/authentication/login_page.dart';

import 'package:musically/presentation/widgets/custom_elevated_button.dart';
import 'package:musically/presentation/widgets/custometextformfield.dart';
import 'package:musically/presentation/widgets/validations%20copy.dart';
import 'package:musically/utilities/constants/constants.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _UserNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(),
      child: BlocConsumer<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is SignupLoadingState) {
            isLoading = true;
          } else if (state is SignupSuccessState) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
            );
          } else if (state is SignupErrorState) {
            isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Signup failed: ${state.error}')),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                Positioned(
                    bottom: -5,
                    left: 50,
                    child: Opacity(
                        opacity: 0.3,
                        child: Lottie.asset('assets/animation/music.json',
                            fit: BoxFit.cover))),
                Positioned(
                  top: 40,
                  right: 100,
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                        'Musically',
                        textStyle: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()
                            ..shader = LinearGradient(
                              colors: [Colors.blue, Colors.purple],
                            ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
                        ),
                        speed: Duration(milliseconds: 300),
                      ),
                    ],
                    totalRepeatCount: 1,
                    pause: Duration(milliseconds: 1000),
                  ),
                ),
                Positioned(
                  top: 110,
                  right: 100,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Get into the world of music',
                      style: TextStyle(
                        fontSize: 16,

                        fontWeight: FontWeight.normal,

                        color: Colors
                            .white, // You can change this to any color you like
                      ),
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (state is SignupLoadingState)
                          const CircularProgressIndicator(),
                        if (state is SignupErrorState)
                          Text('Error: ${state.error}',
                              style: const TextStyle(color: Colors.red)),
                        // TextFormField(
                        //   decoration: const InputDecoration(labelText: 'User Name'),
                        //   controller: _shopNameController,
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please enter your User name';
                        //     }
                        //     return null;
                        //   },
                        // ),
                        h20,

                        CustomTextFormField(
                          labelText: 'Username',
                          icon: Icons.person_outline,
                          controller: _UserNameController,
                          validator: validateUsername,
                        ),
                        h20,
                        CustomTextFormField(
                          labelText: 'Email',
                          hintText: 'Enter your email address',
                          icon: Icons.email_outlined,
                          controller: _emailController,
                          validator: validateEmail,
                        ),
                        h20,
                        CustomTextFormField(
                          labelText: 'Phone Number',
                          hintText: 'Enter your Phone Number',
                          icon: Icons.phone_android,
                          controller: _phonenumberController,
                          validator: validateMobileNumber,
                          keyboardType: TextInputType.phone,
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

                        CustomTextFormField(
                          labelText: 'Confirm password',
                          hintText: 'Enter your password',
                          icon: Icons.lock,
                          controller: _confirmPasswordController,
                          obscureText: true,
                        ),

                        // TextFormField(
                        //   decoration: const InputDecoration(labelText: 'Email'),
                        //   controller: _emailController,
                        //   keyboardType: TextInputType.emailAddress,
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please enter your email';
                        //     }
                        //     if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        //       return 'Please enter a valid email';
                        //     }
                        //     return null;
                        //   },
                        // ),

                        // TextFormField(
                        //   decoration: const InputDecoration(labelText: 'Phone'),
                        //   keyboardType: TextInputType.phone,
                        //   controller: _phonenumberController,
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please enter your phone number';
                        //     }
                        //     if (!RegExp(r'^\+?\d{10,15}$').hasMatch(value)) {
                        //       return 'Please enter a valid phone number';
                        //     }
                        //     return null;
                        //   },
                        // ),

                        // TextFormField(
                        //   decoration: const InputDecoration(labelText: 'Password'),
                        //   controller: _passwordController,
                        //   obscureText: true,
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please enter your password';
                        //     }
                        //     if (value.length < 6) {
                        //       return 'Password must be at least 6 characters long';
                        //     }
                        //     return null;
                        //   },
                        // ),

                        // TextFormField(
                        //   decoration:
                        //       const InputDecoration(labelText: 'Confirm Password'),
                        //   controller: _confirmPasswordController,
                        //   obscureText: true,
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please confirm your password';
                        //     }
                        //     if (value != _passwordController.text) {
                        //       return 'Passwords do not match';
                        //     }
                        //     return null;
                        //   },
                        // ),

                        h20,
                        CustomGradientButton(
                          text: isLoading ? 'Waiting' : 'Sign up',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              UserModel model = UserModel(
                                username: _UserNameController.text,
                                email: _emailController.text,
                                password: _passwordController.text,
                                phonenumber: _phonenumberController.text,
                              );
                              context
                                  .read<SignupBloc>()
                                  .add(UserSignupEvent(userModel: model));
                            }
                          },
                          width: 250,
                          height: 60,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          gradientColors: const [Colors.blue, Colors.purple],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
