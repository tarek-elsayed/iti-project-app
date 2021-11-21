import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:jooy/modules/profile/profile-screen.dart';



class CardsView extends StatelessWidget {
  final Function onPress;
  final String image, label, subLabel;
  final int index;
  const CardsView(
      {Key key,
        this.onPress,
        this.image,
        this.label,
        this.subLabel,
        this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          // color: Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        height: 370,
        width: 320,
        child: Stack(
          children: [
            Hero(
              tag: index,
              child: Container(
                height: 150,
                width: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  image: new DecorationImage(
                    image: new ExactAssetImage(
                      image,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 130,
              child: Container(
                height: 130,
                width: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  color: Color(0xFF071333),
                ),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                            color: Color(0xffFDCE03),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        subLabel,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardData {
  final String image, title, subtitle;

  CardData({this.image, this.title, this.subtitle});
}



List<CardData> hotel = [
  CardData(title: "h1", subtitle: "hotel 1", image: "images/1.jpeg"),
  CardData(title: "h2", subtitle: "hotel 2", image: "images/2.jpeg"),
  CardData(title: "h3", subtitle: "hotel 3", image: "images/3.jpeg"),
  CardData(title: "h4", subtitle: "hotel 3", image: "images/4.jpeg"),
  CardData(title: "h5", subtitle: "hotel 4", image: "images/5.jpeg"),
  CardData(title: "h6", subtitle: "hotel 5", image: "images/6.jpeg"),
  CardData(title: "h7", subtitle: "hotel 6", image: "images/7.jpeg"),
  CardData(title: "h8", subtitle: "hotel 7", image: "images/8.jpeg"),
];

List<CardData> restaurant = [
  CardData(title: "r1", subtitle: "rest 1", image: "images/11.jpeg"),
  CardData(title: "r2", subtitle: "rest 2", image: "images/22.jpeg"),
  CardData(title: "r3", subtitle: "rest 3", image: "images/33.jpeg"),
  CardData(title: "r4", subtitle: "rest 3", image: "images/44.jpeg"),
  CardData(title: "r5", subtitle: "rest 4", image: "images/55.jpeg"),
  CardData(title: "r6", subtitle: "rest 5", image: "images/66.jpeg"),
  CardData(title: "r7", subtitle: "rest 6", image: "images/77.jpeg"),
  CardData(title: "r8", subtitle: "rest 7", image: "images/88.jpeg"),
];

List<CardData> places = [
  CardData(title: "p1", subtitle: "place 1", image: "images/111.jpeg"),
  CardData(title: "p2", subtitle: "place 2", image: "images/222.jpeg"),
  CardData(title: "p3", subtitle: "place 3", image: "images/333.jpeg"),
  CardData(title: "p4", subtitle: "place 3", image: "images/444.jpeg"),
  CardData(title: "p5", subtitle: "place 4", image: "images/555.jpeg"),
  CardData(title: "p6", subtitle: "place 5", image: "images/666.jpeg"),
  CardData(title: "p7", subtitle: "place 6", image: "images/777.jpeg"),
  CardData(title: "p8", subtitle: "place 7", image: "images/888.jpeg"),
];





class CreatNavigationBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CreatNavigationBarState();
}

class CreatNavigationBarState extends State<CreatNavigationBar> {
  int _selectedIndex = 0;
  List<Widget> pages = <Widget>[

    // ProfileScreen(),
    // ProfileScreen(),
    // ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.white,
        selectedLabelStyle:
        TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Color(0xFF071333),
        unselectedLabelStyle:
        TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Favorite",
            icon: Icon(Icons.favorite_sharp),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: "About us",
          ),
          BottomNavigationBarItem(
            label: "Setting",
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}


class CreatButton extends StatelessWidget {
  final double height, width, topMargin;
  final Function onPress;
  final String label;
  final Color backgroundColor;
  final Color labelColor;
  final double fontSize;
  const CreatButton(
      {Key key,
        this.height,
        this.width,
        this.onPress,
        this.label,
        this.backgroundColor,
        this.labelColor,
        this.fontSize,
        this.topMargin})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        margin: EdgeInsets.only(top: topMargin == null ? 0 : topMargin),
        decoration: BoxDecoration(
            borderRadius: new BorderRadius.circular(30.0),
            color: backgroundColor),
        child: Text(
          label,
          style: TextStyle(fontSize: fontSize, color: labelColor),
        ),
      ),
    );
  }
}


class HomeDetails extends StatefulWidget {
  final String image;
  final int index;
  const HomeDetails({Key key, this.image, this.index}) : super(key: key);

  @override
  _HomeDetailsState createState() => _HomeDetailsState();
}

class _HomeDetailsState extends State<HomeDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("JOY",style: TextStyle(
              fontSize: 28,fontWeight: FontWeight.w700
          ),),
          backgroundColor: Color(0xFF071333),
          elevation: 0,
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              child: Column(children: [


                Carousel(img: []),


                Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(25)),
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        height: MediaQuery.of(context).size.height * 0.5,
                        decoration: BoxDecoration(
                            color: Color(0xFF071333),
                            borderRadius: BorderRadius.circular(25)),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Hero(
                                tag: widget.index,
                                child: Container(
                                  height: 300,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          widget.image,
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                      borderRadius: BorderRadius.circular(25)),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 20),
                                child: Column(
                                  children: [
                                    Text(
                                      "حديقه النباتات",
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "تقع حديقه النباتات بمحافظه اسوان في البر   وهذا شهدد من في الشرقي والغربي وهي تحتوي علي الكثير من النبتات النادره والغير نادري وعلي جميع الزوار ارتداء الكمامه",
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "اذا اردت الحجز والاستعلام اتصل بنا علي  الرقم التالي  :    ٠١٠٢١٤٣٥٦٧٨ ",
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Text(
                                            "اذا كنت مهتم بالعرض اتصل بنا ولا تنسي الضغط علي اعجاب حتي يصلك كل جديد ",
                                            style: TextStyle(
                                                color: Colors.orange,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.favorite_sharp,
                                                  color: Colors.orange,
                                                )))
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                ),





              ],)
          ),
        ),
      ),
    );
  }
}


