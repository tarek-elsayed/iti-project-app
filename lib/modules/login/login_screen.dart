import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jooy/layout/joy_app/cubit/cubit.dart';
import 'package:jooy/layout/joy_layout.dart';
import 'package:jooy/modules/login/cubit/cubit.dart';
import 'package:jooy/modules/login/cubit/states.dart';
import 'package:jooy/modules/register/register_screen.dart';
import 'package:jooy/shared/components/components.dart';
import 'package:jooy/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  var email = TextEditingController();
  var password = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => JoyLoginCubit(),
      child: BlocConsumer<JoyLoginCubit, JoyLoginStates>(
        listener: (context, state) {
          if (state is JoyLoginErrorState) {
            showToast(text: state.error, state: ToastState.ERROR);
          }
          if (state is JoyLoginSuccessState) {
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) {
              navigateAndFinish(context, JoyLayout());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(

            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.grey.shade400,
                    Colors.blue,
                    Colors.blue.shade900,
                  ],
                ),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN',
                            style: Theme.of(context).textTheme.headline3.copyWith(
                                  color: Colors.black,
                                ),
                          ),
                          Text(
                            'Login now to browse our hot offers',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                                ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                            color: Colors.white,
                            controller: email,
                            type: TextInputType.emailAddress,
                            validation: (String value) {
                              if (value.isEmpty) {
                                return "Please enter your email";
                              }
                            },
                            labelText: "Email Address",
                            prefix: Icons.email_outlined,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          defaultFormField(
                            color: Colors.white,
                            controller: password,
                            type: TextInputType.visiblePassword,
                            validation: (String value) {
                              if (value.isEmpty) {
                                return "Please enter your password";
                              }
                            },
                            suffixIcon: Icons.visibility,
                            onSubmit: (value) {
                              if (formKey.currentState.validate()) {
                                JoyLoginCubit.get(context).userLogin(
                                  email: email.text,
                                  password: password.text,
                                  context: context,
                                );
                                JoyCubit()
                                  ..getUserData()
                                  ..getAllHotel()
                                  ..getAllRestaurant();
                              }
                            },
                            obscureText:
                                JoyLoginCubit.get(context).isPasswordShown,
                            suffixIconPress: () {
                              JoyLoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            labelText: "Password",
                            prefix: Icons.lock_outline,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          ConditionalBuilder(
                            condition: state is! JoyLoginLoadingState,
                            builder: (context) => defaultButton(
                              text: "Login",
                              function: () {
                                if (formKey.currentState.validate()) {
                                  JoyLoginCubit.get(context).userLogin(
                                    email: email.text,
                                    password: password.text,
                                    context: context
                                  );
                                  JoyCubit.get(context)..getUserData();
                                }
                              },
                              isUpperCase: true,
                            ),
                            fallback: (context) => Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account?',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              defaultTextButton(
                                function: () {
                                  navigateTo(context, RegisterScreen());
                                },
                                text: 'Sign Up',
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
