import 'package:cooky/scoped_models/mainmodel.dart';
import 'package:flutter/material.dart';
import 'package:cooky/models/recipeHalf.dart';
import 'package:scoped_model/scoped_model.dart';

class RecipeCardMain extends StatelessWidget {
  final RecipeHalf recipe;

  RecipeCardMain(
    this.recipe,
  );

  @override
  Widget build(BuildContext context) {
    ScopedModelDescendant<MainModel> _buildFavoriteButton() {
      return ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
        return RawMaterialButton(
          constraints: const BoxConstraints(minWidth: 38.0, minHeight: 38.0),
          onPressed: () {
            model.selectHalfRecipe(recipe.id);
            model.toggleProductFavorite();
          },
          child: model.recipeHalfList_all
                  .firstWhere((RecipeHalf recipe1) => recipe1.id == recipe.id)
                  .isFavourite
              ? Icon(
                  Icons.favorite,
                  color: Colors.redAccent,
                  size: 28,
                )
              : Icon(
                  Icons.favorite_border,
                  color: Colors.redAccent,
                  size: 28,
                ),
          elevation: 2.0,
          fillColor: Colors.white,
          shape: CircleBorder(),
        );
      });
    }

    ScopedModelDescendant<MainModel> _buildVegIcon() {
      return ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
        return model.recipeHalfList_all
                .firstWhere((RecipeHalf recipe1) => recipe1.id == recipe.id)
                .isVeg
            ? Image.asset(
                "assets/veg.png",
                height: 30,
                width: 30,
              )
            : Image.asset("assets/non-veg.png", height: 30, width: 30);
      });
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // We overlap the image and the button by
            // creating a Stack object:
            Expanded(
                flex: 5,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0, 1.5],
                            colors: [Colors.white, Colors.black]),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0)),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0)),
                          child: FadeInImage(
                            placeholder: AssetImage(""),
                            image: NetworkImage(recipe.imageUrl),
                            fit: BoxFit.cover,
                          )),
                    ),
                    Positioned(
                      child: _buildFavoriteButton(),
                      top: 10.0,
                      right: 10.0,
                    ),
                    Positioned(
                      child: _buildVegIcon(),
                      top: 10,
                      left: 10,
                    ),
                    Positioned(
                      bottom: 10.0,
                      right: 10.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.timer,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            recipe.duration + " min",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
            Expanded(
                flex: 2,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0))),
                    child: ListTile(
                      title: Text(
                        recipe.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}
