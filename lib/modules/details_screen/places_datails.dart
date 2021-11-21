
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jooy/models/places_model.dart';

class PlaceScreen extends StatefulWidget {
 PlacesModel model;
 PlaceScreen(this.model);

  @override
  _PlaceScreenState createState(){
    return _PlaceScreenState();
  }
}

class _PlaceScreenState extends State<PlaceScreen> {
  // PlacesModel _model;
  // _PlaceScreenState(this._model);
  double x = 0;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                child: listImages(widget.model),

              ),
              // SizedBox(height: 25,child: Divider(color: Colors.amber,thickness: 5,),),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    color:Colors.black45 ,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [


                        titleDetails(
                          title: "اسم المكان السياحي",
                          subtitle: "${widget.model.name}",
                        ),
                        titleDetails(
                          title: "المعلومات ",
                          subtitle: "${widget.model.details}",
                        ),
                        // titleDetails(
                        //   title: "price",
                        //   subtitle: "15",
                        // ),
                        titleDetails(
                          title: "العنوان",
                          subtitle: "${widget.model.address}",
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
                    title: Text("Rate ${widget.model.name}"),
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
                            itemBuilder: (context,_) => Icon(
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