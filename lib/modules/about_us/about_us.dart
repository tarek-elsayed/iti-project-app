import 'package:flutter/material.dart';
import 'package:jooy/layout/joy_app/cubit/cubit.dart';
import 'package:jooy/shared/components/constains.dart';


class AboutUS extends StatefulWidget {
  @override
  _AboutUSState createState() => _AboutUSState();
}

class _AboutUSState extends State<AboutUS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(top: 48),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.grey.shade400,
                          Colors.blue,
                          Colors.blue.shade900,]
                    )
                ),
                child: Container(
                  width: double.infinity,
                  height: 350.0,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage:NetworkImage("https://firebasestorage.googleapis.com/v0/b/jooy-dadba.appspot.com/o/joylogo.jpg?alt=media&token=94dc2c3b-6b07-4bca-8e5e-1a262a75fc6b"),
                          radius: 80.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "JOY",
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Card(
                          margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                          clipBehavior: Clip.antiAlias,
                          color: Colors.white,
                          elevation: 15,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 22.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(

                                    children: <Widget>[
                                      Text(
                                        "Services",
                                        style: TextStyle(
                                          color: Colors.blue.shade900,
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        "$countServices",
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.grey.shade600,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(

                                    children: <Widget>[
                                      Text(
                                        "users",
                                        style: TextStyle(
                                          color: Colors.blue.shade900,
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        "$countUsers",
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.grey.shade600,
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "About us:",
                      style: TextStyle(
                          color: Colors.blue.shade900,
                          fontStyle: FontStyle.normal,
                          fontSize: 28.0
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text('joy is a service marketing application to help service owners .\n to display their services and increase the number of users of their services .\n'
                        '  and help users to know all the tourist places and entertainment \n by clicking a button easily and providing them with offers and discounts',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: 300.00,

              child: RaisedButton(
                  onPressed: (){},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)
                  ),
                  elevation: 5.0,
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [Colors.grey.shade400,
                            Colors.blue,
                            Colors.blue.shade900,]
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Container(

                      constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                      alignment: Alignment.center,
                      child: Text("Contact us",
                        style: TextStyle(color: Colors.white, fontSize: 26.0, fontWeight:FontWeight.w300),
                      ),
                    ),
                  )
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}

