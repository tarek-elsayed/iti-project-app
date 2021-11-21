import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jooy/layout/joy_app/cubit/cubit.dart';
import 'package:jooy/layout/joy_app/cubit/state.dart';
import 'package:jooy/models/Restaurant_model.dart';

class ResturantScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var rest = JoyCubit.get(context).restaurant;
    return Scaffold(
        body: BlocConsumer<JoyCubit, JoyStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: rest.length > 0,
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
                    rest.length,
                    (index) => buildCard(rest[index], context),
                  ),
                )),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    ));
  }

  // Widget buildOver(RestaurantModel model, context) {
  //   int count = JoyCubit.get(context).restaurant.length;
  //   return GridView.count(
  //       shrinkWrap: true,
  //       physics: NeverScrollableScrollPhysics(),
  //       crossAxisSpacing: 1.0,
  //       mainAxisSpacing: 1.0,
  //       childAspectRatio: 1 / 1.79,
  //       scrollDirection: Axis.vertical,
  //       crossAxisCount: 2,
  //       children: List.generate(
  //         count,
  //         (index) => buildCard(model.toMap()[index], context),
  //       ));
  // }

  Widget buildCard(RestaurantModel restaurantModel, context) {
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
                      JoyCubit.get(context)
                          .getRestaurant(restaurantModel.id, context);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Image.network(
                              "${restaurantModel.imagePath}",
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.black.withOpacity(.8),
                              child: Text(
                                "${restaurantModel.serviceName}",
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
                              Text("${restaurantModel.serviceName}"),
                              // Text("${restaurantModel.serviceDescripition}"),
                              // Text("${restaurantModel.hashCode}"),
                            ],
                          ),
                        ),
                        ButtonBar(
                          children: [
                            TextButton(
                              onPressed: () {
                                JoyCubit.get(context)
                                    .getRestaurant(restaurantModel.id, context);
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
                                // if (restaurantModel.fav == true) {
                                //   restaurantModel.fav = false;
                                // } else {
                                //   restaurantModel.fav = true;
                                // }
                                // cubit.updateHotel(
                                //   id: restaurantModel.id,
                                //   hotelName: restaurantModel.name,
                                //   details: restaurantModel.details,
                                //   description: restaurantModel.description,
                                //   images: restaurantModel.images,
                                //   fav: restaurantModel.fav,
                                // );
                              },
                              icon: CircleAvatar(
                                radius: 18.0,
                                backgroundColor: Colors.lightBlue[900],
                                child: Icon(Icons.favorite_outline),
                              ),
                            ),
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
