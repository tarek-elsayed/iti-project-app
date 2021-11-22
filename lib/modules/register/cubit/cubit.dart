import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jooy/layout/joy_app/cubit/cubit.dart';
import 'package:jooy/models/user_model.dart';
import 'package:jooy/modules/register/cubit/states.dart';
import 'package:jooy/shared/components/constains.dart';

class JoyRegisterCubit extends Cubit<JoyRegisterStates> {
  JoyRegisterCubit() : super(JoyRegisterInitialState());

  static JoyRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    @required String email,
    @required String password,
    @required String name,
    @required String phone,
  }) {
    print(email);
    emit(JoyRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then((value) => {
              userCreate(
                email: email,
                name: name,
                phone: phone,
                uId: value.user.uid,
              ),
      print(value.user.email),
      uId=value.user.uid,
            })
        .catchError((error) => {
              emit(JoyRegisterErrorState(error.toString())),
            });
  }

  void userCreate({
    @required String email,
    @required String name,
    @required String phone,
    @required String uId,
  }) {
    UserModel userModel = UserModel(
      email: email,
      name: name,
      phone: phone,
      image: "https://firebasestorage.googleapis.com/v0/b/jooy-dadba.appspot.com/o/Users%2F9127a595d3a3421d984edc45230f6d9a.jpg?alt=media&token=49962e6b-d77f-4088-b3b0-3ae345036cc9",
      uId: uId,
      isEmailVerified: false,
      barcodes: []
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value){

      emit(JoyCreateUserSuccessState(uId));
      JoyCubit()
      // ..getUserData()
        ..getAllHotel()
        ..getAllRestaurant()..getAllRents()..getAllPlaces()..getUserData();
      // navigateTo(context, JoyLayout()),
    }).catchError((error) {
      emit(JoyRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility;
  bool isPasswordShown = true;

  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown ? Icons.visibility_off : Icons.visibility;
    emit(JoyChangePasswordRegisterVisibilityState());
  }
}