class Carousel extends StatefulWidget {
  final List img;
  // final String titles;
  const Carousel({
    Key key,
    this.img,
  }) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  List empty = [
    "https://www.creativeegypt.org/assets/images/delivery/delivery.jpg",
    "https://media-exp1.licdn.com/dms/image/C4E1BAQGGd1ctYngoJQ/com"
        "pany-background_10000/0/1541668074232?e=2159024400&v=beta&t=7Rn"
        "uezLlbg4C4MnC-dlkKHSlhllY-3BOh5rHRDADV2Q",
    "https://www.creativeegypt.org/assets/images/delivery/delivery.jpg",
    "https://media-exp1.licdn.com/dms/image/C4E1BAQGGd1ctYngoJQ/com"
        "pany-background_10000/0/1541668074232?e=2159024400&v=beta&t=7Rn"
        "uezLlbg4C4MnC-dlkKHSlhllY-3BOh5rHRDADV2Q",
    "https://www.creativeegypt.org/assets/images/delivery/delivery.jpg",
    "https://media-exp1.licdn.com/dms/image/C4E1BAQGGd1ctYngoJQ/com"
        "pany-background_10000/0/1541668074232?e=2159024400&v=beta&t=7Rn"
        "uezLlbg4C4MnC-dlkKHSlhllY-3BOh5rHRDADV2Q",
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height / 5,
          viewportFraction: 0.97,
          aspectRatio: 2.0,
          autoPlay: true,
          initialPage: 1,
          reverse: true,
          enlargeCenterPage: true,
          autoPlayInterval: Duration(seconds: 3),
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: Duration(milliseconds: 400),
        ),
        items: widget.img.isEmpty
            ? empty.map(
              (url) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 5,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent, width: 2),
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: NetworkImage(url),
                    fit: BoxFit.fill,
                  )),
            );
          },
        ).toList()
            : widget.img.map(
              (url) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent, width: 2)),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                child: Image.network(
                  url,
                  fit: BoxFit.fitWidth,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            );
          },
        ).toList());
  }
}







