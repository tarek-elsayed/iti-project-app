import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jooy/layout/joy_app/cubit/cubit.dart';
import 'package:jooy/layout/joy_app/cubit/state.dart';
import 'package:jooy/models/hotel_model.dart';
import 'package:jooy/models/rent_model.dart';

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
    // var cubit = JoyCubit.get(context);
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 15,
      child: InkWell(
        onTap: () {
          // JoyCubit.get(context).checkBarcode(hotelModel.id);
          // HotelID=hotelModel.id;
          // print("hotelModel ${hotelModel.id}");
          // JoyCubit.get(context).createSerialNum(hotelModel.id);
          // cubit.getHotels(hotelModel.id, context);
        },
        child: Container(
            height: 200,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    width: MediaQuery.of(context).size.width * 0.39,
                    height: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(

                          image: NetworkImage('${rentModel.imagePath}'),
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
                                onPressed: (){},
                                child: Text('See More',
                                  style: TextStyle(fontSize: 16),),
                              ),
                              Spacer(),
                              Icon(Icons.favorite)
                            ],
                          ),

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
