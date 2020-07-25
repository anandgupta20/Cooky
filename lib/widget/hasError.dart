import 'package:cooky/scoped_models/mainmodel.dart';
import 'package:flutter/material.dart';

class HasError extends StatelessWidget {
  final MainModel model;
  HasError(this.model);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

 
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/Error.png',
                width: width * 0.7,
                height: height * 0.38,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            FlatButton(

                ///icon: Icon(Icons.play_circle_filled, color: Colors.red),
                shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
                textColor: Colors.white,
                color: Colors.redAccent,
                child: Text("Go Back"),
                onPressed: () {
                Navigator.pop(context);
                })
          ]),
    );
  }
}
