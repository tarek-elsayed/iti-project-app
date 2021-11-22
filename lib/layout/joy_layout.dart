import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          drawer: drawer(),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color(0xffF9F9F9),

            centerTitle: true,
            title: Text(
              'JOY',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.w500,
                color: Colors.black,
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
                backgroundColor: Colors.white,
                icon: cubit.currentIndex == 0?
                Icon(
                  Icons.place,
                  color:
                      cubit.currentIndex == 0 ? Colors.blue[900] : Colors.black,
                  size: 26,
                ): Icon(
                  Icons.place_outlined,
                  color:
                  cubit.currentIndex == 0 ? Colors.blue[900] : Colors.black,
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: cubit.currentIndex == 1?
                Icon(
                  Icons.hotel,
                  color:
                  cubit.currentIndex == 1 ? Colors.blue[900] : Colors.black,
                  size: 26,
                ): Icon(
                  Icons.hotel_outlined,
                  color:
                  cubit.currentIndex == 1 ? Colors.blue[900] : Colors.black,
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: cubit.currentIndex == 2?
                Icon(
                  Icons.restaurant,
                  color:
                  cubit.currentIndex == 2 ? Colors.blue[900] : Colors.black,
                  size: 28,
                ): Icon(
                  Icons.restaurant_outlined,
                  color:
                  cubit.currentIndex == 2 ? Colors.blue[900] : Colors.black,
                  size: 28,
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: cubit.currentIndex == 3?
                Icon(
                  Icons.home,
                  color:
                  cubit.currentIndex == 3 ? Colors.blue[900] : Colors.black,
                  size: 26,
                ): Icon(
                  Icons.home_outlined,
                  color:
                  cubit.currentIndex == 3 ? Colors.blue[900] : Colors.black,
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: cubit.currentIndex == 4?
                Icon(
                  Icons.person,
                  color:
                  cubit.currentIndex == 4 ? Colors.blue[900] : Colors.black,
                  size: 26,
                ): Icon(
                  Icons.person_outline,
                  color:
                  cubit.currentIndex == 4 ? Colors.blue[900] : Colors.black,
                ),
                label: "",
              ),
            ],
          ),
        );
      },
    );
  }

  Widget drawer(){
    return Drawer(
      child:Container(
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


      padding: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.brown,
              // backgroundImage: AssetImage(''),
            ),
            ListTile(
                leading: Icon(Icons.home),
                title: Text(
                  "home page",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )),

            ListTile(
                leading: Icon(Icons.home),
                title: Text(
                  "setting",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )),
            ListTile(
                leading: Icon(Icons.home),
                title: Text(
                  "About",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )),
            ListTile(
                leading: Icon(Icons.home),
                title: Text(
                  "logout",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )),
          ]),
      )
    );
  }
}

