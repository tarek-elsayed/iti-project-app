import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jooy/layout/joy_app/cubit/cubit.dart';
import 'package:jooy/layout/joy_app/cubit/state.dart';
import 'package:jooy/models/places_model.dart';

class Place extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var place = JoyCubit.get(context).places;
    return Scaffold(
      body: BlocConsumer<JoyCubit, JoyStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: place.length > 0,
            builder: (_) => Container(
              // color: Colors.yellow,
              child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 1.0,
                    mainAxisSpacing: 1.0,
                    childAspectRatio: 1 / 2,
                    scrollDirection: Axis.vertical,
                    crossAxisCount: 2,
                    children: List.generate(
                      place.length,
                      (index) => buildCard(place[index], context),
                    ),
                  )),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

  // Widget buildOver(BuildContext context){
  //
  //   return GridView.count(
  //       shrinkWrap: true,
  //       physics: NeverScrollableScrollPhysics(),
  //       crossAxisSpacing: 1.0,
  //       mainAxisSpacing: 1.0,
  //       childAspectRatio: 1 / 1.79,
  //       scrollDirection: Axis.vertical,
  //       crossAxisCount: 2,
  //       children: List.generate(
  //        place.length,
  //             (index) => buildCard(),
  //       ));
  // }
  // List item = [
  //   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTjzMzuQcaLm52XRb-od5xmOIPCHUk1Mc3B_R6fgLW6-wSu6s5DBa6NXIHXQy49ff6KHk&usqp=CAU",
  //   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTjzMzuQcaLm52XRb-od5xmOIPCHUk1Mc3B_R6fgLW6-wSu6s5DBa6NXIHXQy49ff6KHk&usqp=CAU",
  //   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTjzMzuQcaLm52XRb-od5xmOIPCHUk1Mc3B_R6fgLW6-wSu6s5DBa6NXIHXQy49ff6KHk&usqp=CAU",
  //   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTjzMzuQcaLm52XRb-od5xmOIPCHUk1Mc3B_R6fgLW6-wSu6s5DBa6NXIHXQy49ff6KHk&usqp=CAU",
  // ];

  Widget buildCard(PlacesModel placesModel, BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Container(
                child: Card(
                  elevation: 2,
                  shadowColor: Colors.red[800],
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      JoyCubit.get(context).getPlace(placesModel.id, context);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Image.network(
                              "${placesModel.images[0]}",
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.black.withOpacity(.8),
                              child: Text(
                                "${placesModel.name}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                ),
                                textDirection: TextDirection.rtl,
                                overflow: TextOverflow.ellipsis,
                                // maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Expanded(
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Text(
                                    "${placesModel.description}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                    ),
                                    textDirection: TextDirection.rtl,
                                    // overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                // Container(
                                //   width: double.infinity,
                                //   child: Text(
                                //     "${placesModel.details}",
                                //     style: TextStyle(
                                //       color: Colors.black,
                                //       fontSize: 22,
                                //     ),
                                //     textDirection: TextDirection.rtl,
                                //     overflow: TextOverflow.ellipsis,
                                //     // maxLines: 2,
                                //   ),
                                // ),
                                // Container(
                                //   width: double.infinity,
                                //   child: Text(
                                //     "${placesModel.id}",
                                //     style: TextStyle(
                                //       color: Colors.black,
                                //       fontSize: 20,
                                //     ),
                                //     textDirection: TextDirection.rtl,
                                //     overflow: TextOverflow.ellipsis,
                                //     maxLines: 2,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                        ButtonBar(
                          children: [
                            TextButton(
                              onPressed: () {
                                JoyCubit.get(context)
                                    .getPlace(placesModel.id, context);
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
                              icon: CircleAvatar(
                                radius: 18.0,
                                backgroundColor: Colors.lightBlue[900],
                                child: Icon(Icons.favorite_outline),
                              ),
                              onPressed: () {},
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
        ),
      ),
    );
  }
}
