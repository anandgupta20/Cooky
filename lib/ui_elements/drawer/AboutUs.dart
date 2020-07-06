import 'package:flutter/material.dart';

class Aboutus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
   // double width = size.width;
    double height = size.height;
    return Scaffold(
        appBar: AppBar(
          elevation: 3.0,
          backgroundColor: Colors.white,
          title: Text(
            "About Us",
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(25),
              child: Column(
                children: <Widget>[
                 Image.asset("assets/cookylogo.png", height:height*0.132),
                 SizedBox(height: 15,),
                  Text(
                      "Cooky is an app striving towards providing the free recipes and other National "
                       "and International dishes ideas from people of different places keeping health "
                       "factor in mind. We are aiming to provide great courses on cooking and subtle art"
                       " of creating and presenting the ideas and culture into a plate which mesmerizes the clients. "
                       "We lay special emphasis on organic fooding habits and healthy eating. "
                       "All our recipes are doctor verified and health rating index for each recipe is visible through our app."
                      , style: TextStyle(fontSize: 18,),),
                ],
              )),
        ));
  }
}
