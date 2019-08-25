import 'package:flutter/material.dart';
import 'package:cooky/models/recipe.dart';
import 'package:cooky/widget/recipe_title.dart';
import 'package:cooky/ui_elements/detailscreen.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final bool inFavorites;
  final Function onFavoriteButtonPressed;

  RecipeCard(
      {@required this.recipe,
      @required this.inFavorites,
      @required this.onFavoriteButtonPressed});

  @override
  Widget build(BuildContext context) {
    RawMaterialButton _buildFavoriteButton() {
      return RawMaterialButton(
        constraints: const BoxConstraints(minWidth: 40.0, minHeight: 40.0),
        onPressed: () => onFavoriteButtonPressed(recipe.id),
        child: Icon(
          // Conditional expression:
          // show "favorite" icon or "favorite border" icon depending on widget.inFavorites:
          inFavorites == true ? Icons.favorite : Icons.favorite_border,
        ),
        elevation: 2.0,
        fillColor: Colors.white,
        shape: CircleBorder(),
      );
    }

  

    return GestureDetector(
     onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => new DetailScreen(recipe,),
            ),
          ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // We overlap the image and the button by
              // creating a Stack object:
              Stack(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 16.0 / 9.0,
                    child: Image.network(
                      recipe.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    child: _buildFavoriteButton(),
                    top: 2.0,
                    right: 2.0,
                  ),
                ],
              ),
              RecipeTitle(recipe, 15),
            ],
          ),
        ),
      ),
    );
  }
}