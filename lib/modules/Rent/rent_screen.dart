
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jooy/layout/joy_app/cubit/cubit.dart';
import 'package:jooy/layout/joy_app/cubit/state.dart';
import 'package:jooy/models/rent_model.dart';
import 'package:jooy/shared/components/constains.dart';

class RentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var rent = JoyCubit.get(context).rent;
    return Scaffold(
        body: BlocConsumer<JoyCubit, JoyStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: rent.length > 0,
          builder: (context) => Container(
            // color: Colors.yellow,
            child: Container(
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
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: rent.length,
                    itemBuilder: (context, index) {
                      return buildCard(rent[index], context);
                    })),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    ));
  }

  Widget buildCard(RentModel rentModel, context) {
    var cubit = JoyCubit.get(context);
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 15,
      child: InkWell(
        onTap: () {
          print("//${rentModel.id}");
          RentID=rentModel.id;
          print("\\ ${rentModel.id}");
          // cubit.updateRent(RentID);
          cubit.getRent(RentID, context);

          for (int j = 0; j < cubit.model.orderRent.length; j++) {
            if (cubit.model.orderRent[j] == rentModel.id) {
              print(rentModel.id);
              print(cubit.model.orderRent[j]);
              disableRent = true;
              bookRent = 'Booked';
              colorRent = Colors.grey[800];
              break;
            }
            print('ZZZZZZ');
            disableRent = false;
            bookRent = 'Book Now';
            colorRent = Colors.white;
          }
        },
        child: Container(
          height: 200,
          child: Stack(
            children: [
              rentModel.offerd == true
                  ? ClipRRect(
                child: Banner(
                  message: 'offer',
                  textStyle: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  color: Colors.redAccent,
                  location: BannerLocation.topEnd,
                  child: Container(
                    height: 300,
                  ),
                ),
              )
                  : Container(),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      width: MediaQuery.of(context).size.width * 0.39,
                      height: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('${rentModel.imagePath[0]}'),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${rentModel.serviceName}",
                              // textDirection: TextDirection.rtl,
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("${rentModel.serviceDescripition}",
                                // textDirection: TextDirection.rtl,
                                maxLines: 2,
                                style: TextStyle(
                                  color: Colors.yellow,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )),
                            Spacer(),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'See More',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Spacer(),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 18,
                                      child: Text(
                                        '${rentModel.roomNum}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5.0,),
                                    Text("Units"),

                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
