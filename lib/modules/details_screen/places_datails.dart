
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jooy/layout/joy_app/cubit/cubit.dart';
import 'package:jooy/layout/joy_app/cubit/state.dart';
import 'package:jooy/models/places_model.dart';

class PlaceScreen extends StatefulWidget {
 PlacesModel model;
 PlaceScreen(this.model);

  @override
  _PlaceScreenState createState(){
    return _PlaceScreenState(model);
  }
}

class _PlaceScreenState extends State<PlaceScreen> {
  PlacesModel place;
  _PlaceScreenState(this.place);
  double x = 0;
  // final place=JoyCubit.get().place;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JoyCubit, JoyStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "JOY",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 28,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            elevation: 0,
            backgroundColor: Colors.grey[300],
          ),
          // backgroundColor: Colors.grey.shade100,
          body: Container(
            height: 1000,
            decoration: BoxDecoration(
              // color: Colors.red,
              gradient: LinearGradient(
                colors: [
                  Colors.grey[300],
                  Color(0xff2B688A),
                  Colors.lightBlue[900],
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [

                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      height: 250,
                      child: listImages(place)),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border:
                            Border.all(width: 2, color: Colors.grey[700]),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            titleDetails(
                              title: "Place Name",
                              subtitle: "${place.name}",
                            ),
                            titleDetails(
                              title: "Service Address",
                              subtitle: "${place.address}",
                            ),
                            titleDetails(
                              title: "Price",
                              subtitle: "${place.price[0]} For Egyptian",
                            ),
                            titleDetails(
                              title: "Details",
                              subtitle: "${place.details}",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      // Expanded(
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(10.0),
                      //     child: RaisedButton(
                      //       color: color,
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(5.0)),
                      //       padding: const EdgeInsets.all(10.0),
                      //       onPressed: disable == false
                      //           ? () {
                      //         setState(() {});
                      //         showDialog(
                      //           context: context,
                      //           builder: (context) => AlertDialog(
                      //             title: Row(
                      //               children: [
                      //                 Icon(
                      //                   Icons.shopping_cart,
                      //                   color: Colors.blue,
                      //                   size: 34,
                      //                 ),
                      //                 SizedBox(
                      //                   width: 10.0,
                      //                 ),
                      //                 Text(
                      //                   "Confirm to reserve",
                      //                   style: TextStyle(
                      //                       fontSize: 25,
                      //                       fontWeight: FontWeight.bold),
                      //                 ),
                      //               ],
                      //             ),
                      //             content: Column(
                      //               mainAxisSize: MainAxisSize.min,
                      //               children: [
                      //                 // Text(
                      //                 //   "Your Barcode is $random",
                      //                 //   style:
                      //                 //       TextStyle(fontWeight: FontWeight.bold),
                      //                 // ),
                      //                 SizedBox(
                      //                   height: 15.0,
                      //                 ),
                      //               ],
                      //             ),
                      //             actions: [
                      //               Row(
                      //                 children: [
                      //                   // RaisedButton(autofocus: ,)
                      //                   ElevatedButton(
                      //                     onPressed: () {
                      //                       setState(() {
                      //                         print(
                      //                             "pppp ${hotelModel.id}");
                      //                         print("pppp ${HotelID}");
                      //                         JoyCubit.get(context)
                      //                             .generateBarCode(
                      //                             context);
                      //                         JoyCubit.get(context)
                      //                             .safeBarcode(
                      //                             random, serialNum);
                      //                         disable = true;
                      //                         book = 'Booked';
                      //                         color = Colors.grey[300];
                      //
                      //                         Navigator.pop(context);
                      //                       });
                      //                     },
                      //                     child: Text("Confirm"),
                      //                     autofocus: disable,
                      //                   ),
                      //                   SizedBox(
                      //                     width: 15.0,
                      //                   ),
                      //                   ElevatedButton(
                      //                     onPressed: () {
                      //                       print('cancel');
                      //                       Navigator.pop(context);
                      //                     },
                      //                     child: Text("Cancel"),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ],
                      //           ),
                      //         );
                      //       }
                      //           : () {},
                      //       child: Text(
                      //         "$book",
                      //         style: TextStyle(
                      //             fontSize: 25, fontWeight: FontWeight.w700),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Expanded(
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(10.0),
                      //     child: RaisedButton(
                      //       color: Colors.white,
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(5.0)),
                      //       padding: const EdgeInsets.all(10.0),
                      //       onPressed: () => showDialog(
                      //         context: context,
                      //         builder: (context) => AlertDialog(
                      //           title: Text("Rate This App"),
                      //           content: Column(
                      //             mainAxisSize: MainAxisSize.min,
                      //             children: [
                      //               Text(
                      //                 "Please leave a star rating",
                      //               ),
                      //               SizedBox(
                      //                 height: 15.0,
                      //               ),
                      //               RatingBar.builder(
                      //                   maxRating: 1,
                      //                   itemBuilder: (context, _) => Icon(
                      //                     Icons.star,
                      //                     color: Colors.amber,
                      //                   ),
                      //                   onRatingUpdate: (rating) {
                      //                     this.x = rating;
                      //                     print(x);
                      //                   })
                      //             ],
                      //           ),
                      //           actions: [
                      //             TextButton(
                      //               onPressed: () {
                      //                 Navigator.pop(context);
                      //               },
                      //               child: Text("OK"),
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      //       child: Text(
                      //         "Rate US",
                      //         style: TextStyle(
                      //             fontSize: 25, fontWeight: FontWeight.w700),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }




  Widget listImages(PlacesModel placesModel) {
    return Container(
      child: CarouselSlider.builder(
        itemCount: placesModel.images.length,
        itemBuilder: (context, index, realIndex) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
            child: Image(
              image: NetworkImage("${placesModel.images[index]}"),
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        options: CarouselOptions(
          height: 300,
          initialPage: 0,
          viewportFraction: .9,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(
            seconds: 3,
          ),
          autoPlayAnimationDuration: Duration(seconds: 1),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
  Widget titleDetails(
      {@required String title, @required String subtitle, Color color}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          title: Text(

            "$title",
            style: TextStyle(
              color: Colors.black,
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
            textDirection: TextDirection.rtl,
          ),
          subtitle: Text(
            "$subtitle",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 21,
              fontWeight: FontWeight.w400,
            ),
            textDirection: TextDirection.rtl,


          ),
        ),
      ),
    );
  }

}
/*
 */