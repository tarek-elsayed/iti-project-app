import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jooy/layout/joy_app/cubit/cubit.dart';
import 'package:jooy/layout/joy_app/cubit/state.dart';

import 'package:jooy/models/rent_model.dart';
import 'package:jooy/shared/components/constains.dart';

///Imgae Slider
class RentDetailScreen extends StatefulWidget {
  RentModel model;

  RentDetailScreen(this.model);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RentDetailScreen(model);
  }
}

class _RentDetailScreen extends State<RentDetailScreen> {
  double x = 0;
  RentModel rentModel;

  _RentDetailScreen(this.rentModel);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                      child: imageSlider(rentModel)),
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
                              title: "Rent Name",
                              subtitle: "${rentModel.serviceName}",
                            ),
                            titleDetails(
                              title: "Phone",
                              subtitle: "${rentModel.servicePhone}",
                            ),
                            titleDetails(
                              title: "Price",
                              subtitle: "${rentModel.servicePrice}",
                            ),
                            titleDetails(
                              title: "Service Descripition",
                              subtitle: "${rentModel.serviceDescripition}",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: RaisedButton(
                            color: colorRent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            padding: const EdgeInsets.all(10.0),
                            onPressed: disableRent == false
                                ? () {
                                    setState(() {});
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Row(
                                          children: [
                                            Icon(
                                              Icons.shopping_cart,
                                              color: Colors.blue,
                                              size: 34,
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Text(
                                              "Confirm to reserve",
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [

                                            SizedBox(
                                              height: 15.0,
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          Row(
                                            children: [
                                              // RaisedButton(autofocus: ,)
                                              ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    JoyCubit.get(context)
                                                        .setBookRent(
                                                            RentID, context);
                                                    JoyCubit.get(context).getAllRents();
                                                    disableHotels = true;
                                                    bookHotels = 'Booked';
                                                    colorHotels = Colors.grey[800];
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                child: Text("Confirm"),
                                                autofocus: disableRent,
                                              ),
                                              SizedBox(
                                                width: 15.0,
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  print('cancel');
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Cancel"),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                : () {},
                            child: Text(
                              "$bookRent",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: RaisedButton(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            padding: const EdgeInsets.all(10.0),
                            onPressed: () => showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Rate This App"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Please leave a star rating",
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    RatingBar.builder(
                                        maxRating: 1,
                                        itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                        onRatingUpdate: (rating) {
                                          this.x = rating;
                                          print(x);
                                        })
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("OK"),
                                  )
                                ],
                              ),
                            ),
                            child: Text(
                              "Rate US",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
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

  Widget imageSlider(
    RentModel rentModel,
  ) {
    return Container(
      child: CarouselSlider.builder(
        itemCount: rentModel.imagePath.length,
        itemBuilder: (context, index, realIndex) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
            child: Image(
              image: NetworkImage("${rentModel.imagePath}"),
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
          ),
          subtitle: Text(
            "$subtitle",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 21,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
