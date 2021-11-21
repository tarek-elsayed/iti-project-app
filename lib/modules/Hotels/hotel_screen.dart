import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jooy/layout/joy_app/cubit/cubit.dart';
import 'package:jooy/layout/joy_app/cubit/state.dart';
import 'package:jooy/models/hotel_model.dart';

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
            child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 1.0,
                  mainAxisSpacing: 1.0,
                  childAspectRatio: 1 / 1.79,
                  scrollDirection: Axis.vertical,
                  crossAxisCount: 2,
                  children: List.generate(
                    hotel.length,
                    (index) => buildCard(hotel[index], context),
                  ),
                )),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    ));
  }

  // Widget buildOver(HotelModel model,context){
  //   int count = JoyCubit.get(context).hotel.length;
  //   return GridView.count(
  //
  //       shrinkWrap: true,
  //       physics: NeverScrollableScrollPhysics(),
  //       crossAxisSpacing: 1.0,
  //       mainAxisSpacing: 1.0,
  //       childAspectRatio: 1 / 1.79,
  //       scrollDirection: Axis.vertical,
  //       crossAxisCount: 2,
  //       children: List.generate(
  //         count,
  //             (index) => buildCard(model.toMap()[index],context),
  //       ));
  // }
  Widget buildCard(HotelModel hotelModel, context) {
    var cubit = JoyCubit.get(context);
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Container(
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      JoyCubit.get(context).getHotels(hotelModel.id, context);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Image.network(
                              "${hotelModel.imagePath}",
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.black.withOpacity(.8),
                              child: Text(
                                "${hotelModel.serviceName}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 28),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text("${hotelModel.serviceName}"),
                              // Text("${hotelModel.serviceDescripition}"),
                              // Text("Hi"),
                            ],
                          ),
                        ),
                        ButtonBar(
                          children: [
                            TextButton(
                              onPressed: () {
                                // JoyCubit.get(context)
                                //     .getHotels(hotelModel.id, context);
                                // FirebaseFirestore.instance.collection("Fav").doc().set({
                                //   "hotel":'ahmed',
                                //   "idItem":"1",
                                //   "idUser":"5",
                                //
                                // }).then((value){
                                //   print('fffff');
                                // });
                              },
                              child: Text(
                                "See More",
                                style: TextStyle(
                                  color: Colors.lightBlue[900],

                                ),
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () {
                                // if (hotelModel.fav == true) {
                                //   hotelModel.fav = false;
                                // } else {
                                //   hotelModel.fav = true;
                                // }
                                //
                                // cubit.updateHotel(
                                //   id: hotelModel.id,
                                //   hotelName: hotelModel.hotelName,
                                //   details: hotelModel.details,
                                //   description: hotelModel.description,
                                //   images: hotelModel.images,
                                //   fav: hotelModel.fav,
                                // );
                              },
                              icon: CircleAvatar(
                                radius: 18.0,
                                backgroundColor: Colors.lightBlue[900],
                                child: Icon(Icons.favorite_outline),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
