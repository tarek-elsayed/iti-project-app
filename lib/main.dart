import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jooy/layout/joy_app/cubit/cubit.dart';
import 'package:jooy/layout/joy_app/cubit/state.dart';
import 'package:jooy/modules/splash_screen/splash_screen.dart';
import 'package:jooy/shared/bloc_observer.dart';
import 'package:jooy/shared/components/constains.dart';
import 'package:jooy/shared/network/local/cache_helper.dart';
import 'package:jooy/shared/network/remote/dio_helper.dart';
import 'modules/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;
  bool isDark = CacheHelper.getData(key: 'isDark');
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  uId = CacheHelper.getData(key: 'uId');

  // if (onBoarding != null) {
  //   if (token != null) {
  //     widget=JoyLayout();
  //   } else widget = LoginScreen();
  // } else
  //   widget = OnBoardingScreen();
  if(uId !=null){
    widget=SplashScreen();
  }
  else{
    widget= LoginScreen();
  }
  runApp(MyApp(

    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;

  MyApp({this.isDark, this.startWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JoyCubit()..getUserData()..getAllHotel()
        ..getAllRestaurant()..getAllPlaces()..getAllRents()..countService()..getAllUsers(),
      child: BlocConsumer<JoyCubit,JoyStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(

            // themeMode:
            //     AppCubit.get(context).isDark ? ThemeMode.light : ThemeMode.dark,
            // theme: lightTheme,
            // darkTheme: darkTheme,
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },
      ),
    );
  }
}
