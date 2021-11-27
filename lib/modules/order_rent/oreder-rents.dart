import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jooy/layout/joy_app/cubit/cubit.dart';
import 'package:jooy/layout/joy_app/cubit/state.dart';
import 'package:jooy/models/hotel_model.dart';
import 'package:jooy/models/rent_model.dart';
import 'package:jooy/shared/components/constains.dart';

class OrderRentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var order = JoyCubit.get(context).showRent;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Your Unit Order',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<JoyCubit, JoyStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return ConditionalBuilder(
              condition: order.length > 0,
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
                        itemCount: order.length,
                        itemBuilder: (context, index) {
                          return buildCard(order[index], context);
                        })),
              ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            );
          },
        ));
  }

  Widget buildCard(RentModel orderModel, context) {
    var cubit = JoyCubit.get(context);

    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 15,
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 200,
          child: Stack(
            children: [
              //TODO AFTER VIDEO
              orderModel.offerd == true
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
                            image: NetworkImage('${orderModel.imagePath}'),
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
                              "${orderModel.serviceName}",
                              // textDirection: TextDirection.rtl,
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${orderModel.serviceDescripition}",
                              // textDirection: TextDirection.rtl,
                              maxLines: 2,
                              style: TextStyle(
                                color: Colors.yellow,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
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
