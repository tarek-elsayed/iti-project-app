import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jooy/models/Restaurant_model.dart';



///Imgae Slider
class DetailScreen extends StatefulWidget {
  RestaurantModel model;
  DetailScreen(this.model);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DetailScreen(model);
  }
}

class _DetailScreen extends State<DetailScreen> {
  double x = 0;
RestaurantModel model1;
  _DetailScreen(this.model1);

  @override
  Widget build(BuildContext context) {
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
          onPressed: () {},
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      // backgroundColor: Colors.grey.shade100,
      body: Container(
        height: 1000,
        decoration: BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  height: 250,
                  child: listImages()
                // ListView.builder(
                //     itemCount: item.length,
                //     scrollDirection: Axis.horizontal,
                //     itemBuilder: (context, index) {
                //       return Container(
                //         height: 250,
                //         decoration: BoxDecoration(
                //           color: Colors.red,
                //           borderRadius: BorderRadius.circular(20),
                //         ),
                //         child: Image.network(
                //           item[index],
                //           fit: BoxFit.cover,
                //         ),
                //       );
                //     }),
              ),
              // SizedBox(height: 25,child: Divider(color: Colors.amber,thickness: 5,),),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.grey[700]),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        titleDetails(
                          title: "Restaurant Name",
                          subtitle: "${model1.name}",
                        ),
                        titleDetails(
                          title: "Phone",
                          subtitle: "${model1.description}",
                        ),
                        titleDetails(
                          title: "price",
                          subtitle: "15",
                        ),
                        titleDetails(
                          title: "Address",
                          subtitle: "23 St Ramsis",
                        ),

                      ],
                    ),
                  ),
                ),
              ),

              RaisedButton(
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
                child: Text("Rate US"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Container(
  //
  // height: 200,
  // child:  Padding(
  // padding: const EdgeInsets.symmetric(
  // horizontal: 5.0, vertical: 0.0),
  // child: Container(
  // decoration: BoxDecoration(
  // borderRadius: BorderRadius.circular(20),
  // ),
  // height: 250,
  // child: xB(),
  // ),
  // ),
  // ),

  // Container(
  // child: Padding(
  // padding: const EdgeInsets.symmetric(horizontal: 10.0),
  // child: SingleChildScrollView(
  // physics: BouncingScrollPhysics(),
  // child: Container(
  // color: Colors.amber,
  // child: Column(
  // mainAxisAlignment: MainAxisAlignment.start,
  // children: [
  // titleDetails(
  // title: 'Shop',
  // subtitle: "Hello",
  // color: Colors.grey,
  // ),titleDetails(
  // title: 'Shop',
  // subtitle: "Hello",
  // color: Colors.grey,
  // ),titleDetails(
  // title: 'Shop',
  // subtitle: "Hello",
  // color: Colors.grey,
  // ),titleDetails(
  // title: 'Shop',
  // subtitle: "Hello",
  // color: Colors.grey,
  // ),titleDetails(
  // title: 'Shop',
  // subtitle: "Hello",
  // color: Colors.grey,
  // ),titleDetails(
  // title: 'Shop',
  // subtitle: "Hello",
  // color: Colors.grey,
  // ),titleDetails(
  // title: 'Shop',
  // subtitle: "Hello",
  // color: Colors.grey,
  // ),titleDetails(
  // title: 'Shop',
  // subtitle: "Hello",
  // color: Colors.grey,
  // ),titleDetails(
  // title: 'Shop',
  // subtitle: "Hello",
  // color: Colors.grey,
  // ),
  // ],
  // ),
  // ),
  // ),
  // ),
  // )

  // Widget imageSlider(context) {
  //   return Swiper(
  //     scrollDirection: Axis.horizontal,
  //     duration: 2000,
  //     autoplay: true,
  //     itemBuilder: (context, index) {
  //       return Image.network(
  //         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTjzMzuQcaLm52XRb-od5xmOIPCHUk1Mc3B_R6fgLW6-wSu6s5DBa6NXIHXQy49ff6KHk&usqp=CAU",
  //         fit: BoxFit.fitHeight,
  //       );
  //     },
  //     itemCount: 5,
  //     viewportFraction: 0.8,
  //     scale: 0.8,
  //   );
  // }
  //
  List item = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTjzMzuQcaLm52XRb-od5xmOIPCHUk1Mc3B_R6fgLW6-wSu6s5DBa6NXIHXQy49ff6KHk&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTjzMzuQcaLm52XRb-od5xmOIPCHUk1Mc3B_R6fgLW6-wSu6s5DBa6NXIHXQy49ff6KHk&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTjzMzuQcaLm52XRb-od5xmOIPCHUk1Mc3B_R6fgLW6-wSu6s5DBa6NXIHXQy49ff6KHk&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTjzMzuQcaLm52XRb-od5xmOIPCHUk1Mc3B_R6fgLW6-wSu6s5DBa6NXIHXQy49ff6KHk&usqp=CAU",
  ];

  Widget listImages() {
    return Container(
      child: CarouselSlider(
        items: item
            .map(
              (index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
              child: Image(
                image: NetworkImage("${item[0]}"),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
            .toList(),
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
