import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jooy/layout/joy_app/cubit/cubit.dart';
import 'package:jooy/layout/joy_app/cubit/state.dart';
import 'package:jooy/models/hotel_model.dart';
import 'package:jooy/modules/common-widget/commin-widget.dart';
import 'package:jooy/shared/components/constains.dart';

class HotelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var hotel = JoyCubit.get(context).hotel;

    return Scaffold(
        body: BlocConsumer<JoyCubit, JoyStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: hotel.length > 0,
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
                    itemCount: hotel.length,
                    itemBuilder: (context, index) {
                      return buildCard(hotel[index], context);
                    })),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    ));
  }

  Widget buildCard(HotelModel hotelModel, context) {
    var cubit = JoyCubit.get(context);
    var index = JoyCubit.get(context).hotel.length;
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 15,
      child: InkWell(
        onTap: () {
          HotelID = hotelModel.id;
          print("hotelModel ${HotelID}");
          cubit.getHotels(HotelID, context);
          print("(( ${cubit.model.orderRent.length}");
          for (int j = 0; j < cubit.model.orderHotels.length.toInt(); j++) {
            if (cubit.model.orderHotels[j] == hotelModel.id) {
              print('XXXXXXX');
              disableHotels = true;
              bookHotels = 'Booked';
              colorHotels = Colors.grey[800];
              break;
            }
            print('ZZZZZZ');
            disableHotels = false;
            bookHotels = 'Book Now';
            colorHotels = Colors.white;
          }
        },
        child: Container(
          height: 200,
          child: Stack(
            children: [
              //TODO AFTER VIDEO
              hotelModel.offerd == true
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
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      width: MediaQuery.of(context).size.width * 0.39,
                      height: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('${hotelModel.imagePath}'),
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
                              "${hotelModel.serviceName}",
                              // textDirection: TextDirection.rtl,
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("${hotelModel.serviceDescripition}",
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
                                  onPressed: () {
                                    cubit.getHotels(hotelModel.id, context);
                                  },
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
                                        '${hotelModel.roomNum}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5.0,),
                                    Text("Rooms"),

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
