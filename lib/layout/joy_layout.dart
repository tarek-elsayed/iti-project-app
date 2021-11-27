import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jooy/modules/about_us/about_us.dart';
import 'package:jooy/modules/order/order_screen.dart';
import 'package:jooy/shared/components/components.dart';
import 'package:jooy/shared/components/constains.dart';
import 'package:jooy/layout/joy_app/cubit/cubit.dart';
import 'package:jooy/layout/joy_app/cubit/state.dart';

class JoyLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JoyCubit, JoyStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = JoyCubit.get(context);
        return Scaffold(
          drawer: drawer(context),
          appBar: AppBar(
            elevation: 0,
            // backgroundColor: Color(0xffF9F9F9),
            // backgroundColor: Colors.black,
            centerTitle: true,
            title: Text(
              'JOY',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          body: cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            onTap: (index) {
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                backgroundColor: Colors.blue,
                icon: cubit.currentIndex == 0
                    ? Icon(
                  Icons.place,
                  color: cubit.currentIndex == 0
                      ? Colors.white
                      : Colors.black,
                  size: 26,
                )
                    : Icon(
                  Icons.place_outlined,
                  color: cubit.currentIndex == 0
                      ? Colors.white
                      : Colors.black,
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.blue,
                icon: cubit.currentIndex == 1
                    ? Icon(
                  Icons.hotel,
                  color: cubit.currentIndex == 1
                      ? Colors.white
                      : Colors.black,
                  size: 26,
                )
                    : Icon(
                  Icons.hotel_outlined,
                  color: cubit.currentIndex == 1
                      ? Colors.white
                      : Colors.black,
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.blue,
                icon: cubit.currentIndex == 2
                    ? Icon(
                  Icons.restaurant,
                  color: cubit.currentIndex == 2
                      ? Colors.white
                      : Colors.black,
                  size: 28,
                )
                    : Icon(
                  Icons.restaurant_outlined,
                  color: cubit.currentIndex == 2
                      ? Colors.white
                      : Colors.black,
                  size: 28,
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.blue,
                icon: cubit.currentIndex == 3
                    ? Icon(
                  Icons.home,
                  color: cubit.currentIndex == 3
                      ? Colors.white
                      : Colors.black,
                  size: 26,
                )
                    : Icon(
                  Icons.home_outlined,
                  color: cubit.currentIndex == 3
                      ? Colors.white
                      : Colors.black,
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.blue,
                icon: cubit.currentIndex == 4
                    ? Icon(
                  Icons.person,
                  color: cubit.currentIndex == 4
                      ? Colors.white
                      : Colors.black,
                  size: 26,
                )
                    : Icon(
                  Icons.person_outline,
                  color: cubit.currentIndex == 4
                      ? Colors.white
                      : Colors.black,
                ),
                label: "",
              ),
            ],
          ),
        );
      },
    );
  }

  Widget drawer(BuildContext context) {
    var userModel = JoyCubit.get(context).model;
    return Drawer(
        child: Container(
          // padding:EdgeInsets.only(top: 20.0),
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

          padding: EdgeInsets.symmetric(vertical: 120),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.blue,
                  backgroundImage: NetworkImage("${userModel.image}"),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Center(
                  child: Text(
                    '${userModel.name.toUpperCase()}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 26.0,
                    ),
                  ),
                ),
                SizedBox(height: 25.0,),
                ListTile(
                    onTap: (){
                      int value=JoyCubit.get(context).currentIndex=4;
                      JoyCubit.get(context).changeBottom(value);
                      Navigator.pop(context);
                    },
                    leading: Icon(Icons.person),
                    title: Text(
                      "Profile",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
                ListTile(
                    leading: Icon(Icons.favorite),
                    title: Text(
                      "Orders",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      navigateTo(context, OrdersScreen());
                      JoyCubit.get(context).showOrderHotels();
                      JoyCubit.get(context).showOrderRents();
                    }),
                ListTile(
                    onTap: (){
                      navigateTo(context, AboutUS());
                      JoyCubit.get(context).countService();
                      JoyCubit.get(context).countUser();
                    },
                    leading: Icon(Icons.book),
                    title: Text(
                      "About Us",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
                ListTile(
                    onTap: () {
                      signOut(context);
                    },
                    leading: Icon(Icons.logout),
                    title: Text(
                      "logout",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
              ]),
        ));
  }
}
