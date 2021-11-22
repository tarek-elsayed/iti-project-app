import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jooy/layout/joy_app/cubit/cubit.dart';
import 'package:jooy/layout/joy_layout.dart';
import 'package:jooy/modules/login/cubit/states.dart';
import 'package:jooy/shared/components/components.dart';
import 'package:jooy/shared/components/constains.dart';

class JoyLoginCubit extends Cubit<JoyLoginStates> {
  JoyLoginCubit() : super(JoyLoginInitialState());

  static JoyLoginCubit get(context) => BlocProvider.of(context);

  void userLogin( {
    BuildContext context,
    @required String email,
    @required String password,
  }) {
    emit(JoyLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then((value) => {
              emit(JoyLoginSuccessState(value.user.uid)),
              print(value.user.email),
              print(value.user.uid),
              uId = value.user.uid,
              JoyCubit()
                // ..getUserData()
                ..getAllHotel()
                ..getAllRestaurant()..getAllRents()..getAllPlaces()..getUserData(),
                // navigateTo(context, JoyLayout()),
            })
        .catchError((error) => {
              emit(JoyLoginErrorState(error.toString())),
            });
  }

  IconData suffix = Icons.visibility;
  bool isPasswordShown = true;

  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown==false ? Icons.visibility :Icons.visibility_off ;
    emit(JoyChangePasswordVisibilityState());
  }
}
