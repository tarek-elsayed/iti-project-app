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

          // drawer: Drawer(),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color(0xffF9F9F9),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Color(0xffF9F9F9),
              ),
              onPressed: () {},
            ),
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
}

/*
BlocConsumer<JoyCubit, JoyStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              "Joy",
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: ConditionalBuilder(
            condition: JoyCubit.get(context).model != null,
            builder: (context) {
              var model = JoyCubit.get(context).model;
              return Column(
                children: [
                  if (!model.isEmailVerified)
                    Container(
                      color: Colors.amber.withOpacity(.9),
                      height: 50.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Text(
                                "Please verify email",
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            defaultTextButton(
                              text: "send",
                              function: () {
                                FirebaseAuth.instance.currentUser
                                    .sendEmailVerification()
                                    .then((value) {
                                  showToast(
                                    text: "check your mail",
                                    state: ToastState.SUCCESS,
                                  );
                                }).catchError((error) {});
                              },
                            )
                          ],
                        ),
                      ),
                    )
                ],
              );
            },
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
 */
