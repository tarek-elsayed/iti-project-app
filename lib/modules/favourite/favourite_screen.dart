import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jooy/layout/joy_app/cubit/cubit.dart';
import 'package:jooy/layout/joy_app/cubit/state.dart';
import 'package:jooy/models/hotel_model.dart';
import 'package:jooy/modules/order_hotels/oreder-hotels.dart';
import 'package:jooy/modules/order_rent/oreder-rents.dart';
import 'package:jooy/shared/components/components.dart';
import 'package:jooy/shared/components/constains.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  int x=0;
    return Scaffold(
        body: BlocConsumer<JoyCubit, JoyStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return ConditionalBuilder(
              condition: x==0,
              builder: (context) => Container(
                // color: Colors.yellow,
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0),
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
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return buildCard(context,index);
                          })),
                ),
              ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            );
          },
        ));
  }
  List title=['Hotels',"Rent"];
  List photos=['https://www.thaqafnafsak.com/wp-content/uploads/2017/10/%D8%A3%D9%83%D8%A8%D8%B1-%D8%A7%D9%84%D9%81%D9%86%D8%A7%D8%AF%D9%82-%D8%AD%D9%88%D9%84-%D8%A7%D9%84%D8%B9%D8%A7%D9%84%D9%85-%D8%A8%D8%A7%D9%84%D8%B5%D9%88%D8%B14.jpg',
  'https://mediaaws.almasryalyoum.com/news/verylarge/2021/07/28/1589578_0.jpeg'];

List<Widget>widget =[
  OrderHotelsScreen(),
  OrderRentsScreen(),
];
  Widget buildCard(BuildContext context,int index) {

    return Card(
      margin: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 15,
      child: InkWell(
        onTap: () {
          navigateTo(context, widget[index]);
        },
        child: Container(
          height: 300,
          child: Stack(
              children:[
                //TODO AFTER VIDEO

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        width: MediaQuery.of(context).size.width * 0.39,
                        height: 250,
                        decoration: BoxDecoration(
                            image: DecorationImage(

                              image: NetworkImage('${photos[index]}'),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${title[index]}",

                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),

                              ),
                              // Spacer(),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ]
          ),
        ),
      ),
    );
  }
}
