import 'package:flutter/material.dart';

class RecipeImage extends StatelessWidget {
  final String imageURL;

  RecipeImage(this.imageURL);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 15.0 / 9.0,
     child: Image.asset(imageURL,fit: BoxFit.cover,)
      //   imageURL,
      //   fit: BoxFit.cover,
      // ),
    );
  }
}