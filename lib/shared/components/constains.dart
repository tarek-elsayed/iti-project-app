
import 'package:flutter/material.dart';
import 'package:jooy/layout/joy_app/cubit/cubit.dart';
import 'package:jooy/modules/login/login_screen.dart';
import 'package:jooy/shared/network/local/cache_helper.dart';

import 'components.dart';

void signOut(context) {
  JoyCubit.get(context).currentIndex=0;
  CacheHelper.removeData(
    key: "uId",
  ).then((value) {
    if (value) {
      navigateAndFinish(context,LoginScreen());
    }
  });
}
// bool serialNum=false;
String serialNum;
var random;
String uId = '';
String HotelID = '';
String RestID = '';
String RentID = '';
int tarek;
int countServices=0;
int countUsers=0;

bool disableRest=false;
String bookRest='Book Now';
Color colorRest=Colors.white;

bool disableHotels=false;
String bookHotels='Book Now';
Color colorHotels=Colors.white;

bool disableRent=false;
String bookRent='Book Now';
Color colorRent=Colors.white;