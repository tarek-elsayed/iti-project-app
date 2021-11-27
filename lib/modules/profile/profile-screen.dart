import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:jooy/layout/joy_app/cubit/cubit.dart';
import 'package:jooy/layout/joy_app/cubit/state.dart';

import 'package:jooy/shared/components/components.dart';
import 'package:jooy/shared/components/constains.dart';

class ProfileScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JoyCubit, JoyStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = JoyCubit.get(context).model;
        var image = JoyCubit.get(context).profileImage;


        emailController.text = model.email;
        nameController.text = model.name;
        phoneController.text = model.phone;

        return ConditionalBuilder(
          condition: JoyCubit.get(context).model != null,
          builder: (context) => Container(
            height: 1000,
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
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0, top: 20),
                          child: Container(
                            height: 180.0,
                            width: 180.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 83,
                                backgroundImage: image == null
                                    ? NetworkImage(model.image)
                                    : FileImage(image),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 125, top: 150),
                          child: CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: IconButton(
                              icon: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 25,
                              ),
                              onPressed: () {
                                JoyCubit.get(context).getImage(
                                    nameController.text,
                                    phoneController.text,
                                    emailController.text);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            color: Colors.grey[500],
                            child: defaultFormField(
                              color: Colors.white,
                              controller: nameController,
                              type: TextInputType.name,
                              validation: (String value) {
                                if (value.isEmpty) {
                                  return 'name must not be empty';
                                }

                                return null;
                              },
                              labelText: 'Name',
                              prefix: Icons.person,
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            color: Colors.grey[500],
                            child: defaultFormField(
                              color: Colors.white,
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validation: (String value) {
                                if (value.isEmpty) {
                                  return 'email must not be empty';
                                }

                                return null;
                              },
                              labelText: 'Email Address',
                              prefix: Icons.email,
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            color: Colors.grey[500],
                            child: defaultFormField(
                              color: Colors.white,
                              controller: phoneController,
                              type: TextInputType.phone,
                              validation: (String value) {
                                if (value.isEmpty) {
                                  return 'phone must not be empty';
                                }

                                return null;
                              },
                              labelText: 'Phone',
                              prefix: Icons.phone,
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultButton(
                            width: 230,
                            radius: 10,
                            function: () {
                              if (formKey.currentState.validate()) {
                                JoyCubit.get(context).updateUserDate(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                );
                              }
                            },
                            text: 'update',
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultButton(
                            width: 190,
                            radius: 10,
                            function: () {
                              signOut(context);
                            },
                            text: 'Logout',
                          ),
                          SizedBox(height: 20.0,),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
/*
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = JoyCubit.get(context).model;
    return BlocConsumer<JoyCubit, JoyStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
// appBar:
// AppBar(
//   elevation: 0,
//   backgroundColor: Color(0xffFAFAFA),
//   actions: [
//     Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Icon(
//         Icons.settings,
//         color: Colors.blueAccent,
//       ),
//     )
//   ],
// ),
            body: Container(
                width: double.infinity,
//double.infinity ,
                height: double.infinity,
// MediaQuery.of(context).size.height,

                decoration: BoxDecoration(
// image: DecorationImage(
//   image: AssetImage("assets/1.jpg"),
//   fit: BoxFit.fill,
// )
                    ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.settings,
                              color: Colors.blueAccent,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: 80,
                            backgroundImage: NetworkImage("${user.image}"),
                            ),
                          ),

                          SizedBox(
                            height: 50,
                          ),
                        // Container(height: 10,),
                          showInfo(
                            title: "Name : ",
                            subTitle: "${user.name}",
                          ),

                          showInfo(
                            title: "Phone Number : ",
                            subTitle: "${user.phone}",
                          ),
                          // SizedBox(height: 40,),
                          showInfo(
                            title: "Email :  ",
                            subTitle: "${user.email}",
                          ),
                      SizedBox(height: 40,),
                          RaisedButton(
                            child: Text("Sign out"),
                            onPressed: (){
                              signOut(context);
                            },
                          )
                        ],
                      )
                    ],
                  ),
                )));
      },
    );
  }
}

Widget showInfo({String title, String subTitle}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20.0),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.indigoAccent, borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
              color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subTitle,
            style: TextStyle(
              color: Colors.white60,
              fontSize: 18,
            )),
      ),
    ),
  );
}


 // Container(
                      //   padding: EdgeInsets.all(10.0),
                      //   width: MediaQuery.of(context).size.width / 2,
                      //   height: MediaQuery.of(context).size.height / 2,
                      //   decoration: BoxDecoration(
                      //     border: Border.all(color: Colors.white, width: 5),
                      //     shape: BoxShape.circle,
                      //     color: Colors.white,
                      //     image: DecorationImage(
                      //       image: NetworkImage(
                      //         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTjzMzuQcaLm52XRb-od5xmOIPCHUk1Mc3B_R6fgLW6-wSu6s5DBa6NXIHXQy49ff6KHk&usqp=CAU",
                      //       ),
                      //       fit: BoxFit.cover,
                      //     ),
                      //   ),
                      // ),

*/
