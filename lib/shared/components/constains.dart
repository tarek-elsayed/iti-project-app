
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
bool serialNum=false;
var random;
String uId = '';
