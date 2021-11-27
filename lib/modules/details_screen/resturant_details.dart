import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jooy/layout/joy_app/cubit/cubit.dart';
import 'package:jooy/models/Restaurant_model.dart';
import 'package:jooy/models/user_model.dart';
import 'package:jooy/shared/components/constains.dart';


///Imgae Slider
class RestaurantDetailScreen extends StatefulWidget {
  RestaurantModel model;

  RestaurantDetailScreen(this.model);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RestaurantDetailScreen(model);
  }
}

class _RestaurantDetailScreen extends State<RestaurantDetailScreen> {
  double x = 0;
  RestaurantModel restaurantModel;

  _RestaurantDetailScreen(this.restaurantModel);

  @override
  Widget build(BuildContext context) {
    var cubit =JoyCubit.get(context);
    // TODO: implement build
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
              if (tarek != null)
                Container(
                  color: Colors.blue,
                  height: 60.0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: ListTile(
                      title: Text(
                        'You already reserved ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      leading: Icon(
                        Icons.check_circle,
                        color: Colors.white,
                      ),
                      trailing: RaisedButton(
                        child: Text(
                          'Show',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        onPressed: () {
                          setState(() {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: ListTile(
                                  leading: Icon(Icons.check_circle),
                                  title: Text('Your BarCode'),
                                  trailing: Padding(
                                    padding:
                                    const EdgeInsets.only(left: 8.0),
                                    child: IconButton(
                                      padding: EdgeInsets.only(left: 10.0),
                                      icon: Icon(Icons.delete_forever),
                                      onPressed: () {
                                        setState(() {
                                          List<Barcodes> barCodeChange = [];
                                          barCodeChange = [];
                                          for (int i = 0; i < cubit.model.barcodes.length; i++) {
                                            if (cubit.model.barcodes[i].serialNum.toString() == RestID) {
                                              print(cubit.model.barcodes[i].barcode);
                                              if (cubit.model.barcodes[i].barcode != null) {
                                                cubit.model.barcodes.removeAt(i);
                                                barCodeChange = cubit.model.barcodes;
                                                print('Lobna');
                                                print(cubit.model.barcodes.length);
                                                print(cubit.model.barcodes);
                                                UserModel userModel = UserModel(
                                                    phone: cubit.model.phone,
                                                    name: cubit.model.name,
                                                    email: cubit.model.email,
                                                    image: cubit.model.image,
                                                    uId: cubit.model.uId,
                                                    isEmailVerified: cubit.model.isEmailVerified,
                                                    barcodes: barCodeChange,
                                                    orderHotels: cubit.model.orderHotels,
                                                    orderRent: cubit.model.orderRent
                                                );

                                                FirebaseFirestore.instance
                                                    .collection("Users")
                                                    .doc(uId)
                                                    .update(userModel.toMap())
                                                    .then((value) {

                                                  tarek = null;
                                                  cubit.getUserData();

                                                  print('BBBB');
                                                });
                                              }
                                            }
                                            print('Lobna111');

                                          }
                                          disableRest = false;
                                          bookRest = 'Book Now';
                                          colorRest = Colors.white;
                                          tarek=null;
                                          Navigator.pop(context);

                                        });
                                      },
                                    ),
                                  ),
                                ),
                                content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "$tarek",
                                      ),
                                    ]),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("OK"),
                                  )
                                ],
                              ),
                            );
                          });
                        },
                        color: Colors.white,
                        textColor: Colors.black,
                      ),
                    ),
                  ),
                ),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)),
                  height: 250,
                  child: imageSlider(restaurantModel)),
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
                          title: "Restaurant Name",
                          subtitle: "${restaurantModel.serviceName}",
                        ),
                        titleDetails(
                          title: "Phone",
                          subtitle: "${restaurantModel.servicePhone}",
                        ),
                        titleDetails(
                          title: "Price",
                          subtitle: "${restaurantModel.servicePrice}",
                        ),
                        titleDetails(
                          title: "Service Descripition",
                          subtitle: "${restaurantModel.serviceDescripition}",
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
                        color: colorRest,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        padding: const EdgeInsets.all(10.0),
                        onPressed: disableRest == false
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
                                  // Text(
                                  //   "Your Barcode is $random",
                                  //   style:
                                  //       TextStyle(fontWeight: FontWeight.bold),
                                  // ),
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
                                          JoyCubit.get(context).generateBarCode(context);
                                          JoyCubit.get(context).safeBarcode(random,serialNum);
                                          Navigator.pop(context);
                                           disableRest=true;
                                           bookRest='Booked';
                                           colorRest=Colors.grey[800];

                                        });
                                      },
                                      child: Text("Confirm"),
                                      autofocus: disableHotels,
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
                          "$bookRest",
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
  }

  Widget imageSlider(RestaurantModel restaurantModel) {
    return Container(
      child: CarouselSlider.builder(
        itemCount: 1,
        itemBuilder: (context, index, realIndex) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
            child: Image(
              image: NetworkImage("${restaurantModel.imagePath}"),
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
