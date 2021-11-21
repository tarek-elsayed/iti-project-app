import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jooy/layout/joy_layout.dart';
import 'package:jooy/modules/register/cubit/cubit.dart';
import 'package:jooy/shared/components/components.dart';

import 'cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  var email = TextEditingController();
  var password = TextEditingController();
  var confirmPassword = TextEditingController();
  var name = TextEditingController();
  var phone = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context)=>JoyRegisterCubit(),
      child: BlocConsumer<JoyRegisterCubit,JoyRegisterStates>(
        listener: (context,state){
          if (state is JoyCreateUserSuccessState) {
            navigateAndFinish(context, JoyLayout());
          }
        },
        builder: (context,state){
          return Scaffold(

            body:  Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline3.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.blueGrey,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          controller: name,
                          type: TextInputType.name,
                          validation: (String value) {
                            if (value.isEmpty) {
                              return "Please enter your name";
                            }
                          },
                          labelText: "User Name",
                          prefix: Icons.person,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          controller: phone,
                          type: TextInputType.phone,
                          validation: (String value) {
                            if (value.isEmpty) {
                              return "Please enter your phone";
                            }
                          },
                          labelText: "Phone",
                          prefix: Icons.phone_android,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
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
                          controller: password,
                          type: TextInputType.visiblePassword,
                          validation: (String value) {
                            if (value.isEmpty) {
                              return "Please enter your password";
                            }
                          },
                          suffixIcon: Icons.visibility,
                          onSubmit: (value) {

                          },
                          obscureText:
                          JoyRegisterCubit.get(context).isPasswordShown,
                          suffixIconPress: () {
                            JoyRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          labelText: "Password",
                          prefix: Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: confirmPassword,
                          type: TextInputType.visiblePassword,
                          validation: (String value) {
                            if (value.isEmpty) {
                              return "Please enter your password";
                            }
                            if(password.text!=confirmPassword.text){
                              return "your password is not matched";
                            }
                          },
                          suffixIcon: Icons.visibility,
                          onSubmit: (value) {

                          },
                          obscureText:
                          JoyRegisterCubit.get(context).isPasswordShown,
                          suffixIconPress: () {
                            JoyRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          labelText: "Confirm Password",
                          prefix: Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! JoyRegisterLoadingState,
                          builder: (context) => defaultButton(
                            text: "register",
                            function: () {
                              if (formKey.currentState.validate()) {
                                JoyRegisterCubit.get(context).userRegister(
                                  email: email.text,
                                  password: password.text,
                                  name: name.text,
                                  phone: phone.text,
                                );

                              }
                            },
                            isUpperCase: true,
                          ),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      )
    );
  }
}
