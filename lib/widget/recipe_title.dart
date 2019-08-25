import 'package:flutter/material.dart';


import 'package:cooky/models/recipe.dart';

class RecipeTitle extends StatelessWidget {
  final Recipe recipe;
  final double padding;

  RecipeTitle(this.recipe, this.padding);

  @override
  Widget build(BuildContext context) {
    return Padding(
     padding: EdgeInsets.all(padding),
      child: Column(
        // Default value for crossAxisAlignment is CrossAxisAlignment.center.
        // We want to align title and description of recipes left:
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            recipe.title,
            style: Theme.of(context).textTheme.title,
          ),
          // Empty space:
          //SizedBox(height: 5.0),
         
        ],
      ),
    );
  }
}