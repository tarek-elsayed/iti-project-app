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
                      itemCount: place.length,
                      itemBuilder: (context, index) {
                        return buildCard(place[index], context);
                      })),
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
    var cubit = JoyCubit.get(context);
    return
      Card(
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
            cubit.getPlace(placesModel.id, context);
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

                            image: NetworkImage('${placesModel.images[0]}'),
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
                              "${placesModel.name}",
                              // textDirection: TextDirection.rtl,
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),

                            ),
                            Text("${placesModel.description}",
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
              )),
        ),
      );
  }
}
